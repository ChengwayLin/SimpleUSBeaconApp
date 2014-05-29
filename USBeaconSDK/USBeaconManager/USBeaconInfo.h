//
//  USBeaconInfo.h
//  USBeaconKit
//
//  Created by wezger on 2014/5/5.
//  Copyright (c) 2014年 THLight Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface USBeaconInfo : NSObject

+(USBeaconInfo *)info;

@property (nonatomic,retain) NSString * tel;
@property (nonatomic,retain) NSString * url;
@property (nonatomic,retain) NSString * img;
@property (nonatomic,retain) NSString * note;
@property (nonatomic,retain) NSString * youtube;
@property (nonatomic,retain) NSString * describe;
@property (nonatomic,retain) NSDictionary * extend;

-(NSString*)logString;

@end
