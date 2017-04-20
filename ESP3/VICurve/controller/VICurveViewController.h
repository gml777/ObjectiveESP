//
//  VICurveViewController.h
//  ESP3
//
//  Created by 陈浩 on 17/1/15.
//  Copyright © 2017年 Nonvia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VICurveViewController : UIViewController<UIWebViewDelegate,UITextFieldDelegate>
@property(retain,nonatomic)UIButton* closeBtn;
@property(retain,nonatomic)UIWebView* webViewForSelectDate;
@property(retain,nonatomic)NSTimer* timer;


@end
