//
//  modifyConfigureViewController.h
//  ESP3
//
//  Created by 陈浩 on 2017/2/21.
//  Copyright © 2017年 Nonvia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface modifyConfigureViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *modifyName;
@property (weak, nonatomic) IBOutlet UITextField *modifyIPAddress;
@property (weak, nonatomic) IBOutlet UITextField *modifyPortNumber;
@property (weak, nonatomic) IBOutlet UITextField *modifyDeviceID;
@property (weak, nonatomic) IBOutlet UITextField *modifyCommunicationStatus;
@property (weak, nonatomic) IBOutlet UITextField *modifyAlarmStatus;
@property(nonatomic,strong)HighFrequencyList *itemBeforeModify;//这个用来保存修改之前的东西
@end
