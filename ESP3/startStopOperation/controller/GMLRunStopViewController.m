///Users/chenhao/Desktop/ESP4 2/ESP3/startStopOperation/controller/GMLRunStopViewController.m
//  GMLRunStopViewController.m
//  ModbusDemo
//
//  Created by 陈浩 on 16/12/22.
//
//
#import "configureViewController.h"
#import "GMLRunStopViewController.h"
#import "GMLHighFrequencyListViewcontroller.h"
#import "shortCircuitTestViewController.h"
@interface GMLRunStopViewController ()
@property (weak, nonatomic) IBOutlet UILabel *runway;

@property (weak, nonatomic) IBOutlet UILabel *alarmDescription;

@end

@implementation GMLRunStopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=XMGGrayColor(238);
    self.runway.textColor=XMGGrayColor(51);
  /*  UIView *background=[[UIView alloc]initWithFrame:CGRectMake(0, XMGNavBarMaxY, screenW, screenH - XMGNavBarMaxY - XMGTabBarH)];
    //background.backgroundColor=XMGGrayColor(238);
    [self.view addSubview:background];
    CGFloat x1=16,x2=44,y3=35,height=44,y4=45;
    if (iPhone6 || iPhone6P) {
        height = 66;x1=24;y3=53,y4=68;
    }
    CGFloat y2=(screenH - XMGNavBarMaxY - x1 - 4 * height - y4 -XMGTabBarH - y3) / 2.0;
    UILabel *runway = [[UILabel alloc]initWithFrame:CGRectMake(x1, x1 + XMGNavBarMaxY, screenW - 2 * x1, height)];
    runway.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:runway];
    runway.textAlignment = NSTextAlignmentCenter;
    self.runway = runway;
    self.view.backgroundColor =[UIColor whiteColor];
    UIButton *run=[[UIButton alloc]initWithFrame:CGRectMake(x2, x1 + XMGNavBarMaxY + height + y4, screenW - 2 * x2, height)];
  //  run.backgroundColor=[UIColor redColor];
    [run setTitle:@"启动" forState:UIControlStateNormal];
  //  run.titleEdgeInsets = UIEdgeInsetsMake(0, 50, 0, 0);
    [run setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //run.titleLabel.text=@"启动";
    [self.view addSubview:run];
    //[run setImage:[UIImage imageNamed:@"1run"] forState:UIControlStateNormal];
    [run setBackgroundImage:[UIImage imageNamed:@"启动-常态"] forState:UIControlStateNormal];
    [run setBackgroundImage:[UIImage imageNamed:@"启动-按下去的颜色值"] forState:UIControlStateHighlighted];
    //[run setImage:[UIImage imageNamed:@"publish-audio"] forState:UIControlStateHighlighted];
   // run.imageEdgeInsets = UIEdgeInsetsMake(0, -100, 0, 0);
    run.layer.borderWidth = 1;
    run.layer.borderColor=[UIColor redColor].CGColor;
    run.layer.cornerRadius=run.frame.size.height * 0.1;
    [run addTarget:self action:@selector(run) forControlEvents:UIControlEventTouchUpInside];
    UIButton *stop=[[UIButton alloc]initWithFrame:CGRectMake(x2, x1 + XMGNavBarMaxY + height * 2 + y4 + y2, screenW - 2 * x2, height)];
   // stop.backgroundColor=[UIColor greenColor];
    //stop.titleLabel.text=@"停止";
    [stop setTitle:@"停止" forState:UIControlStateNormal];
    stop.layer.borderWidth=1;
    stop.layer.borderColor=[UIColor greenColor].CGColor;
    stop.layer.cornerRadius=stop.frame.size.height*0.1;
    //stop.titleEdgeInsets = UIEdgeInsetsMake(0, 50, 0, 0);
    [stop setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [stop setBackgroundImage:[UIImage imageNamed:@"停止-常态"] forState:UIControlStateNormal];
    [stop setBackgroundImage:[UIImage imageNamed:@"停止-按下去的颜色值"] forState:UIControlStateHighlighted];
    [self.view addSubview:stop];
    [stop addTarget:self action:@selector(stop) forControlEvents:UIControlEventTouchUpInside];
    UIButton *backtoRunState=[[UIButton alloc]initWithFrame:CGRectMake(x2, screenH - XMGTabBarH - y3 - height, screenW - 2 * x2, height)];
    [backtoRunState setTitle:@"告警复位" forState:UIControlStateNormal];
    [backtoRunState setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backtoRunState setBackgroundImage:[UIImage imageNamed:@"告警复位--常态"] forState:UIControlStateNormal];
    [backtoRunState setBackgroundImage:[UIImage imageNamed:@"告警-按下去的颜色值"] forState:UIControlStateHighlighted];
    [self.view addSubview:backtoRunState];
    [backtoRunState addTarget:self action:@selector(alarmReset) forControlEvents:UIControlEventTouchUpInside];
    backtoRunState.layer.borderColor=[UIColor brownColor].CGColor;
    backtoRunState.layer.borderWidth=1;
    backtoRunState.layer.cornerRadius=backtoRunState.frame.size.height*0.1;*/
    [self setupNavBar];
