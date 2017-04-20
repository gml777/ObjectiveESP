
#import "GlobeConst.h"

NSString * const XMGBaseUrl = @"http://api.budejie.com/api/api_open.php";


NSString * const XMGTabBarButtonDidRepeatClickNotification = @"XMGTabBarButtonDidRepeatClickNotification";

NSString * const XMGTitleButtonDidRepeatClickNotification = @"XMGTitleButtonDidRepeatClickNotification";

CGFloat const XMGTabBarH = 49;

CGFloat const XMGTitlesViewH = 35;

CGFloat const XMGNavBarMaxY = 64;

CGFloat const XMGMargin = 10;
NSString *  currentIPAddress = @"192.168.3.152";
NSString *  currentName = @"1A1";
NSString * GMLcurrentState=@"运行";
int GMLcurrentPort = 502;
int GMLcurrentdeviceID = 1;
NSUInteger GMLIDNO = 1;
//BOOL GMLUpdateOrAdd = YES;//update=yes add=no
ObjectiveLibModbus *singletonModbus=nil;
BOOL firstTapOrNot = YES;
NSArray *shortCircuit = nil;
//BOOL
/*typedef NS_ENUM(NSUInteger, HFLStates) {
    HFLStatesCommunicationInterrupted  = 1,
    HFLStatesRun = 2,
    HFLStatesStop = 3,
    HFLStatesFaultAlarm = 4
};*/
