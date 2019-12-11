//
//  ExtensionButton.h
//  Seeds
//
//  Created by Shaolie on 15/8/29.
//  Copyright (c) 2015年 Seed. All rights reserved.
//

#import "ExtensionButton.h"

@interface ExtensionButton ()

@property (nonatomic, strong) NSMutableDictionary *borderColors;
@property (nonatomic, strong) NSMutableDictionary *backgroundColors;

@end

@implementation ExtensionButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setborderColor:(UIColor *)borderColor forState:(UIControlState)state {
    if (borderColor) {
        [self.borderColors setObject:borderColor forKey:@(state)];
    }
    if(self.state == state) {
        self.layer.borderColor = borderColor.CGColor;
    }
}

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state {
    if (backgroundColor) {
        [self.backgroundColors setObject:backgroundColor forKey:@(state)];
    }
    if(self.state == state) {
        self.backgroundColor = backgroundColor;
    }
}

- (UIColor *)borderColorWithState:(UIControlState)state {
    return [self.borderColors objectForKey:@(state)];
}

- (UIColor *)backgroundColorWithState:(UIControlState)state {
    
    return [self.backgroundColors objectForKey:@(state)];
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    if (selected) {
        self.backgroundColor = [self backgroundColorWithState:UIControlStateSelected];
        self.layer.borderColor = [self borderColorWithState:UIControlStateSelected].CGColor;
    } else {
        self.backgroundColor = [self backgroundColorWithState:UIControlStateNormal];
        self.layer.borderColor = [self borderColorWithState:UIControlStateNormal].CGColor;
    }
}

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    
    if (enabled) {
        self.backgroundColor = [self backgroundColorWithState:UIControlStateNormal];
        self.layer.borderColor = [self borderColorWithState:UIControlStateNormal].CGColor;
    } else {
        self.backgroundColor = [self backgroundColorWithState:UIControlStateDisabled];
        self.layer.borderColor = [self borderColorWithState:UIControlStateDisabled].CGColor;
    }
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:backgroundColor];
    
//    [self setBackgroundColor:backgroundColor forState:(UIControlStateNormal)];
}


- (NSMutableDictionary *)borderColors {
    if(!_borderColors) {
        _borderColors = [[NSMutableDictionary alloc] init];
        UIColor *borderColor = [UIColor colorWithCGColor:self.layer.borderColor];
        UIColor *clearColor = [UIColor clearColor];
        if (borderColor) {
            [_borderColors setObject:borderColor forKey:@(UIControlStateNormal)];
            [_borderColors setObject:clearColor forKey:@(UIControlStateSelected)];
            [_borderColors setObject:clearColor forKey:@(UIControlStateHighlighted)];
            [_borderColors setObject:clearColor forKey:@(UIControlStateDisabled)];
            [_borderColors setObject:clearColor forKey:@(UIControlStateApplication)];
            [_borderColors setObject:clearColor forKey:@(UIControlStateReserved)];
        }
    }
    return _borderColors;
}

- (NSMutableDictionary *)backgroundColors {
    if(!_backgroundColors) {
        _backgroundColors = [[NSMutableDictionary alloc] init];
        UIColor *backgroundColor = self.backgroundColor;

        if (backgroundColor) {
            [_backgroundColors setObject:backgroundColor forKey:@(UIControlStateNormal)];
            [_backgroundColors setObject:backgroundColor forKey:@(UIControlStateSelected)];
            [_backgroundColors setObject:backgroundColor forKey:@(UIControlStateHighlighted)];
            [_backgroundColors setObject:backgroundColor forKey:@(UIControlStateDisabled)];
            [_backgroundColors setObject:backgroundColor forKey:@(UIControlStateApplication)];
            [_backgroundColors setObject:backgroundColor forKey:@(UIControlStateReserved)];
        }
    }
    return _backgroundColors;
}

@end
