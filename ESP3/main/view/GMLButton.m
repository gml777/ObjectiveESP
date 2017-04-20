//
//  GMLButton.m
//  ESP3
//
//  Created by 陈浩 on 2017/2/22.
//  Copyright © 2017年 Nonvia. All rights reserved.
//

#import "GMLButton.h"

@implementation GMLButton


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
}

+ (UIButton *)cornerRadius:(float)radius backgroundColor:(UIColor *)backgroundColor titleColor:(UIColor *)titleColor
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.layer.cornerRadius=radius;//button.frame.size.height*0.1;
    [button setBackgroundColor:backgroundColor];
    [button setTintColor:titleColor];
 /*   [button setImage:image forState:UIControlStateNormal];
    [button setImage:selImage forState:UIControlStateSelected];
    
    [button sizeToFit];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];*/
    
    // 包装到UIView
   // UIView *contentView = [[UIView alloc] initWithFrame:button.bounds];
   // [contentView addSubview:button];
    
    return button;//[[UIButton alloc] initWithCustomView:contentView];
}
@end
