//
//  configureViewController.h
//  ModbusDemo
//
//  Created by 陈浩 on 17/1/3.
//
//

#import <UIKit/UIKit.h>

@interface configureViewController : UIViewController
@property (weak, nonatomic) IBOutlet configureViewController *configure;
//+ (BOOL)isValidatIP:(NSString *)ipAddress;
-(void)selectData;
@property (weak, nonatomic) IBOutlet UITextField *mingziText;
@property (weak, nonatomic) IBOutlet UITextField *ipdizhiText;
@property (weak, nonatomic) IBOutlet UITextField *zhuangtaiText;
@property (weak, nonatomic) IBOutlet UITextField *duankouhaoText;
@property (weak, nonatomic) IBOutlet UIButton *operateButton;
@property (weak, nonatomic) IBOutlet UITextField *shebeihaoText;

@end
