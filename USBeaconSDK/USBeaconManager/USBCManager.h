//
//  USBCManager.h
//  USBeaconKit
//
//  Created by wezger on 2014/5/9.
//  Copyright (c) 2014年 THLight Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "USBeaconDevice.h"
#import "USBeaconInfo.h"

@protocol USBCManagerDelegate <NSObject>

@required

@optional
-(void)USBCManagerUpdateComplete;
-(void)USBCManagerUpdateError:(NSError*)error;

@end


@interface USBCManager : NSObject <NSURLConnectionDataDelegate,NSURLConnectionDelegate,NSXMLParserDelegate>

@property (nonatomic,weak) id <USBCManagerDelegate> delegate;

+ (USBCManager *)defaultManager;
-(void)updateDevicesWithDataQueryUUID:(NSString*)dataQueryUUID;
-(USBeaconDevice *)deviceWithMajor:(int)major Minor:(int)minor;
-(NSArray *)allDevices;

@end
