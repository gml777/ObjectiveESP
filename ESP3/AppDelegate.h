//
//  AppDelegate.h
//  ESP3
//

//  Copyright © 2016年 Nonvia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
/*{
    NSString *IPAddress;
    NSString *name;
    NSString *port;
    NSString *deviceID;
}*/
//@property (nonatomic, strong) XMGTabBarController *manager;
//@property (nonatomic, strong) XMGNavigationController *tableview;
@property (strong, nonatomic) UIWindow *window;
//@property (strong, nonatomic) FMDatabase * db;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
/*@property(nonatomic,retain)NSString *IPAddress;
@property(nonatomic,retain)NSString *name;
@property(nonatomic,retain)NSString *port;
@property(nonatomic,retain)NSString *deviceID;*/
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

