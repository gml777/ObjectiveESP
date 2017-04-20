//
//  XMGNavigationController.m
//  ESP3
//
//  Created by 陈浩 on 16/12/30.
//  Copyright © 2016年 Nonvia. All rights reserved.
//

#import "XMGNavigationController.h"

@interface XMGNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation XMGNavigationController


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
+ (void)load
{
    // 获取导航条
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    
    // 设置导航条(我,关注)标题字体,由导航条决定
    // 总结:导航条标题字体,必须在显示之前设置.
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = [UIFont boldSystemFontOfSize:17];
    [navBar setTitleTextAttributes:attr];
    
    // 设置导航条背景图片
    [navBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}

// 重写系统底层方法
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 只有非根控制才需要设置返回按钮
    if (self.childViewControllers.count > 0) { // 非控制器
        UIButton *backButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [backButton sizeToFit];
        backButton.contentEdgeInsets=UIEdgeInsetsMake(0, -20, 0, 0);
        viewController.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:backButton];
        // viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem backItemWithImage:[UIImage imageNamed:@"navigationButtonReturn"] highImage:[UIImage imageNamed:@"navigationButtonReturnClick"] target:self action:@selector(back) title:@"返回"];
        viewController.hidesBottomBarWhenPushed=YES;
    }
    
    
    // 才是真正在执行跳转
    [super pushViewController:viewController animated:animated];
}

- (void)back
{//XMGLogFunc
    [self popViewControllerAnimated:YES];
   // NSLog(@"我pop了");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 假死状态:程序在运行,但是界面操作不了
    
    // 全屏滑动:为什么我们只能边缘滑动
    // 搞一个Pan替换调系统边缘滑动手势
    self.interactivePopGestureRecognizer.enabled = NO;
    
    // 全屏手势,滑动返回功能 =>
    id target = self.interactivePopGestureRecognizer.delegate;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    
    [self.view addGestureRecognizer:pan];
    
    // 处理假死状态
    pan.delegate = self;
    
}

// 重写系统底层方法
/*- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 导航控制器自带滑动返回功能,iOS7
    // 只有非根控制才需要设置返回按钮
    if (self.childViewControllers.count > 0) { // 非控制器
        // 设置返回按钮,把系统的返回按钮覆盖,滑动返回功能就没有了
        // 恢复滑动返回功能 => 为什么滑动返回功能没有? 1.有个手势在处理,可能把手势清空 ×
        viewController.hidesBottomBarWhenPushed = YES;
        
        // 2.手势代理做了事情,导致手势失效,从而滑动返回功能没有
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem backItemWithImage:[UIImage imageNamed:@"navigationButtonReturn"] highImage:[UIImage imageNamed:@"navigationButtonReturnClick"] target:self action:@selector(back) title:@"返回"];
        
    }
    
    // 才是真正在执行跳转
    [super pushViewController:viewController animated:animated];
}*/


#pragma mark - UIGestureRecognizerDelegate
// 是否触发手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    // 只有非根控制器才需要滑动返回功能
    return self.childViewControllers.count > 1;
}
@end
