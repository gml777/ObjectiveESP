//
//  GMLHighFrequencyListViewcontroller.m
//  ModbusDemo
//
//  Created by 陈浩 on 16/12/19.
//
//
#import <sqlite3.h>
#import "HFLTableViewCell.h"
#import "shortCircuitTestViewController.h"
#import "addConfigureViewController.h"
#import "HighFrequencyList.h"
#import "modifyConfigureViewController.h"
#import "GMLHighFrequencyListViewcontroller.h"
#import "RunState1ViewController.h"
#import "GMLRunStopViewController.h"
#import "settingViewController.h"
#import "warningViewController.h"
#import "XMGNavigationController.h"
#import "XMGTabBarController.h"
#import "configureViewController.h"
//#import "AppDelegate.h"
//#import "FMDatabase.h"
@interface  GMLHighFrequencyListViewcontroller()
{
    NSMutableArray * allNews;
   // FMDatabase * db;
    UIView * nullView;
    
}
@property(nonatomic,strong)HighFrequencyList *hfl;
@property (nonatomic, strong) NSArray *tags;
@property (nonatomic, assign) NSInteger longPressRow;
@end
@implementation GMLHighFrequencyListViewcontroller
static NSString * const XMGTagCellId = @"tag";
-(instancetype)initWithStyle:(UITableViewStyle)style
{
    self=[super initWithStyle:style];
    if (self) {
        self.title=@"能为科技";
    }
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
  //  NSLog(@"ssss");
     [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 12, 0, 12)];
   // [self.tableView setLayoutMargins:UIEdgeInsetsMake(0, -12, 0, 12)];
   // UIButton *add=[[UIButton alloc]initWithFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)];
    //self.navigationItem.title = @"高频电源列表";
    //self.tableView.backgroundColor = XMGRandomColor;
    //self.tableView.contentInset = UIEdgeInsetsMake(XMGNavBarMaxY + XMGTitlesViewH, 0, XMGTabBarH, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
 /*   UILabel *header=[[UILabel alloc]initWithFrame:CGRectMake(50, 30, screenW-100, 30)];
    header.text=@"ccc";
    header.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:header];
    self.tableView.tableHeaderView=header;*/
   // self.tableView.contentInset=CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>);
    [self.tableView registerNib:[UINib nibWithNibName:@"HFLTableViewCell" bundle:nil] forCellReuseIdentifier:XMGTagCellId];
    allNews=[[NSMutableArray alloc]init];
    self.tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero]
    ;
    [self setupNavBar];
 //   AppDelegate * appDelegate=[UIApplication sharedApplication].delegate;
 //   db=appDelegate.db;
}
-(void)setupNavBar
{

    UIButton *rightbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [rightbtn setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
    [rightbtn setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
    [rightbtn sizeToFit];
    [rightbtn addTarget:self action:@selector(game) forControlEvents:UIControlEventTouchUpInside];
    UIView *rightContentView=[[UIView alloc]initWithFrame:rightbtn.bounds];
    [rightContentView addSubview:rightbtn];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:rightContentView];
    // 设置中间图片
    //self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    //self.navigationItem.title = @"运行方式";//@"1B1";
    // 设置右边按钮
    // self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"navigationButtonRandom"] highImage:[UIImage imageNamed:@"navigationButtonRandomClick"] target:nil action:nil];
}

-(void)game
{
   [self handleCopyCell:nil];
}

-(void)viewDidAppear:(BOOL)animated
{
  //  [self loadNews];
    [super viewDidAppear:animated];
    [self resolveData];
}

-(void)resolveData
{
    [allNews removeAllObjects];
    [self.tableView reloadData];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    path=[path stringByAppendingPathComponent:@"mydb.sqlite"];
   // NSLog(@"高频列表第一次记载%@",path);
    sqlite3 *db;
    sqlite3_stmt *stmt;
    char *sql="CREATE TABLE if not exists t_modbusConnectConfigure ('mingzi' text(4,0) NOT NULL,'ipdizhi' text(15,0) NOT NULL,'zhuangtai' text NOT NULL,'duankouhao' integer NOT NULL,'shebeihao' integer NOT NULL,'IDNO' integer NOT NULL,PRIMARY KEY('IDNO'));";
    char *error;
   int result = sqlite3_open([path UTF8String], &db);
    if (result != SQLITE_OK) {
      //  NSLog(@"open failed");
    }
     result=sqlite3_exec(db, sql, NULL, NULL, &error);
    if (result != SQLITE_OK) {
       // NSLog(@"run sql failed:%s",error);
    }


    sql="select * from t_modbusConnectConfigure";
    result=sqlite3_prepare_v2(db, sql, -1, &stmt, NULL);
    if (result==SQLITE_OK) {
      //  NSUInteger i=0;
        while (sqlite3_step(stmt)==SQLITE_ROW) {
            char * mingzi=(char *)sqlite3_column_text(stmt, 0);
            char *ipdizhi=(char *)sqlite3_column_text(stmt, 1);
            char *zhuangtai=(char *)sqlite3_column_text(stmt, 2);
            int duankouhao=sqlite3_column_int(stmt, 3);
            int shebeihao=sqlite3_column_int(stmt, 4);
            int idno=sqlite3_column_int(stmt, 5);
            NSString *strmingzi=[NSString stringWithUTF8String:mingzi];
            NSString *stripdizhi=[NSString stringWithUTF8String:ipdizhi];
            NSString *strzhuangtai=[NSString stringWithUTF8String:zhuangtai];
          //  NSLog(@"mingzi=%@,ipdizhi=%@,zhuangtai=%@,duankouhao=%d,shebeihao=%d",strmingzi,stripdizhi,strzhuangtai,duankouhao,shebeihao);
        //    self.hfl.names = strmingzi;
            // _tags = [HighFrequencyList mj_objectArrayWithFile:<#(NSString *)#>];
            HighFrequencyList *item=[[HighFrequencyList alloc]init];
            item.names=strmingzi;
            item.ips=stripdizhi;
            if ([strzhuangtai isEqualToString:@"运行"]) {
                item.type = HFLStatesRun;
               // item.
            } else if([strzhuangtai isEqualToString:@"停运"]){
                item.type = HFLStatesStop;
            }
            else if([strzhuangtai isEqualToString:@"故障告警"]){
                item.type = HFLStatesFaultAlarm;
            }
            else if([strzhuangtai isEqualToString:@"通信中断"]){
                item.type = HFLStatesCommunicationInterrupted;
            }
      //      [allNews insertObject:item atIndex:i];
            item.portNumber=duankouhao;
            item.deviceID=shebeihao;
            item.IDNO=idno;
            [allNews addObject:item];
          //  i++;
           // NSLog(@"%@",allNews);
        }
        
    } else {
       // NSLog(@"yu chu li shi bai");
    }
    sqlite3_finalize(stmt);
    sqlite3_close(db);
    if(allNews.count>0)
    {
        nullView.hidden=YES;
        [self.tableView reloadData];
    }
    else
    {
        [self createNullView];
    }
}
-(void)createNullView
{
    if(nullView==nil)
    {
        nullView=[[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.origin.y+40,self.view.frame.size.width, self.view.frame.size.height-40)];
      //  nullView.backgroundColor=[UIColor clearColor];
        [self.view addSubview:nullView];
        UIImageView * imageView=[[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width-128)/2, 200, 128, 106)];
        imageView.image=[UIImage imageNamed:@"null.png"];
        UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(0, imageView.frame.origin.y+imageView.frame.size.height, self.view.frame.size.width, 40)];
        label.text=@"当前没有找到高频电源列表，请添加！";
        label.textAlignment=NSTextAlignmentCenter;
        [nullView addSubview:label];
        [nullView addSubview:imageView];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button setTitle:@"新建一组配置" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.layer.cornerRadius = 10.0;
        button.layer.borderWidth = 1.0;
        button.frame = CGRectMake(30, 100, screenW - 60, 44);
        button.backgroundColor = [UIColor orangeColor];
        [button addTarget:self action:@selector(insertFirstconf) forControlEvents:UIControlEventTouchUpInside];
        self.longPressRow = -1;
        [nullView addSubview:button];;
    }
    else
    {
        nullView.hidden=NO;
    }
}
-(void)insertFirstconf
{
    addConfigureViewController *configure=[[addConfigureViewController alloc]initWithNibName:@"addConfigureViewController" bundle:nil];
    configure.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:configure animated:YES];
  //  GMLUpdateOrAdd=NO;
    configure.view.backgroundColor=[UIColor whiteColor];
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return allNews.count;//self.names.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  //  static NSString const *ID = @"cell";
    HFLTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:XMGTagCellId];
  
  /*  if (indexPath.row == 0) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"customCell"];//自定义cell
    }
    else{*/
        if (cell == nil) {
            cell = [[HFLTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:XMGTagCellId];
        }
    //}
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
 
    HighFrequencyList * news=allNews[indexPath.row];
    cell.mingzi.text=news.names;
    cell.ipdizhi.text=news.ips;
    switch (news.type) {
        case HFLStatesCommunicationInterrupted:
            cell.zhuangtai.image=[UIImage imageNamed:@"灰色图标-停运"];
            break;
        case HFLStatesRun:
            cell.zhuangtai.image=[UIImage imageNamed:@"运行-图标"];
            break;
        case HFLStatesStop:
            cell.zhuangtai.image=[UIImage imageNamed:@"绿色图标"];
            break;
        case HFLStatesFaultAlarm:
            cell.zhuangtai.image=[UIImage imageNamed:@"告警图标"];
        default:
            cell.zhuangtai.image=[UIImage imageNamed:@"灰色图标-停运"];
            break;
    }

    UILongPressGestureRecognizer * longPressGesture =[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(cellLongPress:)];
    [cell addGestureRecognizer:longPressGesture];
    
    return cell;
}
- (void)cellLongPress:(UIGestureRecognizer *)gestureRecognizer
{
     if(gestureRecognizer.state == UIGestureRecognizerStateBegan){
        HFLTableViewCell *cell = (HFLTableViewCell *)gestureRecognizer.view;
        [cell becomeFirstResponder];
        UIMenuItem *itDelete = [[UIMenuItem alloc] initWithTitle:@"删除" action:@selector(handleDeleteCell:)];
        UIMenuItem *itSelect = [[UIMenuItem alloc]initWithTitle:@"查看" action:@selector(HandleSelectCell:)];
        UIMenuItem *itUpdate = [[UIMenuItem alloc]initWithTitle:@"修改" action:@selector(handleUpdateCell:)];
        CGPoint point = [gestureRecognizer locationInView:self.tableView];
        NSIndexPath *index=[self.tableView indexPathForRowAtPoint:point];
        self.longPressRow = index.row;
        UIMenuController *menu = [UIMenuController sharedMenuController];
        [menu setMenuItems:[NSArray arrayWithObjects:/*itCopy, */itDelete,itSelect,itUpdate, nil]];
        [menu setTargetRect:cell.frame inView:self.tableView];
        [menu setMenuVisible:YES animated:YES];
    }
    else if(gestureRecognizer.state == UIGestureRecognizerStateEnded){
    }
    else if(gestureRecognizer.state == UIGestureRecognizerStateChanged){
    }
}
- (void)handleCopyCell:(id)sender{//增加cell
    addConfigureViewController *configure=[[addConfigureViewController alloc]initWithNibName:@"addConfigureViewController" bundle:nil];
    configure.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:configure animated:YES];
    //GMLUpdateOrAdd=NO;
    configure.view.backgroundColor=[UIColor whiteColor];
  
}

