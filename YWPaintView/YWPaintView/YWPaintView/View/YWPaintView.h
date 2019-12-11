//
//  YWPaintView.h
//  通信录
//
//  Created by yellow on 16/6/30.
//  Copyright © 2016年 yellow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@interface YWPaintView : UIView

- (void)clear;
- (void)back;
- (void)animate;

@property(nonatomic,strong)UIColor *drawColor;

@property(nonatomic,assign)CGFloat drawWidth;

@end
