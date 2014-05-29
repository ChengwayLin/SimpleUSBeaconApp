//
//  BeaconDetect.h
//  iBeacons Demo
//
//  Created by wezger on 2014/5/20.
//  Copyright (c) 2014年 Mobient. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol BeaconDetectDelegate <NSObject>

@optional
-(void)nearestBeaconChangeTo:(CLBeacon*)beacon;
-(void)beaconListChangeTo:(NSArray*)beacons;

@end


@interface BeaconDetect : NSObject <CLLocationManagerDelegate>

//easy start
+ (BeaconDetect *)detectBeaconWithUUID:(NSString*)uuid;
+ (BeaconDetect *)detectBeaconWithUUIDs:(NSArray*)uuids;

//easy filter
-(NSArray*)beaconsNoUnknownProximity:(NSArray*)original;
-(NSArray*)beaconsSortedByMajorMinor:(NSArray*)original;
-(NSArray*)beaconsSortedByRSSI:(NSArray*)original;

@property (nonatomic,retain) NSMutableArray * targetUUIDs;
@property (nonatomic,retain) NSString * targetUUID;

@property (nonatomic,retain) NSArray * beaconList;
@property (nonatomic,retain) CLBeacon * nearistBeacon;
@property (nonatomic,retain) id <BeaconDetectDelegate> delegate;


@end
