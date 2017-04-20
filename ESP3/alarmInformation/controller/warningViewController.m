//
//  warningViewController.m
//  ModbusDemo
///Users/chenhao/Desktop/esp 2/Demo/ModbusDemo/参数设置
//  Created by 陈浩 on 16/12/22.
//
//
#import "configureViewController.h"
#import "warningViewController.h"
#import "GMLHighFrequencyListViewcontroller.h"
@interface warningViewController ()<UIScrollViewDelegate>
{
  //  ObjectiveLibModbus *warningLibModbus;
}
@end

@implementation warningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self setupNavBar];
    UIScrollView *scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, screenW, screenH)];
    //scrollView.backgroundColor=[UIColor cyanColor];
    scrollView.delegate=self;
    scrollView.contentSize = CGSizeMake(screenW, 1003);
    [scrollView flashScrollIndicators];
    scrollView.directionalLockEnabled=YES;
    [self.view addSubview:scrollView];self.scrollView = scrollView;
    CGFloat labelX = 10, labelY = 20, labelWidth = 125, labelHeight = 20, marginY = 50,imageW = 35;
    UIView *titleBackground=[[UIView alloc]initWithFrame:CGRectMake(0, labelY - 10+ marginY * 1, screenW, labelHeight + 20)];
    titleBackground.backgroundColor=XMGColor(234, 234, 234);
    [self.scrollView addSubview:titleBackground];
    UILabel *newtitle=[[UILabel alloc]initWithFrame:CGRectMake(labelX,  marginY * 0.45, screenW - 2 * labelX, labelHeight)];
    newtitle.text=@"告警信息";
    newtitle.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:20];
    newtitle.textAlignment=NSTextAlignmentCenter;
    [self.scrollView addSubview:newtitle];
    NSArray *alarmList = [NSArray arrayWithObjects:@"故障信息",@"PE单元温度高",@"HV单元温度高",@"控制单元温度高",@"冷却液温度高",@"二次电压低",@"一次电压低",@"实时时钟初始化",@"冷却液液位低",@"二次电压高",@"电流不平衡",@"看门狗",@"控制器重启",@"变频单元故障",@"冷却风扇故障",@"输出开路",@"一次电压高",@"电流过流保护",@"通信故障", nil];
    for(int  i = 0; i < alarmList.count; i++)
    {
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(labelX, labelY + marginY * (i + 1), labelWidth, labelHeight - 2)];
        label.text=alarmList[i];
        [scrollView addSubview:label];
        if (i > 0) {
            UILabel *line=[[UILabel alloc]initWithFrame:CGRectMake(labelX, 3 + marginY * (i + 2), screenW - 2 * labelX, 1)];
            line.backgroundColor=XMGColor(234, 234, 234);
            [scrollView addSubview:line];
        }

    }
    UILabel *jinggao=[[UILabel alloc]initWithFrame:CGRectMake(screenW - 100, labelY + marginY * 1, labelWidth, labelHeight)];
    jinggao.text=@"警告";
    [scrollView addSubview:jinggao];
  // jinggao.textColor = [UIColor redColor];
    UILabel *tiaozha=[[UILabel alloc]initWithFrame:CGRectMake(screenW - 50, labelY + marginY * 1, labelWidth, labelHeight)];
    tiaozha.text=@"跳闸";
    [scrollView addSubview:tiaozha];
   // tiaozha.textColor = [UIColor redColor];
    UIImageView *warning01 = [[UIImageView alloc]initWithFrame:CGRectMake(screenW - 100, labelY + marginY*2,imageW, labelHeight)];
    [self.scrollView addSubview:warning01];
    warning01.image = [UIImage imageNamed:@"灰色图标-切图"];self.warning01 = warning01;
    UIImageView *warning02 = [[UIImageView alloc]initWithFrame:CGRectMake(screenW - 100, labelY + marginY*3,imageW, labelHeight)];
    [self.scrollView addSubview:warning02];
    warning02.image = [UIImage imageNamed:@"灰色图标-切图"];self.warning02 = warning02;
    UIImageView *warning03 = [[UIImageView alloc]initWithFrame:CGRectMake(screenW - 100, labelY + marginY*4,imageW, labelHeight)];
    [self.scrollView addSubview:warning03];
    warning03.image = [UIImage imageNamed:@"灰色图标-切图"];self.warning03 = warning03;
    UIImageView *warning04 = [[UIImageView alloc]initWithFrame:CGRectMake(screenW - 100, labelY + marginY*5,imageW, labelHeight)];
    [self.scrollView addSubview:warning04];
    warning04.image = [UIImage imageNamed:@"灰色图标-切图"];self.warning04 = warning04;
    UIImageView *warning05 = [[UIImageView alloc]initWithFrame:CGRectMake(screenW - 100, labelY + marginY*6,imageW, labelHeight)];
    [self.scrollView addSubview:warning05];
    warning05.image = [UIImage imageNamed:@"灰色图标-切图"];self.warning05 = warning05;
    UIImageView *warning06 = [[UIImageView alloc]initWithFrame:CGRectMake(screenW - 100, labelY + marginY*7,imageW, labelHeight)];
    [self.scrollView addSubview:warning06];
    warning06.image = [UIImage imageNamed:@"灰色图标-切图"];self.warning06 = warning06;
    UIImageView *warning07 = [[UIImageView alloc]initWithFrame:CGRectMake(screenW - 100, labelY + marginY*8,imageW, labelHeight)];
    [self.scrollView addSubview:warning07];
    warning07.image = [UIImage imageNamed:@"灰色图标-切图"];self.warning07 = warning07;
    UIImageView *warning08 = [[UIImageView alloc]initWithFrame:CGRectMake(screenW - 100, labelY + marginY*9,imageW, labelHeight)];
    [self.scrollView addSubview:warning08];
    warning08.image = [UIImage imageNamed:@"灰色图标-切图"];self.warning08 = warning08;
    
    UIImageView *baozha01 = [[UIImageView alloc]initWithFrame:CGRectMake(screenW - 50, labelY + marginY*2,imageW, labelHeight)];
    [self.scrollView addSubview:baozha01];
    baozha01.image = [UIImage imageNamed:@"灰色图标-切图"];self.baozha01 = baozha01;
    UIImageView *baozha02 = [[UIImageView alloc]initWithFrame:CGRectMake(screenW - 50, labelY + marginY*3,imageW, labelHeight)];
    [self.scrollView addSubview:baozha02];
    baozha02.image = [UIImage imageNamed:@"灰色图标-切图"];self.baozha02 = baozha02;
    UIImageView *baozha03 = [[UIImageView alloc]initWithFrame:CGRectMake(screenW - 50, labelY + marginY*4,imageW, labelHeight)];
    [self.scrollView addSubview:baozha03];
    baozha03.image = [UIImage imageNamed:@"灰色图标-切图"];self.baozha03 = baozha03;
    UIImageView *baozha04 = [[UIImageView alloc]initWithFrame:CGRectMake(screenW - 50, labelY + marginY*5,imageW, labelHeight)];
    [self.scrollView addSubview:baozha04];
    baozha04.image = [UIImage imageNamed:@"灰色图标-切图"];self.baozha04 = baozha04;
    UIImageView *baozha05 = [[UIImageView alloc]initWithFrame:CGRectMake(screenW - 50, labelY + marginY*6,imageW, labelHeight)];
    [self.scrollView addSubview:baozha05];
    baozha05.image = [UIImage imageNamed:@"灰色图标-切图"];self.baozha05 = baozha05;
    UIImageView *baozha06 = [[UIImageView alloc]initWithFrame:CGRectMake(screenW - 50, labelY + marginY*7,imageW, labelHeight)];
    [self.scrollView addSubview:baozha06];
    baozha06.image = [UIImage imageNamed:@"灰色图标-切图"];self.baozha06 = baozha06;
    UIImageView *baozha07 = [[UIImageView alloc]initWithFrame:CGRectMake(screenW - 50, labelY + marginY*10,imageW, labelHeight)];
    [self.scrollView addSubview:baozha07];
    baozha07.image = [UIImage imageNamed:@"灰色图标-切图"];self.baozha07 = baozha07;
    UIImageView *baozha08 = [[UIImageView alloc]initWithFrame:CGRectMake(screenW - 50, labelY + marginY*11,imageW, labelHeight)];
    [self.scrollView addSubview:baozha08];
    baozha08.image = [UIImage imageNamed:@"灰色图标-切图"];self.baozha08 = baozha08;
    UIImageView *baozha09 = [[UIImageView alloc]initWithFrame:CGRectMake(screenW - 50, labelY + marginY*12,imageW, labelHeight)];
    [self.scrollView addSubview:baozha09];
    baozha09.image = [UIImage imageNamed:@"灰色图标-切图"];self.baozha09 = baozha09;
    UIImageView *baozha10 = [[UIImageView alloc]initWithFrame:CGRectMake(screenW - 50, labelY + marginY*13,imageW, labelHeight)];
    [self.scrollView addSubview:baozha10];
    baozha10.image = [UIImage imageNamed:@"灰色图标-切图"];self.baozha10 = baozha10;
    UIImageView *baozha11 = [[UIImageView alloc]initWithFrame:CGRectMake(screenW - 50, labelY + marginY*14,imageW, labelHeight)];
    [self.scrollView addSubview:baozha11];
    baozha11.image = [UIImage imageNamed:@"灰色图标-切图"];self.baozha11 = baozha11;
    UIImageView *baozha12 = [[UIImageView alloc]initWithFrame:CGRectMake(screenW - 50, labelY + marginY*15,imageW, labelHeight)];
    [self.scrollView addSubview:baozha12];
    baozha12.image = [UIImage imageNamed:@"灰色图标-切图"];self.baozha12 = baozha12;
    UIImageView *baozha13 = [[UIImageView alloc]initWithFrame:CGRectMake(screenW - 50, labelY + marginY*16,imageW, labelHeight)];
    [self.scrollView addSubview:baozha13];
    baozha13.image = [UIImage imageNamed:@"灰色图标-切图"];self.baozha13 = baozha13;
    UIImageView *baozha14 = [[UIImageView alloc]initWithFrame:CGRectMake(screenW - 50, labelY + marginY*17,imageW, labelHeight)];
    [self.scrollView addSubview:baozha14];
    baozha14.image = [UIImage imageNamed:@"灰色图标-切图"];self.baozha14 = baozha14;
    UIImageView *baozha15 = [[UIImageView alloc]initWithFrame:CGRectMake(screenW - 50, labelY + marginY*18,imageW, labelHeight)];
    [self.scrollView addSubview:baozha15];
    baozha15.image = [UIImage imageNamed:@"灰色图标-切图"];self.baozha15 = baozha15;
    UIImageView *baozha16 = [[UIImageView alloc]initWithFrame:CGRectMake(screenW - 50, labelY + marginY*19,imageW, labelHeight)];
    [self.scrollView addSubview:baozha16];
    baozha16.image = [UIImage imageNamed:@"灰色图标-切图"];self.baozha16 = baozha16;
      //  warningLibModbus = [[ObjectiveLibModbus alloc]initWithTCP:GMLIPAddress port:502 device:GMLDevice];
  //  warningLibModbus = [[ObjectiveLibModbus alloc]initWithTCP:currentIPAddress port:currentPort device:currentdeviceID];
  /*  [singletonModbus connect:^{
      //  NSLog(@"%@",IPAddress);
    } failure:^(NSError *error) {
        NSLog(@"告警页面创建连接错误:%@",error.localizedDescription);
    }];*/