[self startTimer];


}

-(void)startTimer
{if(self.timer) return;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:GMLTimerInterval target:self selector:@selector(runStateLibModbusRead) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

-(void)stopTimer
{
    [self.timer invalidate];
    self.timer = nil;
    [singletonModbus disconnect];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self startTimer];
    [singletonModbus connect:^{
        
    } failure:^(NSError *error) {
        self.runway.text = @"?";
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

#pragma mark-不要在定时器里搞两层读，只要18个有一个读到为1就设置总告警为1，去掉对总告警的读
-(void)runStateLibModbusRead
{
    [singletonModbus readRegistersFrom:(17 - 1) count:1 success:^(NSArray *array) {
        if ([array[0] isEqual: @0]) {
            self.runway.text = @"Off";
        } else if([array[0] isEqual: @1]){
            self.runway.text = @"None";
        }
        else if([array[0] isEqual: @2]){
            self.runway.text = @"Average Current";
        }
        else if([array[0] isEqual: @3]){
            self.runway.text = @"Primary current";
        }
        else if([array[0] isEqual: @4]){
            self.runway.text = @"Voltage peak";
        }
        else if([array[0] isEqual: @5]){
            self.runway.text = @"Modulation";
        }
        else if([array[0] isEqual: @6]){
            self.runway.text = @"Spark";
        }
        else if([array[0] isEqual: @7]){
            self.runway.text = @"PCR";
        }
        else if([array[0] isEqual: @8]){
            self.runway.text = @"OpOpt";
        }
        else if([array[0] isEqual: @9]){
            self.runway.text = @"Pulse current";
        }
        else if([array[0] isEqual: @10]){
            self.runway.text = @"EPOQ";
        }
        else if([array[0] isEqual: @11]){
            self.runway.text = @"VIcurve";
        }
        else if([array[0] isEqual: @12]){
            self.runway.text = @"not used";
        }
        else if([array[0] isEqual: @13]){
            self.runway.text = @"Arc";
        }
        else if([array[0] isEqual: @14]){
            self.runway.text = @"Pulse width";
        }
        else if([array[0] isEqual: @15]){
            self.runway.text = @"Temperature";
        }
        else if([array[0] isEqual: @16]){
            self.runway.text = @"Voltage";
        }
        else if([array[0] isEqual: @17]){
            self.runway.text = @"Duty cycle";
        }
    } failure:^(NSError *error) {
        self.runway.text = @"?";
    }];
    [singletonModbus readBitsFrom:(16385 - 1) count:1 success:^(NSArray *array) {
        if ([array[0] isEqual: @1]) {
            GMLcurrentState =@"运行";
        } else {
            GMLcurrentState =@"停运";
        }
    } failure:^(NSError *error) {
        GMLcurrentState =@"通信中断";
    }];
   
    [singletonModbus readBitsFrom:(2 - 1) count:15 success:^(NSArray *array) {
        __block NSString *allAlarmDescription=@"告警";
        if ([array[0] boolValue] == TRUE) {
             allAlarmDescription = [ allAlarmDescription stringByAppendingString: @",PE单元温度高警告"];
        }
        if ([array[1] boolValue] == TRUE) {
                 allAlarmDescription = [ allAlarmDescription stringByAppendingString: @",PE单元温度高跳闸"];
        }
        if ([array[2] boolValue] == TRUE) {
                 allAlarmDescription = [ allAlarmDescription stringByAppendingString: @",HV单元温度高警告"];
        }
        if ([array[3] boolValue] == TRUE) {
                 allAlarmDescription = [ allAlarmDescription stringByAppendingString: @",HV单元温度高跳闸"];
         }
        if ([array[6] boolValue] == TRUE) {
                 allAlarmDescription = [ allAlarmDescription stringByAppendingString: @",控制单元温度高跳闸"];
         }
        if ([array[8] boolValue] == TRUE) {
                 allAlarmDescription = [ allAlarmDescription stringByAppendingString: @",二次电压低跳闸"];
         }
        if ([array[9] boolValue] == TRUE) {
                 allAlarmDescription = [ allAlarmDescription stringByAppendingString: @",二次电压低警告"];
         }
        if ([array[12] boolValue] == TRUE) {
                 allAlarmDescription = [ allAlarmDescription stringByAppendingString: @",实时时钟初始化警告"];
         }
        if ([array[10] boolValue] == TRUE) {
                 allAlarmDescription = [ allAlarmDescription stringByAppendingString: @",二次电压高跳闸"];
        }
        if ([array[5] boolValue] == TRUE) {
                 allAlarmDescription = [ allAlarmDescription stringByAppendingString: @",电流不平衡跳闸"];
        }
        if ([array[13] boolValue] == TRUE) {
                 allAlarmDescription = [ allAlarmDescription stringByAppendingString: @",看门狗跳闸"];
        }
        if ([array[14] boolValue] == TRUE) {
                 allAlarmDescription = [ allAlarmDescription stringByAppendingString: @",控制器重启跳闸"];
        }
        if ([array[4] boolValue] == TRUE) {
                 allAlarmDescription = [ allAlarmDescription stringByAppendingString: @",输出开路跳闸"];
         }
        self.alarmDescription.text=allAlarmDescription;
  } failure:^(NSError *error) {
        self.alarmDescription.text=@"通信中断";
    }];
[singletonModbus readBitsFrom:(37 - 1) count:10 success:^(NSArray *array) {
    __block NSString *allAlarmDescription=@"告警";
    if ([array[4] boolValue] == TRUE) {
        allAlarmDescription = [ allAlarmDescription stringByAppendingString: @",控制单元温度高警告"];
    }
    if ([array[2] boolValue] == TRUE) {
        allAlarmDescription = [ allAlarmDescription stringByAppendingString: @",一次电压低警告"];
    }
    if ([array[9] boolValue] == TRUE) {
        allAlarmDescription = [ allAlarmDescription stringByAppendingString: @",一次电压低跳闸"];
    }
    if ([array[0] boolValue] == TRUE) {
        allAlarmDescription = [ allAlarmDescription stringByAppendingString: @",变频单元故障跳闸"];
    }
    if ([array[1] boolValue] == TRUE) {
        allAlarmDescription = [ allAlarmDescription stringByAppendingString: @",冷却风扇故障跳闸"];
    }
    if ([array[3] boolValue] == TRUE) {
        allAlarmDescription = [ allAlarmDescription stringByAppendingString: @",一次电压高跳闸"];
    }
} failure:^(NSError *error) {
    self.alarmDescription.text=@"通信中断";
}];
[singletonModbus readBitsFrom:(87 - 1) count:11 success:^(NSArray *array) {
    __block NSString *allAlarmDescription=@"告警";
    if ([array[2] boolValue] == TRUE) {
        allAlarmDescription = [ allAlarmDescription stringByAppendingString: @",冷却液温度高警告"];
    }
    if ([array[3] boolValue] == TRUE) {
        allAlarmDescription = [ allAlarmDescription stringByAppendingString: @",冷却液温度高跳闸"];
    }
    if ([array[0] boolValue] == TRUE) {
        allAlarmDescription = [ allAlarmDescription stringByAppendingString: @",冷却液液位低警告"];
    }
    if ([array[10] boolValue] == TRUE) {
        allAlarmDescription = [ allAlarmDescription stringByAppendingString: @",电流过流保护跳闸"];
    }
    if ([array[1] boolValue] == TRUE) {
        allAlarmDescription = [ allAlarmDescription stringByAppendingString: @",通信故障跳闸"];
    }
} failure:^(NSError *error) {
    self.alarmDescription.text=@"通信中断";
}];
}


-(void)dealloc
{
    [singletonModbus disconnect];
    singletonModbus = nil;
}

-(void)setupNavBar
{
    UIButton *leftbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftbtn setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
    [leftbtn setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
    [leftbtn sizeToFit];
    [leftbtn addTarget:self action:@selector(game) forControlEvents:UIControlEventTouchUpInside];
    UIView *contentView=[[UIView alloc]initWithFrame:leftbtn.bounds];
    [contentView addSubview:leftbtn];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:contentView];
   /* UIButton *rightbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [rightbtn setImage:[UIImage imageNamed:@"mine-setting-icon"] forState:UIControlStateNormal];
    [rightbtn setImage:[UIImage imageNamed:@"mine-setting-icon-click"] forState:UIControlStateHighlighted];
    [rightbtn sizeToFit];
    [rightbtn addTarget:self action:@selector(runStateRight) forControlEvents:UIControlEventTouchUpInside];
    UIView *rightContentView=[[UIView alloc]initWithFrame:rightbtn.bounds];
    [rightContentView addSubview:rightbtn];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:rightContentView];*/
    //self.navigationItem.title = @"运行方式";
}
-(void)runStateRight
{
    shortCircuitTestViewController *configure=[[shortCircuitTestViewController alloc]initWithNibName:@"shortCircuitTestViewController" bundle:nil];
    configure.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:configure animated:YES];
}
-(void)game
{
    GMLHighFrequencyListViewcontroller *highFrequencyList = [[GMLHighFrequencyListViewcontroller alloc]init];
    highFrequencyList.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:highFrequencyList animated:YES];
}

-(void)alarmReset
{

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = currentName;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)startup:(id)sender {
    [singletonModbus writeBit:(16385 - 1) to:YES success:^{
    } failure:^(NSError *error) {
      //  NSLog(@"启动失败:%@",error.localizedDescription);
    }];
}
- (IBAction)stop:(id)sender {
    [singletonModbus writeBit:(16385 - 1) to:NO success:^{
    } failure:^(NSError *error) {
       // NSLog(@"停止失败:%@",error.localizedDescription);
    }];
}
- (IBAction)alarmReset:(id)sender {
    [singletonModbus writeBit:(16393 - 1) to:NO success:^{
    } failure:^(NSError *error) {
    }];
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
