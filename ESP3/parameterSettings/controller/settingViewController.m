//
//  settingViewController.m
//  ModbusDemo
//
//  Created by 陈浩 on 16/12/22.
//
//
#import <QuartzCore/QuartzCore.h>
#import "settingViewController.h"
#import "GMLHighFrequencyListViewcontroller.h"
#import "configureViewController.h"
@interface settingViewController ()<UITextFieldDelegate>
{
    //ObjectiveLibModbus *settingLibModbus;
}
@property(nonatomic,weak)NSTimer *timer;
@end

@implementation settingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];

    [self setupNavBar];
    [self setParameter];
 //   settingLibModbus = [[ObjectiveLibModbus alloc] initWithTCP:currentIPAddress port:currentPort device:currentdeviceID];
    //    settingLibModbus = [[ObjectiveLibModbus alloc] initWithTCP:GMLIPAddress port:502 device:GMLDevice];
 /*   [singletonModbus connect:^{
        
    } failure:^(NSError *error) {
      //  NSLog(@"参数设置创建连接错误:%@",error.localizedDescription);
        self.u2Limit.text = @"?";
        self.i2Limit.text=@"?";
        self.hhlLimit.text = @"?";
        self.hhlmd.text=@"?";
     //   self.HWsparks.text = @"?";
    }];*/
   /* UITextField *input = [[UITextField alloc]initWithFrame:CGRectMake(screenW / 2.0 - 30, 70, 60, 30)];
    input.layer.borderColor = [UIColor grayColor].CGColor;
    //input.layer.borderWidth = 2.0f;
    [input setBorderStyle:UITextBorderStyleRoundedRect];
    input.keyboardType = UIKeyboardTypeDecimalPad;
    [self.view addSubview:input];*/
  //  self.interval = GMLTimerInterval;
    [self startTimer];
}

-(void)startTimer
{
    if(self.timer) return;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:GMLTimerInterval target:self selector:@selector(runStateLibModbusRead) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

-(void)stopTimer
{
    [self.timer invalidate];
    self.timer = nil;
    [singletonModbus disconnect];
   // XMGLogFunc
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self startTimer];
    [singletonModbus connect:^{
        
    } failure:^(NSError *error) {
        // NSLog(@"参数设置视图将要出现%@",error.localizedDescription);
        self.u2Limit.text = @"?";
        self.i2Limit.text=@"?";
        self.hhlLimit.text = @"?";
        self.hhlmd.text=@"?";
    }];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self stopTimer];
}


-(void)setInterval:(NSTimeInterval)interval
{
    _interval = interval;
    [self stopTimer];
    [self startTimer];
    [singletonModbus disconnect];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = currentName;//@"1A4";
}

-(void)runStateLibModbusRead
{
    [singletonModbus readRegistersFrom:(1043 - 1) count:5 success:^(NSArray *array) {
        self.u2Limit.text = [NSString stringWithFormat:@"%@",array[0]];
        self.i2Limit.text = [NSString stringWithFormat:@"%@",array[1]];
        //self.iLimit.text = [NSString stringWithFormat:@"%@",array[3]];
        self.hhlLimit.text = [NSString stringWithFormat:@"%@",array[4]];
    } failure:^(NSError *error) {
       // NSLog(@"error in setting read 1043~1048:%@",error.localizedDescription);
        self.u2Limit.text = @"?";
        self.i2Limit.text=@"?";
        self.hhlLimit.text = @"?";
       // self.hhlmd.text=@"?";
    }];
    [singletonModbus readRegistersFrom:(1059 - 1) count:1 success:^(NSArray *array) {
        self.hhlmd.text = [NSString stringWithFormat:@"%.1f",[array[0] integerValue]/ 10.0];
    } failure:^(NSError *error) {
      //  NSLog(@"error in setting read 1059:%@",error.localizedDescription);
       
        self.hhlmd.text=@"?";
    }];
  // XMGLogFunc
}

-(void)dealloc
{
    [singletonModbus disconnect];
    singletonModbus = nil;
}

