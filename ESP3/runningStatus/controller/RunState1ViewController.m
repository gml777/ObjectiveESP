//
//  RunState1ViewController.m
//  ModbusDemo
//
//  Created by 陈浩 on 16/12/20.
//
//
#import "GMLHighFrequencyListViewcontroller.h"
#import "RunState1ViewController.h"
#import "GMLRunStopViewController.h"
#import "configureViewController.h"
@interface RunState1ViewController ()<UIScrollViewDelegate>
//@property(nonatomic,weak)NSTimer *timer;
//ObjectiveLibModbus *runStateLibModbus;

//@property(nonatomic,strong)UITextField *kzqText;
{
   // ObjectiveLibModbus *runStateLibModbus;
}

@end

@implementation RunState1ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    CGFloat originX = 31, originY = 10, labelWidth = 100,labelHeight = 35, deltaY = 44, textHeight = 35,unitWidth = 35, jianju = 14,editWidth = screenW - 2 * originX - 2 * jianju - labelWidth - unitWidth;
   // if(iPhone6P) unitWidth = 20;
  
    UIScrollView *scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, screenW, screenH)];
    //scrollView.backgroundColor=[UIColor cyanColor];
    scrollView.delegate=self;
    scrollView.contentSize = CGSizeMake(screenW, 626);
    [scrollView flashScrollIndicators];
    scrollView.directionalLockEnabled=YES;
    [self.view addSubview:scrollView];self.scrollView = scrollView;
 
   self.view.backgroundColor=XMGGrayColor(238);
    UIView *backview1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, screenW, 10)];
    backview1.backgroundColor=[UIColor whiteColor];
    [self.scrollView addSubview:backview1];
    CGFloat gml=4.5;
 //   scrollView.bounces=NO;
  //  [scrollView setContentOffset:CGPointMake(0, 582) animated:YES];
  //  scrollView.bouncesZoom=NO;
    UILabel *newtitle=[[UILabel alloc]initWithFrame:CGRectMake(originX, originY + deltaY * 0+gml, screenW - 2 * originX, labelHeight)];
    newtitle.text=@"运行状态";
    newtitle.textAlignment=NSTextAlignmentCenter;
    newtitle.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:20];
    [self.scrollView addSubview:newtitle];
    NSArray *alarmList = [NSArray arrayWithObjects:@"控制器",@"变压器",@"冷却液",@"PE1温度",@"PE2温度",@"一次电压",@"一次电流",@"二次电压",@"二次电流",@"火花率",@"火花总量",@"拉弧总量",@"HW火花总量", nil];
    for(int  i = 0; i < alarmList.count; i++)
    {
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(originX, originY + deltaY * (i+1)+gml, labelWidth, labelHeight)];
        label.text=alarmList[i];
        [self.scrollView addSubview:label];
    }
    
    NSArray *unitList = [NSArray arrayWithObjects:@"℃",@"℃",@"℃",@"℃",@"℃",@"V",@"A",@"kV",@"mA",@"spm",@"次",@"次",@"次", nil];
    for(int  i = 0; i < alarmList.count; i++)
    {
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(screenW - originX - unitWidth, originY + deltaY * (i+1)+gml, unitWidth, labelHeight)];
        label.text=unitList[i];
        [self.scrollView addSubview:label];
        UIView * line=[[UIView alloc]initWithFrame:CGRectMake(0, originY+ deltaY * (i+1), screenW, 1)];
        line.backgroundColor=[UIColor whiteColor];
        [self.scrollView addSubview:line];
    }
    UITextField *kzqText=[[UITextField alloc]initWithFrame:CGRectMake(originX + labelWidth + jianju, originY+ deltaY * 1+gml, editWidth, textHeight)];
    //i1Text.text=@"一次电流";
    [kzqText setBorderStyle:UITextBorderStyleRoundedRect];
    kzqText.textAlignment=UITextAlignmentCenter;
    [self.scrollView addSubview:kzqText];
    self.kzqText = kzqText;
    self.kzqText.userInteractionEnabled=NO;
    UITextField *byqText=[[UITextField alloc]initWithFrame:CGRectMake(originX + labelWidth + jianju, originY + deltaY * 2+gml, editWidth, textHeight)];
    byqText.userInteractionEnabled=NO;
    [byqText setBorderStyle:UITextBorderStyleRoundedRect];
    byqText.textAlignment=UITextAlignmentCenter;
    [self.scrollView addSubview:byqText];
    self.byqText = byqText;
    UITextField *lqyText=[[UITextField alloc]initWithFrame:CGRectMake(originX + labelWidth + jianju, originY + deltaY * 3+gml, editWidth, textHeight)];
    lqyText.userInteractionEnabled=NO;
    [lqyText setBorderStyle:UITextBorderStyleRoundedRect];
    lqyText.textAlignment=UITextAlignmentCenter;
    [self.scrollView addSubview:lqyText];
    self.lqyText = lqyText;
    UITextField *pe1Text=[[UITextField alloc]initWithFrame:CGRectMake(originX + labelWidth + jianju, originY + deltaY * 4+gml, editWidth, textHeight)];
    pe1Text.userInteractionEnabled=NO;
    [pe1Text setBorderStyle:UITextBorderStyleRoundedRect];
    pe1Text.textAlignment=UITextAlignmentCenter;
    [self.scrollView addSubview:pe1Text];
    self.pe1Text = pe1Text;
    UITextField *pe2Text=[[UITextField alloc]initWithFrame:CGRectMake(originX + labelWidth + jianju, originY + deltaY * 5+gml, editWidth, textHeight)];
    pe2Text.userInteractionEnabled=NO;
    [pe2Text setBorderStyle:UITextBorderStyleRoundedRect];
    pe2Text.textAlignment=UITextAlignmentCenter;
    [self.scrollView addSubview:pe2Text];
    self.pe2Text = pe2Text;
 
    UITextField *i1Text=[[UITextField alloc]initWithFrame:CGRectMake(originX + labelWidth + jianju, originY + deltaY * 7+gml, editWidth, textHeight)];
    i1Text.userInteractionEnabled=NO;
    [i1Text setBorderStyle:UITextBorderStyleRoundedRect];
    i1Text.textAlignment=UITextAlignmentCenter;
    [self.scrollView addSubview:i1Text];
  //  i1Text.text = @"31";
    self.i1Text = i1Text;
    UITextField *u1Text=[[UITextField alloc]initWithFrame:CGRectMake(originX + labelWidth + jianju, originY + deltaY * 6+gml, editWidth, textHeight)];
    u1Text.userInteractionEnabled=NO;
    [u1Text setBorderStyle:UITextBorderStyleRoundedRect];
    u1Text.textAlignment=UITextAlignmentCenter;
    [self.scrollView addSubview:u1Text];
    self.u1Text = u1Text;
    UITextField *u2Text=[[UITextField alloc]initWithFrame:CGRectMake(originX + labelWidth + jianju, originY + deltaY * 8+gml, editWidth, textHeight)];
    u2Text.userInteractionEnabled=NO;
    [u2Text setBorderStyle:UITextBorderStyleRoundedRect];
    u2Text.textAlignment=UITextAlignmentCenter;
    [self.scrollView addSubview:u2Text];
    self.u2Text = u2Text;
    UITextField *i2Text=[[UITextField alloc]initWithFrame:CGRectMake(originX + labelWidth + jianju, originY + deltaY * 9+gml, editWidth, textHeight)];
    i2Text.userInteractionEnabled=NO;
    [i2Text setBorderStyle:UITextBorderStyleRoundedRect];
    i2Text.textAlignment=UITextAlignmentCenter;
    [self.scrollView addSubview:i2Text];
    self.i2Text = i2Text;
    UITextField *hhlText=[[UITextField alloc]initWithFrame:CGRectMake(originX + labelWidth + jianju, originY + deltaY * 10+gml, editWidth, textHeight)];
    hhlText.userInteractionEnabled=NO;
    [hhlText setBorderStyle:UITextBorderStyleRoundedRect];
    hhlText.textAlignment=UITextAlignmentCenter;
    [self.scrollView addSubview:hhlText];
    self.hhlText = hhlText;
    
    UITextField *sparks=[[UITextField alloc]initWithFrame:CGRectMake(originX + labelWidth + jianju, originY + deltaY * 11+gml, editWidth, textHeight)];
    sparks.userInteractionEnabled=NO;
    [sparks setBorderStyle:UITextBorderStyleRoundedRect];
    sparks.textAlignment=UITextAlignmentCenter;
    [self.scrollView addSubview:sparks];
    self.sparks = sparks;
    
    UITextField *arcs=[[UITextField alloc]initWithFrame:CGRectMake(originX + labelWidth + jianju, originY + deltaY * 12+gml, editWidth, textHeight)];
    arcs.userInteractionEnabled=NO;
    [arcs setBorderStyle:UITextBorderStyleRoundedRect];
    arcs.textAlignment=UITextAlignmentCenter;
    [self.scrollView addSubview:arcs];
    self.arcs = arcs;
    
    UITextField *HWsparks=[[UITextField alloc]initWithFrame:CGRectMake(originX + labelWidth + jianju, originY + deltaY * 13+gml, editWidth, textHeight)];
    HWsparks.userInteractionEnabled=NO;
    [HWsparks setBorderStyle:UITextBorderStyleRoundedRect];
    HWsparks.textAlignment=UITextAlignmentCenter;
    [self.scrollView addSubview:HWsparks];
    self.HWsparks = HWsparks;

    [self setupNavBar];
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
    [singletonModbus disconnect];//XMGLogFunc
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = currentName;//@"1A4";
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self startTimer];
    [singletonModbus connect:^{

    } failure:^(NSError *error) {
       // NSLog(@"运行状态将要出现错误%@",error.localizedDescription);
        self.kzqText.text = @"?";
        self.byqText.text=@"?";
        self.lqyText.text = @"?";
        self.pe1Text.text=@"?";
        self.pe2Text.text = @"?";
        self.u1Text.text=@"?";
        self.i1Text.text = @"?";
        self.u2Text.text=@"?";
        self.i2Text.text = @"?";
        self.hhlText.text=@"?";
        self.sparks.text = @"?";
        self.arcs.text=@"?";
        self.HWsparks.text = @"?";
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
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    for (UITextField *view in self.view.subviews) {
        [view resignFirstResponder];
    }
}

-(void)runStateLibModbusRead
{
    [singletonModbus readRegistersFrom:(197 - 1) count:7 success:^(NSArray *array) {
        if([array[6] intValue] < 10000)
            self.kzqText.text = [NSString stringWithFormat:@"%@",array[6]];
        else
            self.kzqText.text = [NSString stringWithFormat:@"%d",[array[6] intValue] - 65536];
        if ([array[4] intValue] < 10000) {
            self.byqText.text = [NSString stringWithFormat:@"%@",array[4]];
        } else {
            self.byqText.text = [NSString stringWithFormat:@"%d",[array[4] intValue] - 65536];
        }
        if ([array[3] intValue] < 1000) {
            self.lqyText.text = [NSString stringWithFormat:@"%@",array[3]];
        } else {
            self.lqyText.text = [NSString stringWithFormat:@"%d",[array[3] intValue] - 65536];
        }
        if ([array[0] intValue] < 10000) {
            self.pe1Text.text = [NSString stringWithFormat:@"%@",array[0]];
        } else {
            self.pe1Text.text = [NSString stringWithFormat:@"%d",[array[0] intValue] - 65536];
        }
        if ([array[1] intValue] < 10000) {
            self.pe2Text.text = [NSString stringWithFormat:@"%@",array[1]];
        } else {
            self.pe2Text.text = [NSString stringWithFormat:@"%d",[array[1] intValue] - 65536];
        }
        
    } failure:^(NSError *error) {
       // NSLog(@"error in run state read 197~205:%@",error.localizedDescription);
        self.kzqText.text = @"?";
        self.byqText.text=@"?";
        self.lqyText.text = @"?";
        self.pe1Text.text=@"?";
        self.pe2Text.text = @"?";
    }];
    [singletonModbus readRegistersFrom:(25 - 1) count:7 success:^(NSArray *array) {
        self.u1Text.text = [NSString stringWithFormat:@"%@",array[0]];
        self.i1Text.text = [NSString stringWithFormat:@"%.1f",[array[1] intValue] / 10.0];
        self.u2Text.text = [NSString stringWithFormat:@"%.1f",[array[3] intValue] / 10.0];
     //   self.i2Text.text = [NSString stringWithFormat:@"%@",array[14]];
        self.hhlText.text =[NSString stringWithFormat:@"%@",array[6]];
    } failure:^(NSError *error) {
      //  NSLog(@"error in run state read 25~31:%@",error.localizedDescription);
        self.u1Text.text=@"?";
        self.i1Text.text = @"?";
        self.u2Text.text=@"?";
       // self.i2Text.text = @"?";
        self.hhlText.text=@"?";

    }];
    [singletonModbus readRegistersFrom:(39 - 1) count:9 success:^(NSArray *array) {
        self.i2Text.text = [NSString stringWithFormat:@"%@",array[0]];
        self.sparks.text = [NSString stringWithFormat:@"%@",array[4]];
        self.arcs.text = [NSString stringWithFormat:@"%@",array[6]];
        self.HWsparks.text =[NSString stringWithFormat:@"%@",array[8]];
    } failure:^(NSError *error) {
      //  NSLog(@"error in run state read 39~47:%@",error.localizedDescription);
        self.i2Text.text = @"?";
      //  self.hhlText.text=@"?";
        self.sparks.text = @"?";
        self.arcs.text=@"?";
        self.HWsparks.text = @"?";
    }];//XMGLogFunc
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
    
    
  //  [self.navigationItem.leftBarButtonItem setTitle:@"返回高频电源列表" forState:UIControlStateNormal];
    //self.navigationItem.leftBarButtonItem.contentEdgeInsets=UIEdgeInsetsMake(0, -20, 0, 0);

   // self.navigationItem.title = currentName;//@"1A4";
  /*  UIButton *rightbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [rightbtn setImage:[UIImage imageNamed:@"mine-setting-icon"] forState:UIControlStateNormal];
    [rightbtn setImage:[UIImage imageNamed:@"mine-setting-icon-click"] forState:UIControlStateHighlighted];
    [rightbtn sizeToFit];
    [rightbtn addTarget:self action:@selector(runStateRight) forControlEvents:UIControlEventTouchUpInside];
    UIView *rightContentView=[[UIView alloc]initWithFrame:rightbtn.bounds];
    [rightContentView addSubview:rightbtn];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:rightContentView];*/

    // 设置中间图片
    //self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // 设置右边按钮
   // self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"navigationButtonRandom"] highImage:[UIImage imageNamed:@"navigationButtonRandomClick"] target:nil action:nil];
}
-(void)runStateRight
{
    //NSLog(@"run state right navigation bar button clicked");
     configureViewController *configure=[[configureViewController alloc]initWithNibName:@"configureViewController" bundle:nil];
    configure.hidesBottomBarWhenPushed=YES;
     [self.navigationController pushViewController:configure animated:YES];
}
-(void)game
{
    //NSLog(@"run state left navigation bar button clicked");
    GMLHighFrequencyListViewcontroller *highFrequencyList = [[GMLHighFrequencyListViewcontroller alloc]init];
    highFrequencyList.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:highFrequencyList animated:YES];
   // configureViewController *configure=[[configureViewController alloc]init];
   // [self.navigationController pushViewController:configure animated:YES];
}
-(void)runStop
{
    GMLRunStopViewController *runStop=[[GMLRunStopViewController alloc]init];
    [self presentViewController:runStop animated:YES completion:nil];
}
-(void)close
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)closeRunState1 {
   
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)dealloc
{
    [singletonModbus disconnect];
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