- (void)handleDeleteCell:(id)sender{//删除cell
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"你确定要删除这一行吗？" message:@"想好了？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction=[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self deleteData];
        [self.tableView reloadData];
    }];
    [alert addAction:okAction];
    UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        return ;
    }];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)HandleSelectCell:(UIMenuController *)sender{//查看cell
    configureViewController *configure=[[configureViewController alloc]initWithNibName:@"configureViewController" bundle:nil];
    configure.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:configure animated:YES];
    NSString *str=[[allNews objectAtIndex:self.longPressRow] names];
    configure.view.backgroundColor=[UIColor whiteColor];
    configure.mingziText.text=[NSString stringWithFormat:@"%@",str];
    str=[[allNews objectAtIndex:self.longPressRow] ips];
    configure.ipdizhiText.text=[NSString stringWithFormat:@"%@",str];
    HighFrequencyList *item=[allNews objectAtIndex:self.longPressRow];
    HFLStates state = item.type;
    switch (state) {
        case HFLStatesRun:
            configure.zhuangtaiText.text=@"运行";
            break;
        case HFLStatesStop:
            configure.zhuangtaiText.text=@"停运";
            break;
        case HFLStatesFaultAlarm:
            configure.zhuangtaiText.text=@"故障告警";
            break;
        case HFLStatesCommunicationInterrupted:
            configure.zhuangtaiText.text=@"通信中断";
            break;
        default:
            configure.zhuangtaiText.text=@"?";
            break;
    }
    int temp =[[allNews objectAtIndex:self.longPressRow] portNumber];
    configure.duankouhaoText.text=[NSString stringWithFormat:@"%d",temp];
    temp=[[allNews objectAtIndex:self.longPressRow] deviceID];
    configure.shebeihaoText.text=[NSString stringWithFormat:@"%d",temp];
    configure.operateButton.hidden=YES;
}
- (void)handleUpdateCell:(id)sender{//修改cell
    modifyConfigureViewController *configure=[[modifyConfigureViewController alloc]initWithNibName:@"modifyConfigureViewController" bundle:nil];
    configure.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:configure animated:YES];
  //  GMLUpdateOrAdd=YES;
    NSString *str=[[allNews objectAtIndex:self.longPressRow] names];
    configure.view.backgroundColor=[UIColor whiteColor];
    configure.modifyName.text=[NSString stringWithFormat:@"%@",str];
    str=[[allNews objectAtIndex:self.longPressRow] ips];
    configure.modifyIPAddress.text=[NSString stringWithFormat:@"%@",str];
  //  HighFrequencyList *item=[allNews objectAtIndex:self.longPressRow];
