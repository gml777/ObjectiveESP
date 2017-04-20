//
//  XMGTabBarController.m
//  ESP3
//
//  Created by 陈浩 on 16/12/30.
//  Copyright © 2016年 Nonvia. All rights reserved.
//

#import "XMGTabBarController.h"

@interface XMGTabBarController ()

@end

@implementation XMGTabBarController

static XMGTabBarController *_shareInstanse = nil;

+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareInstanse = [[XMGTabBarController alloc] init];
    });
    return _shareInstanse;
}

- (instancetype)init {
    if (self = [super init]) {
        self.name = @"hello";//for test
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.backgroundColor=XMGGrayColor(238);
  //  self.tabBar.isTranslucent=false;
}
+ (void)load
{
    
    UITabBarItem *item =  [UITabBarItem appearanceWhenContainedIn:self, nil];
    
    NSMutableDictionary *attrSel = [NSMutableDictionary dictionary];
    attrSel[NSForegroundColorAttributeName] = [UIColor blackColor];
    
    [item setTitleTextAttributes:attrSel forState:UIControlStateSelected];
    
    NSMutableDictionary *attrNor = [NSMutableDictionary dictionary];
    attrNor[NSFontAttributeName] = [UIFont systemFontOfSize:10.5];//根据美工要求修改
    [item setTitleTextAttributes:attrNor forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
