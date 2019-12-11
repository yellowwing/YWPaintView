//
//  UIImage+YW.h
//  DaSheHui
//
//  Created by Wing on 15-9-23.
//  Copyright (c) 2015年 yellow-wing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YW)
+ (UIImage *)resizedImageWithName:(NSString *)name;

+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;


+ (instancetype)captureWithView:(UIView *)view;

@end
