
#import <Foundation/Foundation.h>
#import "ObjectiveLibModbus.h"

UIKIT_EXTERN NSString * const XMGBaseUrl;

UIKIT_EXTERN NSString * const XMGTabBarButtonDidRepeatClickNotification;

UIKIT_EXTERN NSString * const XMGTitleButtonDidRepeatClickNotification;

UIKIT_EXTERN CGFloat const XMGTabBarH;

UIKIT_EXTERN CGFloat const XMGTitlesViewH;

UIKIT_EXTERN CGFloat const XMGNavBarMaxY;

UIKIT_EXTERN CGFloat const XMGMargin;

UIKIT_EXTERN NSString *  currentIPAddress;
UIKIT_EXTERN NSString *  currentName;
UIKIT_EXTERN NSString * GMLcurrentState;

UIKIT_EXTERN int  GMLcurrentPort;
UIKIT_EXTERN int GMLcurrentdeviceID;
UIKIT_EXTERN NSUInteger GMLIDNO;


UIKIT_EXTERN ObjectiveLibModbus *singletonModbus;
UIKIT_EXTERN BOOL firstTapOrNot;
UIKIT_EXTERN NSArray *shortCircuit;
