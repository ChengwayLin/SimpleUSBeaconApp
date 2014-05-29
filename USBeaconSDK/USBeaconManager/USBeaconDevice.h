//
//  USBeaconDevice.h
//  USBeaconKit
//
//  Created by wezger on 2014/5/5.
//  Copyright (c) 2014年 THLight Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "USBeaconInfo.h"

@interface USBeaconDevice : NSObject

+ (USBeaconDevice * )deviceWithMajor:(int)major Minor:(int)minor Name:(NSString*)name;
@property int major;
@property int minor;
@property (nonatomic,retain) NSString * name;
@property (nonatomic,retain) USBeaconInfo * info;
@property (nonatomic,retain) USBeaconInfo * infoAtImmediate;
@property (nonatomic,retain) USBeaconInfo * infoAtNear;
@property (nonatomic,retain) USBeaconInfo * infoAtFar;
@property (nonatomic,retain) USBeaconInfo * infoAtUnknownProximity;

-(void)logDevice;


@end
