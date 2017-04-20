
#import "XMGLoginRegisterViewController.h"
#import "XMGLoginRegisterView.h"
#import "XMGFastLoginView.h"

@interface XMGLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftCons;
@property (weak, nonatomic) IBOutlet UIView *middleView;
@end

@implementation XMGLoginRegisterViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    XMGLoginRegisterView *loginView = [XMGLoginRegisterView loginView];
    [_middleView addSubview:loginView];
    XMGLoginRegisterView *registerView = [XMGLoginRegisterView registerView];
    [_middleView addSubview:registerView];
    XMGFastLoginView *fastLoginView = [XMGFastLoginView viewForXib];
    [_bottomView addSubview:fastLoginView];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    UIView *loginView = _middleView.subviews[0];
    loginView.frame = CGRectMake(0, 0, _middleView.width * 0.5, _middleView.height);
    UIView *registerView = _middleView.subviews[1];
     registerView.frame = CGRectMake(_middleView.width * 0.5, 0, _middleView.width * 0.5, _middleView.height);
    UIView *fastLoginView = _bottomView.subviews[0];
    fastLoginView.frame = CGRectMake(0, 0, _bottomView.width, _bottomView.height);
    
}

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)Clickregister:(UIButton *)sender {
    sender.selected = !sender.selected;
    _leftCons.constant = _leftCons.constant == 0? -screenW:0;
    
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
    }];
}

@end
