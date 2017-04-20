//
//  VICurveViewController.m
//  ESP3
//
//  Created by 陈浩 on 17/1/15.
//  Copyright © 2017年 Nonvia. All rights reserved.
//

#import "VICurveViewController.h"

@interface VICurveViewController ()

@end

@implementation VICurveViewController
@synthesize closeBtn;
@synthesize webViewForSelectDate;
@synthesize timer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad
{
    UIInterfaceOrientation orientation = [UIDevice currentDevice].orientation;
    if (UIDeviceOrientationIsPortrait(orientation) || orientation == UIDeviceOrientationUnknown)
    {
        if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)])
        {
            [[UIDevice currentDevice] performSelector:@selector(setOrientation:)
                                           withObject:(id)UIDeviceOrientationLandscapeRight];
        }
    }
    self.navigationItem.title=@"VI曲线";
    CGRect webFrame = self.view.frame;
    webFrame.origin.x = 0;
    webFrame.origin.y =  0;
    
    webViewForSelectDate = [[UIWebView alloc] initWithFrame:webFrame];
    webViewForSelectDate.delegate = self;
    webViewForSelectDate.scalesPageToFit = YES;
    webViewForSelectDate.opaque = NO;
    webViewForSelectDate.backgroundColor = [UIColor clearColor];
    webViewForSelectDate.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    [self.view addSubview:webViewForSelectDate];
    
    //所有的资源都在source.bundle这个文件夹里
    NSString* htmlPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"source.bundle/index.html"];
    
    NSURL* url = [NSURL fileURLWithPath:htmlPath];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [webViewForSelectDate loadRequest:request];
    int trueWidth = self.view.frame.size.width;
    if (trueWidth < self.view.frame.size.height && ![UIApplication sharedApplication].statusBarHidden)
    {
        trueWidth = self.view.frame.size.height + MIN([UIApplication sharedApplication].statusBarFrame.size.height,[UIApplication sharedApplication].statusBarFrame.size.width);
    }
    CGRect closeBtnFrame = CGRectMake(trueWidth + 50, 0, 70, 10);
    closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setFrame:closeBtnFrame];
    // closeBtn.backgroundColor = [UIColor redColor];
    [closeBtn setTitle:@"pop关闭" forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closePage) forControlEvents:UIControlEventTouchUpInside];
    [closeBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [closeBtn sizeToFit];
    //[self.view addSubview:closeBtn];
    [self.view bringSubviewToFront:closeBtn];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)closePage
{
    UINavigationController* naviController = (UINavigationController*)[[UIApplication sharedApplication] keyWindow].rootViewController;
    [naviController popViewControllerAnimated:YES];
}
-(void)updateData
{
    //取得当前时间，x轴
    NSDate* nowDate = [[NSDate alloc]init];
    NSTimeInterval nowTimeInterval = [nowDate timeIntervalSince1970] * 1000;
    [nowDate release];
    
    //随机温度，y轴
    int temperature = [self getRandomNumber:20 to:50];
    
    NSMutableString* jsStr = [[NSMutableString alloc] initWithCapacity:0];
    [jsStr appendFormat:@"刷新数据(%f,%d)",nowTimeInterval,temperature];
    
    [webViewForSelectDate stringByEvaluatingJavaScriptFromString:jsStr];
}
//获取一个随机整数，范围在[from,to），包括from，不包括to
-(int)getRandomNumber:(int)from to:(int)to
{
    return (int)(from  + (arc4random() % (to - from + 1)));
}
#pragma mark - delegate of webview
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //等webview加载完毕再更新数据
    timer = [NSTimer scheduledTimerWithTimeInterval: 1
                                             target: self
                                           selector: @selector(updateData)
                                           userInfo: nil
                                            repeats: YES];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIDeviceOrientationIsLandscape(interfaceOrientation);
}
#ifdef __IPHONE_6_0
-(BOOL)shouldAutorotate
{
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    return UIDeviceOrientationIsLandscape(orientation);
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}
#endif

-(void)dealloc
{
    [closeBtn release];
    [webViewForSelectDate release];
    [timer release];
    [super dealloc];
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
