//
//  StringSize.h
//  Ai
//
//  Created by Wing on 15-9-17.
//  Copyright (c) 2015年 yellow-wing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface StringSize : NSObject

//计算文字尺寸
+(CGSize)sizeWithText:(NSString*)text font:(UIFont*)font maxSize:(CGSize)maxSize;

@end
