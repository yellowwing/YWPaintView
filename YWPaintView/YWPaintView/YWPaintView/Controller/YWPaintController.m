//
//  YWPaintController.m
//  YWPaintView
//
//  Created by yellow on 2019/12/11.
//  Copyright © 2019 YW. All rights reserved.
//

#import "YWPaintController.h"
#import "YWPaintView.h"
#import "UIImage+YW.h"
#import "MBProgressHUD+MJ.h"

@interface YWPaintController ()

@property (weak, nonatomic) IBOutlet UIButton *blackBtn;
@property (weak, nonatomic) IBOutlet UIButton *redBtn;
@property (weak, nonatomic) IBOutlet UIButton *greenBtn;

- (IBAction)clear;
- (IBAction)back;
- (IBAction)save;
- (IBAction)animation;

- (IBAction)drawBlack;
- (IBAction)drawRed;
- (IBAction)drawGreen;
- (IBAction)drawWidth:(UISlider *)sender;

@property (weak, nonatomic) IBOutlet YWPaintView *paintView;

@end

@implementation YWPaintController

#warning - 另外2份项目：建github☑️、创建项目与配置☑️、创建文件夹☑️、抄☑️、简书、简历2份、看备忘录的demo项

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (IBAction)clear {
    
    [self.paintView clear];
    
    CATransition *anim = [CATransition animation];
//        anim.type = @"cube";
//        anim.subtype = kCATransitionFromTop;
    anim.type = @"pageCurl";
    anim.duration = 0.5;
    [self.paintView.layer addAnimation:anim forKey:nil];
    
}


- (IBAction)back {
    [self.paintView back];
}


- (IBAction)save {

    // 1.截图
    UIImage *image = [UIImage captureWithView:self.paintView];
    
    // 2.保存到图片
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);

    
    CATransition *anim = [CATransition animation];
    //        anim.type = @"cube";
    //        anim.subtype = kCATransitionFromTop;
    anim.type = @"rippleEffect";
    anim.duration = 0.5;
    [self.paintView.layer addAnimation:anim forKey:nil];
    
}

/**
 保存图片操作之后就会调用
 */
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (error) { // 保存失败
            [MBProgressHUD showError:@"保存失败"];
        } else { // 保存成功
            [MBProgressHUD showSuccess:@"保存成功"];
        }

    });
}


- (IBAction)animation {
    [self.paintView animate];
}

- (IBAction)drawBlack {
    
    self.paintView.drawColor = [UIColor blackColor];
}

- (IBAction)drawRed {
    
    self.paintView.drawColor = [UIColor redColor];
}

- (IBAction)drawGreen {
    
    self.paintView.drawColor = [UIColor blueColor];
}

- (IBAction)drawWidth:(UISlider *)sender {
    
    self.paintView.drawWidth = sender.value;
}


@end
