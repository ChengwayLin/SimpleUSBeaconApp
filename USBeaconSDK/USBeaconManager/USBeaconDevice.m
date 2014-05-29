//
//  USBeaconDevice.m
//  USBeaconKit
//
//  Created by wezger on 2014/5/5.
//  Copyright (c) 2014年 THLight Ltd. All rights reserved.
//

#import "USBeaconDevice.h"

@implementation USBeaconDevice

+ (USBeaconDevice * )deviceWithMajor:(int)major Minor:(int)minor Name:(NSString*)name{
    USBeaconDevice * device = [[USBeaconDevice alloc] initWithMajor:major Minor:minor Name:name];
    return device;
}

- (id)initWithMajor:(int)major Minor:(int)minor Name:(NSString*)name{
    self = [super init];
    if (self) {
    _major = major;
    _minor = minor;
    _name = name;
    }
    return self;
}


-(void)logDevice
{
    
    NSLog(@"\n\nUSBeaconDevice \nNAME: %@ \nMAJOR: %d \nMinor: %d \n\nINFO%@  \n\nINFO IMMEDIATE%@   \n\nINFO NEAR%@   \n\nINFO FAR%@   \n\nINFO UNKNOWN PROXIMITY%@ ",
          _name,
          _major ,
          _minor,
          [_info logString],
          [_infoAtImmediate logString],
          [_infoAtNear logString],
          [_infoAtFar logString],
          [_infoAtFar logString] );
}

@end
