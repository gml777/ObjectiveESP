
#import "XMGLoginRegisterField.h"
#import "XMGNavigationController.h"
#import "XMGLoginRegisterView.h"
#import "GMLHighFrequencyListViewcontroller.h"
#import "AppDelegate.h"
@interface XMGLoginRegisterView()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet XMGLoginRegisterField *unameText;
@property (weak, nonatomic) IBOutlet XMGLoginRegisterField *upassText;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;

@end

@implementation XMGLoginRegisterView

// 把对象所有在xib中属性全部加载完
- (void)awakeFromNib
{
    [super awakeFromNib];
    UIImage *image = _loginButton.currentBackgroundImage;
    image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    // 设置登录按钮背景图片
    [_loginButton setBackgroundImage:image forState:UIControlStateNormal];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dragUp) name:UIKeyboardDidShowNotification object:nil];
}
-(void)dragUp
{
   // NSLog(@"fff");
  //  self.tipLabel.text=@"账号密码不对，无法登录";
   // self.tipLabel.hidden=NO;
  //  self.inputView;//.frame.origin.y -= 50;
    CGRect frame = self.unameText.frame;
    
    CGFloat heights = self.inputView.frame.size.height;
    
    // 当前点击textfield的坐标的Y值 + 当前点击textFiled的高度 - （屏幕高度- 键盘高度 - 键盘上tabbar高度）
    
    // 在这一部 就是了一个 当前textfile的的最大Y值 和 键盘的最全高度的差值，用来计算整个view的偏移量
    
    int offset = frame.origin.y + 42- ( heights - 216.0-35.0);//键盘高度216
    
    NSTimeInterval animationDuration = 0.30f;
    
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    
    [UIView setAnimationDuration:animationDuration];
    
    float width = self.inputView.frame.size.width;
    
    float height = self.inputView.frame.size.height;
    
    if(offset > 0)
        
    {
        
        CGRect rect = CGRectMake(0.0f, -offset,width,height);
        
        self.inputView.frame = rect;
        
    }
    
    [UIView commitAnimations];
}

+ (instancetype)loginView
{
    return [[NSBundle mainBundle] loadNibNamed:@"XMGLoginView" owner:nil options:nil][0];
}
+ (instancetype)registerView
{
    return [[NSBundle mainBundle] loadNibNamed:@"XMGLoginView" owner:nil options:nil][1];
}
- (IBAction)GotoHFPowerList:(id)sender {
   /* GMLHighFrequencyListViewcontroller *highFrequencyList = [[GMLHighFrequencyListViewcontroller alloc]init];
    XMGNavigationController *nav = [[XMGNavigationController alloc]initWithRootViewController:highFrequencyList];
    [UIApplication sharedApplication].keyWindow.rootViewController = nav;*/
    
    
    NSString *uname=self.unameText.text;
    NSString *upass=self.upassText.text;
    uname=[uname stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    upass=[upass stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
  //  if (([uname isEqualToString:@"nonvia1"] && [upass isEqualToString:@"nonvia1"]) || ([uname isEqualToString:@"nonvia2"] && [upass isEqualToString:@"nonvia2"]) || ([uname isEqualToString:@"nonvia3"] && [upass isEqualToString:@"nonvia3"])) {
        self.tipLabel.hidden=YES;
        GMLHighFrequencyListViewcontroller *highFrequencyList = [[GMLHighFrequencyListViewcontroller alloc]init];
        XMGNavigationController *nav = [[XMGNavigationController alloc]initWithRootViewController:highFrequencyList];
        [UIApplication sharedApplication].keyWindow.rootViewController = nav;
   // }
  //  else{
    UIAlertController *alert1=[UIAlertController alertControllerWithTitle:@"账号密码不对，无法登录" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction1=[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert1 addAction:okAction1];
     self.tipLabel.text=@"账号密码不对，无法登录";
        self.tipLabel.hidden=NO;
  //  }
}

- (IBAction)GotoRegister:(id)sender {
}
@end
