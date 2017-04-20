//
//  addConfigureViewController.m
//  ESP3
//
//  Created by 陈浩 on 2017/2/21.
//  Copyright © 2017年 Nonvia. All rights reserved.
//

#import "addConfigureViewController.h"
#import <sqlite3.h>
@interface addConfigureViewController ()
@property (weak, nonatomic) IBOutlet UITextField *addName;
@property (weak, nonatomic) IBOutlet UITextField *addIPAddress;
@property (weak, nonatomic) IBOutlet UITextField *addPortNumber;
@property (weak, nonatomic) IBOutlet UITextField *addDeviceID;
@property (weak, nonatomic) IBOutlet UITextField *addCommunicationStatus;
@property (weak, nonatomic) IBOutlet UITextField *addAlarmStatus;

@end

@implementation addConfigureViewController
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    for (UITextField *view in self.view.subviews) {
        [view resignFirstResponder];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (BOOL)isValidatIP:(NSString *)ipAddress{
    
    NSString  *urlRegEx =@"^([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])$";
    
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    return [urlTest evaluateWithObject:ipAddress];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)addConfigure:(id)sender {
  //  sender.selected;
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"你确定要添加这一组配置吗？" message:@"想好了？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction=[UIAlertAction actionWithTitle:@"添加" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        [self insertData];
      //  sender.selected = !sender.selected;
    }];
    [alert addAction:okAction];
    UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        return ;
    }];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)insertData
{
    NSString *mingzi=self.addName.text;
    NSString *ipdizhi=self.addIPAddress.text;
    NSString *zhuangtai=@"运行";//self.zhuangtaiText.text;
    NSString *duankouhao=self.addPortNumber.text;
    NSString *shebeihao=self.addDeviceID.text;
    mingzi=[mingzi stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    ipdizhi=[ipdizhi stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    zhuangtai=[zhuangtai stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    duankouhao=[duankouhao stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    shebeihao=[shebeihao stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (![self isValidatIP:ipdizhi] || [mingzi isEqualToString:@""] || [ipdizhi isEqualToString:@""] || [zhuangtai isEqualToString:@""] || [duankouhao isEqualToString:@""] || [shebeihao isEqualToString:@""]) {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"输入的IP地址不对或有未输入项" message:@"抱歉，请重新填写！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction=[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
        return ;
    }
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    path=[path stringByAppendingPathComponent:@"mydb.sqlite"];
    sqlite3 *db;
    int result = sqlite3_open([path UTF8String], &db);
    if (result != SQLITE_OK) {
        NSLog(@"open failed");
    }
    char *sql="CREATE TABLE if not exists t_modbusConnectConfigure ('mingzi' text(4,0) NOT NULL,'ipdizhi' text(15,0) NOT NULL,'zhuangtai' text NOT NULL,'duankouhao' integer NOT NULL,'shebeihao' integer NOT NULL,'IDNO' integer NOT NULL,PRIMARY KEY('IDNO'));";
    char *error;
    result=sqlite3_exec(db, sql, NULL, NULL, &error);
    if (result != SQLITE_OK) {
        NSLog(@"run sql failed:%s",error);
    }
    NSString *gml=[NSString stringWithFormat:@"insert into t_modbusConnectConfigure(mingzi, ipdizhi,zhuangtai,duankouhao,shebeihao) values('%@', '%@', '%@', %@, %@)",mingzi,ipdizhi,zhuangtai,duankouhao,shebeihao];
    
    result=sqlite3_exec(db, [gml UTF8String], NULL, NULL, &error);
    if (result != SQLITE_OK) {
        NSLog(@"run sql failed:%s",error);
    }
    sqlite3_close(db);
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