-(void)setParameter
{
    CGFloat originX = 31, originY = 108, labelWidth = 108,labelHeight = 20, deltaY = 63, textHeight = 45,unitWidth = 53, jianju = 14;
    if (iPhone6 || iPhone6P) {
        unitWidth = 60;
    }
    CGFloat  editWidth = screenW - 2 * originX - 2 * jianju - labelWidth - unitWidth;
    UILabel *newtitle=[[UILabel alloc]initWithFrame:CGRectMake(originX, originY* 0.75, screenW - 2 * originX, labelHeight)];
    newtitle.text=@"参数设置";
    newtitle.textAlignment=NSTextAlignmentCenter;
    newtitle.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:20];
    [self.view addSubview:newtitle];
    NSArray *alarmList = [NSArray arrayWithObjects:@"二次电压限制", @"二次电流限制",  @"火花率限制", @"火花灵敏度", nil];
    for(int  i = 0; i < alarmList.count; i++)
    {
        UIView *backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, XMGNavBarMaxY + deltaY * (i + 1)-13, screenW, 45)];
        backgroundView.backgroundColor=XMGColor(238, 238, 238);
        [self.view addSubview:backgroundView];
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(originX - 2, XMGNavBarMaxY + deltaY * (i + 1), labelWidth, labelHeight)];
        label.text=alarmList[i];
        [self.view addSubview:label];
    }
    
    NSArray *unitList = [NSArray arrayWithObjects:@"kV", @"mA", @"spm", @"kV/ms", nil];
    
    for(int  i = 0; i < alarmList.count; i++)
    {
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(screenW - originX - unitWidth + jianju, XMGNavBarMaxY + deltaY * (i + 1), unitWidth, labelHeight)];
        label.text=unitList[i];
        [self.view addSubview:label];
    }
   // CGFloat y1 = (textHeight - labelHeight) / 2.0;
    UITextField *u2Limit=[[UITextField alloc]initWithFrame:CGRectMake(originX + labelWidth + jianju, XMGNavBarMaxY + deltaY * 1-13, editWidth, textHeight)];
    //u1Text.text=@"一次电压";
    [u2Limit setBorderStyle:UITextBorderStyleRoundedRect];
    u2Limit.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:u2Limit];
    self.u2Limit = u2Limit;
   // u2Limit.delegate = self;
    u2Limit.keyboardType = UIKeyboardTypeDecimalPad;
    UITextField *tempu2 = [[UITextField alloc]initWithFrame:CGRectMake(originX + labelWidth - 2 + jianju, XMGNavBarMaxY + deltaY * 1 - 2-13 , editWidth + 4, textHeight + 4)];
    [tempu2 setBorderStyle:UITextBorderStyleRoundedRect];
    tempu2.layer.borderColor = [UIColor blueColor].CGColor;
    tempu2.layer.borderWidth = 4.0f;
    tempu2.keyboardType = UIKeyboardTypeDecimalPad;
    tempu2.textAlignment=NSTextAlignmentCenter;
   // tempu2.delegate = self;
    [self.view addSubview:tempu2]; self.tempu2 = tempu2;
    tempu2.hidden = YES;
    [u2Limit addTarget:self action:@selector(u2Edit) forControlEvents:UIControlEventEditingDidBegin];
    UITextField *i2Limit=[[UITextField alloc]initWithFrame:CGRectMake(originX + labelWidth + jianju, XMGNavBarMaxY + deltaY * 2-13, editWidth, textHeight)];
    //i1Text.text=@"一次电流";
    [i2Limit setBorderStyle:UITextBorderStyleRoundedRect];
    i2Limit.textAlignment=NSTextAlignmentCenter;
    i2Limit.keyboardType = UIKeyboardTypeDecimalPad;
    [self.view addSubview:i2Limit];
    self.i2Limit = i2Limit;
