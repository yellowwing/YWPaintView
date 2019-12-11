//
//  StringSize.m
//  Ai
//
//  Created by Wing on 15-9-17.
//  Copyright (c) 2015年 yellow-wing. All rights reserved.
//

#import "StringSize.h"

@implementation StringSize

//计算文字尺寸
+(CGSize)sizeWithText:(NSString*)text font:(UIFont*)font maxSize:(CGSize)maxSize{
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    
}

@end
