//
//  YWPaintView.m
//  通信录
//
//  Created by yellow on 16/6/30.
//  Copyright © 2016年 yellow. All rights reserved.
//

#import "YWPaintView.h"

@interface YWPaintView ()
@property(nonatomic,strong)NSMutableArray *totalPathPoints;
@property(nonatomic,strong)NSMutableArray *animateTotalPathPoints;

/**
 *  定时器
 */
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation YWPaintView


-(void)setDrawColor:(UIColor *)drawColor{

    _drawColor = drawColor;
    
    [self setNeedsDisplay];
    
}

-(void)setDrawWidth:(CGFloat)drawWidth{

    _drawWidth = drawWidth;
    
    [self setNeedsDisplay];

}



-(NSMutableArray*)totalPathPoints{

    if (_totalPathPoints == nil) {
        _totalPathPoints = [NSMutableArray array];
    }
    return _totalPathPoints;
}

-(NSMutableArray*)animateTotalPathPoints{
    
    if (_animateTotalPathPoints == nil) {
        _animateTotalPathPoints = [NSMutableArray array];
    }
    return _animateTotalPathPoints;
}


- (void)clear
{
    [self.totalPathPoints removeAllObjects];
    [self setNeedsDisplay];
}

- (void)back
{
    [self.totalPathPoints removeLastObject];
    [self setNeedsDisplay];
}

- (void)animate{
    
    if (self.totalPathPoints.count == 0) {
        return;
    }
    
    self.animateTotalPathPoints = [NSMutableArray arrayWithArray:self.totalPathPoints];
    
    [self clear];

     [self addTimer];
}

/**
 *  添加定时器
 */
- (void)addTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(update) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

/**
 *  移除定时器
 */
- (void)removeTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

-(void)update{
    
    //将动画数组第一个路径取出，再从第一个路径取出第一个点
    NSMutableArray *points = self.animateTotalPathPoints.firstObject;
    NSValue *pointValue = points.firstObject;

    if (self.totalPathPoints.count == 0) {//刚刚开始
        //添加到self.totalPathPoints
        NSMutableArray *pathPoints = [NSMutableArray array];
        [pathPoints addObject:pointValue];
        [self.totalPathPoints addObject:pathPoints];
    }
    else{//不是刚刚开始
        
        //取出self.totalPathPoints最后一个路径
        NSMutableArray *pathPoints = [self.totalPathPoints lastObject];
        [pathPoints addObject:pointValue];
    }
    
    //且动画数组的第一个路径的第一个点要删除
    [points removeObject:pointValue];
    
    //若第一路径也为空，就删除第一路径
    if (points.count == 0) {
        
        [self.animateTotalPathPoints removeObject:points];
        
        if (self.animateTotalPathPoints.count == 0) {
            
            //若self.animateTotalPathPoints全都被删光了，就移除定时器
            [self removeTimer];
            
        }
        else{
            
            //若self.animateTotalPathPoints还没有被删光，就应该添加一个新数组到self.totalPathPoints，留给下一次备用
            NSMutableArray *pathPoints = [NSMutableArray array];
            [self.totalPathPoints addObject:pathPoints];

        }
    }

    //重绘
    [self setNeedsDisplay];
    
}

//确定起点
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    CGPoint startPoint = [touch locationInView:touch.view];
    // 每一次开始触摸, 就新建一个数组来存放这次触摸过程的所有点(这次触摸过程的路径)
    NSMutableArray *pathPoints = [NSMutableArray array];
    [pathPoints addObject:[NSValue valueWithCGPoint:startPoint]];
    
    // 添加这次路径的所有点到大数组中
    [self.totalPathPoints addObject:pathPoints];
    

    [self setNeedsDisplay];
}

//连线
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:touch.view];
    // 取出这次路径对应的数组
    NSMutableArray *pathPoints = [self.totalPathPoints lastObject];
    [pathPoints addObject:[NSValue valueWithCGPoint:currentPoint]];
    
    [self setNeedsDisplay];

}

//连线
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self touchesMoved:touches withEvent:event];
}


-(void)drawRect:(CGRect)rect{
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    for (NSMutableArray *pathPoints in self.totalPathPoints) {
        for (int i = 0; i<pathPoints.count; i++) { // 一条路径
            CGPoint pos = [pathPoints[i] CGPointValue];
            if (i == 0) {
                CGContextMoveToPoint(ctx, pos.x, pos.y);
                CGContextAddLineToPoint(ctx, pos.x, pos.y);
            } else {
                CGContextAddLineToPoint(ctx, pos.x, pos.y);
            }
        }
    }
    
    
    if (self.drawColor == nil) {
        _drawColor = [UIColor blackColor];
    }
    if (self.drawWidth == 0) {
        _drawWidth = 10;
    }
 
    [self.drawColor set];
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    CGContextSetLineWidth(ctx, self.drawWidth);
    CGContextStrokePath(ctx);
}
@end
