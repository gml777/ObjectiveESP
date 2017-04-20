

#import "XMGFriendTrendViewController.h"
#import "XMGLoginRegisterViewController.h"
@interface XMGFriendTrendViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@end

@implementation XMGFriendTrendViewController

#pragma mark - 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
#if TARGET_IPHONE_SIMULATOR
    
#else
    [self createEditableCopyOfDatabaseIfNeeded];
#endif
}

#pragma mark - 设置导航条内容
- (void)setupNavigationBar
{
}

- (void)friendsRecomment
{
    
}
- (IBAction)clickLoginRegister {
    
 
    XMGLoginRegisterViewController *loginRegisterVc = [[XMGLoginRegisterViewController alloc] init];
    
    // modal
    [self presentViewController:loginRegisterVc animated:YES completion:nil];
}
-(void)createEditableCopyOfDatabaseIfNeeded
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    

    
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"mydb.sqlite"];
    BOOL ifFind = [fileManager fileExistsAtPath:writableDBPath];
    if (ifFind)
    {
        // NSLog(@"数据库已存在");
        return;
    }
    else{
      //  NSLog(@"数据库不存在,需要复制");
    }
    // 如果不存在数据库文件，则复制数据库文件
  //  NSLog(@"[NSBundle mainBundle]是%@",[NSBundle mainBundle]);
    /*
     NSBundle </private/var/mobile/Containers/Bundle/Application/0F29B1F5-54C0-459F-B3C2-C17F0CF62E27/ESP3.app> (loaded)
     NSBundle </private/var/mobile/Containers/Bundle/Application/75291FDA-EA21-49B0-807F-FFBE6A0DA6DE/ESP3.app> (loaded)
     NSBundle </private/var/mobile/Containers/Bundle/Application/37AC6FBC-1682-4AA6-8F83-973BE952DE54/ESP3.app> (loaded)
     */
    NSString *defaultDBPath = [[NSBundle mainBundle] pathForResource:@"mydb" ofType:@"sqlite"];
    // NSLog(@"%@",defaultDBPath);
    BOOL ifSuccess = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
    if (!ifSuccess) {
      //  NSLog(@"Failed to create writable database file with message '%@'.", [error localizedDescription]);
    }else {
      //  NSLog(@"createEditableCopyOfDatabaseIfNeeded 初始化成功");
    }
    return;
}
@end
