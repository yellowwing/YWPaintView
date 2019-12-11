//
//  YWToola.h
//  通信录
//
//  Created by yellow on 16/7/1.
//  Copyright © 2016年 yellow. All rights reserved.
//

#import <Foundation/Foundation.h>



#define Angle2Radian(angle) ((angle) / 180.0 * M_PI)
#define mainColor [UIColor colorWithRed:246/255.0 green:246/255.0 blue:245/255.0 alpha:1]

// 颜色
#define YWColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define YWColorRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

// 随机色
#define YWRandomColor YWColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

@interface YWTool : NSObject

@end