//    UITextField *tempi2 = [[UITextField alloc]initWithFrame:CGRectMake(originX + labelWidth - 2 + jianju, XMGNavBarMaxY + deltaY * 2 - 2-13 , editWidth + 4, textHeight + 4)];
        UITextField *tempi2 = [[UITextField alloc]initWithFrame:CGRectMake(originX + labelWidth - 2 + jianju, XMGNavBarMaxY + deltaY * 2 - 2-13 , editWidth + 4, textHeight + 4)];
    [tempi2 setBorderStyle:UITextBorderStyleRoundedRect];
    tempi2.layer.borderColor = [UIColor blueColor].CGColor;
    tempi2.layer.borderWidth = 4.0f;
    tempi2.keyboardType = UIKeyboardTypeDecimalPad;
    tempi2.textAlignment=NSTextAlignmentCenter;
    // tempu2.delegate = self;
    [self.view addSubview:tempi2]; self.tempi2 = tempi2;
    tempi2.hidden = YES;
    [i2Limit addTarget:self action:@selector(i2Edit) forControlEvents:UIControlEventEditingDidBegin];
    UITextField *hhlLimit=[[UITextField alloc]initWithFrame:CGRectMake(originX + labelWidth + jianju, XMGNavBarMaxY + deltaY * 3-13, editWidth, textHeight)];
    //i2Text.text=@"二次电压";
    [hhlLimit setBorderStyle:UITextBorderStyleRoundedRect];
    hhlLimit.textAlignment=NSTextAlignmentCenter;
    hhlLimit.keyboardType = UIKeyboardTypeDecimalPad;
    [self.view addSubview:hhlLimit];
    self.hhlLimit = hhlLimit;
    UITextField *temphhlLimit = [[UITextField alloc]initWithFrame:CGRectMake(originX + labelWidth - 2 + jianju, XMGNavBarMaxY + deltaY * 3 - 2 -13, editWidth + 4, textHeight + 4)];
    [temphhlLimit setBorderStyle:UITextBorderStyleRoundedRect];
    temphhlLimit.layer.borderColor = [UIColor blueColor].CGColor;
    temphhlLimit.layer.borderWidth = 4.0f;
    temphhlLimit.keyboardType = UIKeyboardTypeDecimalPad;
    temphhlLimit.textAlignment=NSTextAlignmentCenter;
    // tempu2.delegate = self;
    [self.view addSubview:temphhlLimit]; self.temphhlLimit = temphhlLimit;
    temphhlLimit.hidden = YES;
    [hhlLimit addTarget:self action:@selector(hhlLimitEdit) forControlEvents:UIControlEventEditingDidBegin];
    UITextField *hhlmd=[[UITextField alloc]initWithFrame:CGRectMake(originX + labelWidth + jianju, XMGNavBarMaxY + deltaY * 4-13, editWidth, textHeight)];
    //hhlText.text=@"火花率";
    [hhlmd setBorderStyle:UITextBorderStyleRoundedRect];
    hhlmd.textAlignment=NSTextAlignmentCenter;
    hhlmd.keyboardType = UIKeyboardTypeDecimalPad;
    [self.view addSubview:hhlmd];
    self.hhlmd = hhlmd;
    UITextField *temphhlmd = [[UITextField alloc]initWithFrame:CGRectMake(originX + labelWidth - 2 + jianju, XMGNavBarMaxY + deltaY * 4 - 2 -13, editWidth + 4, textHeight + 4)];
    [temphhlmd setBorderStyle:UITextBorderStyleRoundedRect];
    temphhlmd.layer.borderColor = [UIColor blueColor].CGColor;
    temphhlmd.layer.borderWidth = 4.0f;
    temphhlmd.keyboardType = UIKeyboardTypeDecimalPad;
    temphhlmd.textAlignment=NSTextAlignmentCenter;
    // tempu2.delegate = self;
    [self.view addSubview:temphhlmd]; self.temphhlmd = temphhlmd;
    temphhlmd.hidden = YES;
    [hhlmd addTarget:self action:@selector(hhlmdEdit) forControlEvents:UIControlEventEditingDidBegin];
  /*  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown::) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];*/

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    for (UITextField *textField in self.view.subviews) {
        if ([self.tempu2 isFirstResponder] == YES) {
            [self.tempu2 resignFirstResponder];
            [self stopTimer];
            [singletonModbus writeRegister:(1043 - 1) to:[self.tempu2.text intValue] success:^{
                [self startTimer];
            } failure:^(NSError *error) {
                NSLog(@"写二次电流限制出错%@",error.localizedDescription);
            }];
        }
        else if ([self.tempi2 isFirstResponder] == YES){
           // NSLog(@"ss");
            [self.tempi2 resignFirstResponder];
            [self stopTimer];
            [singletonModbus writeRegister:(1044 - 1) to:[self.tempi2.text intValue] success:^{
                [self startTimer];
            } failure:^(NSError *error) {
                NSLog(@"写二次电流限制错误%@",error.localizedDescription);
            }];
        }
      
        else if ([self.temphhlLimit isFirstResponder] == YES){
            [self.temphhlLimit resignFirstResponder];
            [self stopTimer];
            [singletonModbus writeRegister:(1047 - 1) to:[self.temphhlLimit.text intValue] success:^{
                [self startTimer];
            } failure:^(NSError *error) {
                NSLog(@"写火花率限制出错%@",error.localizedDescription);
            }];
        }
        else if ([self.temphhlmd isFirstResponder] == YES){
            [self.temphhlmd resignFirstResponder];
            [self stopTimer];
            [singletonModbus writeRegister:(1059 - 1) to:[self.temphhlmd.text intValue] success:^{
                [self startTimer];
            } failure:^(NSError *error) {
                NSLog(@"写火花灵敏度出错%@",error.localizedDescription);
            }];
        }
        self.u2Limit.hidden = NO;
        self.tempu2.hidden = YES;
        self.i2Limit.hidden = NO;
        self.tempi2.hidden = YES;
        self.hhlLimit.hidden = NO;
        self.temphhlLimit.hidden = YES;
        self.hhlmd.hidden = NO;
        self.temphhlmd.hidden = YES;
    }
}
-(void)hhlmdEdit
{
    self.hhlmd.hidden = YES;
    self.temphhlmd.hidden = NO;
    [self.hhlmd resignFirstResponder];
    [self.temphhlmd becomeFirstResponder];
}
-(void)hhlLimitEdit
{
    self.hhlLimit.hidden = YES;
    self.temphhlLimit.hidden = NO;
    [self.hhlLimit resignFirstResponder];
    [self.temphhlLimit becomeFirstResponder];
}
-(void)i2Edit
{
    [self.tempi2 resignFirstResponder];
    self.i2Limit.hidden = YES;
    self.tempi2.hidden = NO;
    [self.i2Limit resignFirstResponder];
    [self.tempi2 becomeFirstResponder];
}
/*
-(void)keyboardWasShown:(NSNotification *) aNotification
{
    NSLog(@"was shown");
    self.u2Limit.hidden = YES;
    CGRect keyboardFrame = [[[aNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGSize kbSize = keyboardFrame.size;
    NSLog(@"%f,%f",kbSize.width,kbSize.height);
}*/
/*
-(void)keyboardWillHide:(NSNotification *)aNotification
{
    NSLog(@"will hide");
}

-(void)viewDidUnload
{
    [super viewDidUnload];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
*/
/*-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
   // [super textFieldShouldBeginEditing:textField];
}*/
//-(void)
-(void)u2Edit
{
    self.u2Limit.hidden = YES;
    self.tempu2.hidden = NO;
    [self.u2Limit resignFirstResponder];
    [self.tempu2 becomeFirstResponder];
    [self stopTimer];
}

-(void)setupNavBar
{
    // 设置左边按钮
    //self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"nav_item_game_icon"] highImage:[UIImage imageNamed:@"nav_item_game_click_icon"] target:self action:@selector(game)];
    UIButton *leftbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftbtn setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
    [leftbtn setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
    [leftbtn sizeToFit];
    [leftbtn addTarget:self action:@selector(game) forControlEvents:UIControlEventTouchUpInside];
    UIView *contentView=[[UIView alloc]initWithFrame:leftbtn.bounds];
    [contentView addSubview:leftbtn];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:contentView];
    self.navigationItem.title = currentName;//@"1A1";
}
-(void)runStateRight
{
  //  NSLog(@"setting right navigation bar button clicked");
    configureViewController *configure=[[configureViewController alloc]init];
    configure.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:configure animated:YES];
}
-(void)game
{
    GMLHighFrequencyListViewcontroller *highFrequencyList = [[GMLHighFrequencyListViewcontroller alloc]init];
    highFrequencyList.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:highFrequencyList animated:YES];
  /*  configureViewController *configure=[[configureViewController alloc]init];
    [self.navigationController pushViewController:configure animated:YES];*/
    
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
