//
//  SimpleViewController.h
//  SimpleUSBeaconApp
//
//  Created by wezger on 2014/5/16.
//  Copyright (c) 2014年 THLight Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>


//Fetch USBeacon Data On usbeacon.com.tw
#import "USBCManager.h"
#import "USBeaconDevice.h"
#import "USBeaconInfo.h"

//Help you quick setup iBeacon Detect
#import "BeaconDetect.h"


@interface SimpleViewController : UIViewController <USBCManagerDelegate,BeaconDetectDelegate>

@end