/*    HFLStates state = item.type;
    // NSLog(@"%d",item.type);
    switch (state) {
        case HFLStatesRun:
            configure.zhuangtaiText.text=@"运行";
            break;
        case HFLStatesStop:
            configure.zhuangtaiText.text=@"停运";
            break;
        case HFLStatesFaultAlarm:
            configure.zhuangtaiText.text=@"故障告警";
            break;
        case HFLStatesCommunicationInterrupted:
            configure.zhuangtaiText.text=@"通信中断";
            break;
        default:
            configure.zhuangtaiText.text=@"?";
            break;
    }*/
    int temp =[[allNews objectAtIndex:self.longPressRow] portNumber];
    configure.modifyPortNumber.text=[NSString stringWithFormat:@"%d",temp];
    temp=[[allNews objectAtIndex:self.longPressRow] deviceID];
    configure.modifyDeviceID.text=[NSString stringWithFormat:@"%d",temp];
    configure.itemBeforeModify = [allNews objectAtIndex:self.longPressRow];
   
}

- (BOOL)canBecomeFirstResponder{
    return YES;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    if (firstTapOrNot == YES) {
        RunState1ViewController *runState=[[RunState1ViewController alloc]init];
        UINavigationController *nav1=[[XMGNavigationController alloc]initWithRootViewController:runState];
        nav1.tabBarItem.title=@"运行";
        nav1.tabBarItem.image=[UIImage imageNamed:@"运行图标"];
        nav1.tabBarItem.selectedImage=[UIImage imageNamed:@"运行图标--点击时态"];
        // nav1.tabBarItem.badgeValue=@"32";
        settingViewController *setting=[[settingViewController alloc]init];
        UINavigationController *nav2=[[XMGNavigationController alloc]initWithRootViewController:setting];
        nav2.tabBarItem.title=@"参数";
        nav2.tabBarItem.image=[UIImage imageNamed:@"338280223"];
        nav2.tabBarItem.selectedImage=[UIImage imageNamed:@"参数-点击时态"];
        
        GMLRunStopViewController *runStop=[[GMLRunStopViewController alloc]initWithNibName:@"GMLRunStopViewController" bundle:nil];
        UINavigationController *nav3=[[XMGNavigationController alloc]initWithRootViewController:runStop];
        
        nav3.tabBarItem.title=@"启停";
        nav3.tabBarItem.image=[UIImage imageNamed:@"启停-常态"];
        nav3.tabBarItem.selectedImage=[UIImage imageNamed:@"启停--点击时态"];
        
        warningViewController *warning=[[warningViewController alloc]init];
        UINavigationController *nav4=[[XMGNavigationController alloc]initWithRootViewController:warning];
        nav4.tabBarItem.title=@"告警";
        nav4.tabBarItem.image=[UIImage imageNamed:@"告警-常态"];
        nav4.tabBarItem.selectedImage=[UIImage imageNamed:@"告警点击时态"];
        shortCircuitTestViewController *advance=[[shortCircuitTestViewController alloc]initWithNibName:@"shortCircuitTestViewController" bundle:nil];
        UINavigationController *nav5=[[XMGNavigationController alloc]initWithRootViewController:advance];
        nav5.tabBarItem.title=@"高级";
        nav5.tabBarItem.image=[UIImage imageNamed:@"tabBar_essence_icon"];
        nav5.tabBarItem.selectedImage=[UIImage imageNamed:@"tabBar_essence_click_icon"];
        XMGTabBarController *tabBar=[[XMGTabBarController alloc]init];
        [tabBar addChildViewController:nav1];
        [tabBar addChildViewController:nav2];
        [tabBar addChildViewController:nav3];
        [tabBar addChildViewController:nav4];
        [tabBar addChildViewController:nav5];
        self.longPressRow = indexPath.row;
        HighFrequencyList *item=[allNews objectAtIndex:self.longPressRow];
        currentName = item.names;
        currentIPAddress=item.ips;
        GMLcurrentPort = item.portNumber;
        GMLcurrentdeviceID=item.deviceID;
        singletonModbus = [[ObjectiveLibModbus alloc]initWithTCP:currentIPAddress port:GMLcurrentPort device:GMLcurrentdeviceID];
        [singletonModbus connect:^{
            
        } failure:^(NSError *error) {
            GMLcurrentState = @"通信中断";
        }];
        [UIApplication sharedApplication].keyWindow.rootViewController=tabBar;
        firstTapOrNot = NO;
 
    } else {
        self.longPressRow = indexPath.row;
        HighFrequencyList *item=[allNews objectAtIndex:self.longPressRow];
        currentName = item.names;
        currentIPAddress=item.ips;
        GMLcurrentPort = item.portNumber;
        GMLcurrentdeviceID=item.deviceID;
        [singletonModbus disconnect];
        singletonModbus = nil;
        singletonModbus = [[ObjectiveLibModbus alloc]initWithTCP:currentIPAddress port:GMLcurrentPort device:GMLcurrentdeviceID];
        [singletonModbus connect:^{
            
        } failure:^(NSError *error) {
            GMLcurrentState = @"通信中断";
        }];
        [self.navigationController popViewControllerAnimated:YES];
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{return 51;}

/**
 *  删
 */
-(void)deleteData
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    path=[path stringByAppendingPathComponent:@"mydb.sqlite"];
    NSLog(@"高频列表删除%@",path);
    sqlite3 *db;
    int result = sqlite3_open([path UTF8String], &db);
    if (result != SQLITE_OK) {
        NSLog(@"open failed");
    }
    char *sql="CREATE TABLE if not exists t_modbusConnectConfigure ('mingzi' text(4,0) NOT NULL,'ipdizhi' text(15,0) NOT NULL,'zhuangtai' text NOT NULL,'duankouhao' integer NOT NULL,'shebeihao' integer NOT NULL,'IDNO' integer NOT NULL,PRIMARY KEY('IDNO'));";
    char *error;
    result=sqlite3_exec(db, sql, NULL, NULL, &error);
    if (result != SQLITE_OK) {
        NSLog(@"run sql failed打开:%s",error);
    }
    NSInteger keynumber=self.longPressRow + 1;
    NSString *gml=[NSString stringWithFormat:@"delete from t_modbusConnectConfigure where IDNO='%d'      ",keynumber];
    NSLog(@"%d",keynumber);
    result=sqlite3_exec(db, [gml UTF8String], NULL, NULL, &error);
    if (result != SQLITE_OK) {
        NSLog(@"run sql failed执行删除:%s",error);
    }
    sqlite3_close(db);
}
/*-(void)dealloc
{
    [singletonModbus r];
    [super dealloc];
}*/
@end


