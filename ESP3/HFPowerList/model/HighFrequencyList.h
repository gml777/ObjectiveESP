//
//  HighFrequencyList.h
//  ESP3
//
//  Created by 陈浩 on 17/1/13.
//  Copyright © 2017年 Nonvia. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HighFrequencyList : NSObject
typedef NS_ENUM(NSUInteger, HFLStates) {
    HFLStatesCommunicationInterrupted  = 1,
    HFLStatesRun = 2,
    HFLStatesStop = 3,
    HFLStatesFaultAlarm = 4
};
@property(nonatomic,strong)NSString *names;
@property(nonatomic,strong)NSString *ips;
@property(nonatomic,assign)HFLStates type;
@property(nonatomic,assign)int portNumber;
@property(nonatomic,assign)int deviceID;
@property(nonatomic,assign)NSInteger IDNO;
@end