self.interval = GMLTimerInterval;
[self startTimer];
}

-(void)startTimer
{
   /* [warningLibModbus disconnect];
    warningLibModbus = [[ObjectiveLibModbus alloc]initWithTCP:IPAddress port:port device:deviceID];
    [warningLibModbus connect:^{
        //NSLog(@"success");
    } failure:^(NSError *error) {
        NSLog(@"告警页面qidong创建连接错误:%@",error.localizedDescription);
    }];*/
    if(self.timer) return;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.interval target:self selector:@selector(runStateLibModbusRead) userInfo:nil repeats:YES];
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
        NSLog(@"告警操作将要出现连接错误%@",error.localizedDescription);
    }];
}

/*-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self stopTimer];
}*/
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self stopTimer];
}
-(void)setInterval:(NSTimeInterval)interval
{
    _interval = interval;
    [self stopTimer];
    [self startTimer];
    [singletonModbus disconnect];
}

-(void)runStateLibModbusRead
{
    [singletonModbus readBitsFrom:(2 - 1) count:15 success:^(NSArray *array) {
        if ([array[0] boolValue] == TRUE) {
            self.warning01.image = [UIImage imageNamed:@"loginBtnBgClick"];
        } else {
            self.warning01.image = [UIImage imageNamed:@"圆角矩形--圆角框"];
        }
        if ([array[1] boolValue] == TRUE) {
            self.baozha01.image = [UIImage imageNamed:@"loginBtnBgClick"];
        } else {
            self.baozha01.image = [UIImage imageNamed:@"圆角矩形--圆角框"];
        }
        if ([array[2] boolValue] == TRUE) {
            self.warning02.image = [UIImage imageNamed:@"loginBtnBgClick"];
        } else {
            self.warning02.image = [UIImage imageNamed:@"圆角矩形--圆角框"];
        }
        if ([array[3] boolValue] == TRUE) {
            self.baozha02.image = [UIImage imageNamed:@"loginBtnBgClick"];
        } else {
            self.baozha02.image = [UIImage imageNamed:@"圆角矩形--圆角框"];
        }
        if ([array[6] boolValue] == TRUE) {
            self.baozha03.image = [UIImage imageNamed:@"loginBtnBgClick"];
        } else {
            self.baozha03.image = [UIImage imageNamed:@"圆角矩形--圆角框"];
        }
        if ([array[8] boolValue] == TRUE) {
            self.baozha05.image = [UIImage imageNamed:@"loginBtnBgClick"];
        } else {
            self.baozha05.image = [UIImage imageNamed:@"圆角矩形--圆角框"];
        }
        if ([array[9] boolValue] == TRUE) {
            self.warning05.image = [UIImage imageNamed:@"loginBtnBgClick"];
        } else {
            self.warning05.image = [UIImage imageNamed:@"圆角矩形--圆角框"];
        }
        if ([array[12] boolValue] == TRUE) {
            self.warning07.image = [UIImage imageNamed:@"loginBtnBgClick"];
        } else {
            self.warning07.image = [UIImage imageNamed:@"圆角矩形--圆角框"];
        }
        if ([array[10] boolValue] == TRUE) {
            self.baozha07.image = [UIImage imageNamed:@"loginBtnBgClick"];
        } else {
            self.baozha07.image = [UIImage imageNamed:@"圆角矩形--圆角框"];
        }
        if ([array[5] boolValue] == TRUE) {
            self.baozha08.image = [UIImage imageNamed:@"loginBtnBgClick"];
        } else {
            self.baozha08.image = [UIImage imageNamed:@"圆角矩形--圆角框"];
        }
        if ([array[13] boolValue] == TRUE) {
            self.baozha09.image = [UIImage imageNamed:@"loginBtnBgClick"];
        } else {
            self.baozha09.image = [UIImage imageNamed:@"圆角矩形--圆角框"];
        }
        if ([array[14] boolValue] == TRUE) {
            self.baozha10.image = [UIImage imageNamed:@"loginBtnBgClick"];
        } else {
            self.baozha10.image = [UIImage imageNamed:@"圆角矩形--圆角框"];
        }
        if ([array[4] boolValue] == TRUE) {
            self.baozha13.image = [UIImage imageNamed:@"loginBtnBgClick"];
        } else {
            self.baozha13.image = [UIImage imageNamed:@"圆角矩形--圆角框"];
        }
    } failure:^(NSError *error) {
        self.warning01.image = [UIImage imageNamed:@"灰色图标-切图"];
        self.baozha01.image = [UIImage imageNamed:@"灰色图标-切图"];
        self.warning02.image = [UIImage imageNamed:@"灰色图标-切图"];
        self.baozha02.image = [UIImage imageNamed:@"灰色图标-切图"];
        self.baozha03.image = [UIImage imageNamed:@"灰色图标-切图"];
        self.baozha05.image = [UIImage imageNamed:@"灰色图标-切图"];
        self.warning05.image = [UIImage imageNamed:@"灰色图标-切图"];
        self.warning07.image = [UIImage imageNamed:@"灰色图标-切图"];
        self.baozha07.image = [UIImage imageNamed:@"灰色图标-切图"];
        self.baozha08.image = [UIImage imageNamed:@"灰色图标-切图"];
        self.baozha09.image = [UIImage imageNamed:@"灰色图标-切图"];
        self.baozha10.image = [UIImage imageNamed:@"灰色图标-切图"];
        self.baozha13.image = [UIImage imageNamed:@"灰色图标-切图"];
    }];

    [singletonModbus readBitsFrom:(37 - 1) count:10 success:^(NSArray *array) {
        if ([array[4] boolValue] == TRUE) {
            self.warning03.image = [UIImage imageNamed:@"loginBtnBgClick"];
        } else {
            self.warning03.image = [UIImage imageNamed:@"圆角矩形--圆角框"];
        }
        if ([array[2] boolValue] == TRUE) {
            self.warning06.image = [UIImage imageNamed:@"loginBtnBgClick"];
        } else {
            self.warning06.image = [UIImage imageNamed:@"圆角矩形--圆角框"];
        }
        if ([array[9] boolValue] == TRUE) {
            self.baozha06.image = [UIImage imageNamed:@"loginBtnBgClick"];
        } else {
            self.baozha06.image = [UIImage imageNamed:@"圆角矩形--圆角框"];
        }
        if ([array[0] boolValue] == TRUE) {
            self.baozha11.image = [UIImage imageNamed:@"loginBtnBgClick"];
        } else {
            self.baozha11.image = [UIImage imageNamed:@"圆角矩形--圆角框"];
        }
        if ([array[1] boolValue] == TRUE) {
            self.baozha12.image = [UIImage imageNamed:@"loginBtnBgClick"];
        } else {
            self.baozha12.image = [UIImage imageNamed:@"圆角矩形--圆角框"];
        }
        if ([array[3] boolValue] == TRUE) {
            self.baozha14.image = [UIImage imageNamed:@"loginBtnBgClick"];
        } else {
            self.baozha14.image = [UIImage imageNamed:@"圆角矩形--圆角框"];
        }
    } failure:^(NSError *error) {
        self.warning03.image = [UIImage imageNamed:@"灰色图标-切图"];
        self.warning06.image = [UIImage imageNamed:@"灰色图标-切图"];
        self.baozha06.image = [UIImage imageNamed:@"灰色图标-切图"];
        self.baozha11.image = [UIImage imageNamed:@"灰色图标-切图"];
        self.baozha12.image = [UIImage imageNamed:@"灰色图标-切图"];
        self.baozha14.image = [UIImage imageNamed:@"灰色图标-切图"];
    }];
    
    [singletonModbus readBitsFrom:(87 - 1) count:11 success:^(NSArray *array) {
        if ([array[2] boolValue] == TRUE) {
            self.warning04.image = [UIImage imageNamed:@"loginBtnBgClick"];
        } else {
            self.warning04.image = [UIImage imageNamed:@"圆角矩形--圆角框"];
        }
        if ([array[3] boolValue] == TRUE) {
            self.baozha04.image = [UIImage imageNamed:@"loginBtnBgClick"];
        } else {
            self.baozha04.image = [UIImage imageNamed:@"圆角矩形--圆角框"];
        }
        if ([array[0] boolValue] == TRUE) {
            self.warning08.image = [UIImage imageNamed:@"loginBtnBgClick"];
        } else {
            self.warning08.image = [UIImage imageNamed:@"圆角矩形--圆角框"];
        }
        if ([array[10] boolValue] == TRUE) {
            self.baozha15.image = [UIImage imageNamed:@"loginBtnBgClick"];
        } else {
            self.baozha15.image = [UIImage imageNamed:@"圆角矩形--圆角框"];
        }
        if ([array[1] boolValue] == TRUE) {
            self.baozha16.image = [UIImage imageNamed:@"loginBtnBgClick"];
        } else {
            self.baozha16.image = [UIImage imageNamed:@"圆角矩形--圆角框"];
        }
    } failure:^(NSError *error) {
        self.warning04.image = [UIImage imageNamed:@"灰色图标-切图"];
        self.baozha04.image = [UIImage imageNamed:@"灰色图标-切图"];
        self.warning08.image = [UIImage imageNamed:@"灰色图标-切图"];
        self.baozha15.image = [UIImage imageNamed:@"灰色图标-切图"];
        self.baozha16.image = [UIImage imageNamed:@"灰色图标-切图"];
    }];
}

-(void)dealloc
{
    [singletonModbus disconnect];
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
    self.navigationItem.title = currentName;}
-(void)runStateRight
{
    configureViewController *configure=[[configureViewController alloc]init];
    configure.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:configure animated:YES];
}
-(void)game
{
    GMLHighFrequencyListViewcontroller *highFrequencyList = [[GMLHighFrequencyListViewcontroller alloc]init];
    highFrequencyList.hidesBottomBarWhenPushed =YES;
    [self.navigationController pushViewController:highFrequencyList animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    singletonModbus =nil;
}


@end
