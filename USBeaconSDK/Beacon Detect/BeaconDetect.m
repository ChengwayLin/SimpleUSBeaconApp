//
//  BeaconDetect.m
//  iBeacons Demo
//
//  Created by wezger on 2014/5/20.
//  Copyright (c) 2014年 Mobient. All rights reserved.
//

#import "BeaconDetect.h"

@interface BeaconDetect ()

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (retain,nonatomic) NSMutableDictionary * beaconDic;



@end

@implementation BeaconDetect

+ (BeaconDetect *)detectBeaconWithUUID:(NSString*)uuid
{
    BeaconDetect * object = [[BeaconDetect alloc] initWithUUID:uuid];
    return object;
}

-(id)initWithUUID:(NSString*)uuid{
    
    self = [super init];
    if (self) {
        _targetUUIDs = [NSMutableArray arrayWithCapacity:5];
        [_targetUUIDs addObject:uuid];
        [self startSearching];
    }
    return self;
    
}

+ (BeaconDetect *)detectBeaconWithUUIDs:(NSArray*)uuids
{
    BeaconDetect * object = [[BeaconDetect alloc] initWithUUIDs:uuids];
    return object;
}

-(id)initWithUUIDs:(NSArray*)uuids{
    
    self = [super init];
    if (self) {
        _targetUUIDs = [NSMutableArray arrayWithCapacity:5];
        [_targetUUIDs addObjectsFromArray:uuids];
        [self startSearching];
    }
    return self;
    
}

-(void)startSearching
{
    //init
    _beaconDic = [NSMutableDictionary dictionaryWithCapacity:5];
    
    //beacon
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    
    //NSLog(@"start searching %@",_targetUUIDs);
    
    int count = 1;
    for ( NSString * uuid in _targetUUIDs ) {
        //NSLog(@"go %@",uuid);
        NSUUID * nsuuid = [[NSUUID alloc] initWithUUIDString:uuid];
        CLBeaconRegion * beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:nsuuid identifier:[NSString stringWithFormat:@"region%d",count]];
        [_locationManager startMonitoringForRegion:beaconRegion];
        count ++;
    }
    

}



#pragma mark CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error
{
    NSLog(@"%@",error);
}

- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region
{
    CLBeaconRegion * beaconRegion  = (CLBeaconRegion * )region;
    [self.locationManager startRangingBeaconsInRegion:beaconRegion];
    //NSLog(@"didStartMonitoringForRegion %@",region);
    
}

-(void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    //NSLog(@"didRangeBeacons %@",beacons);
    [_beaconDic setObject:beacons forKey:region.proximityUUID.UUIDString];
    [self callBackToUpdateBeaconList];
    
}

#pragma mark CallBack
-(void)callBackToUpdateBeaconList
{
    NSMutableArray * beaconsArray = [NSMutableArray arrayWithCapacity:5];
    for ( NSString * key in _beaconDic.allKeys ) {
        NSArray * beaconsFromSpecficUUID = _beaconDic[key];
        [beaconsArray addObjectsFromArray:beaconsFromSpecficUUID];
    }
    
    _beaconList = (NSArray *)beaconsArray;
    //NSLog(@"%@",_beaconList);
    
    if([self.delegate respondsToSelector:@selector(beaconListChangeTo:)])
    {
        [self.delegate beaconListChangeTo:_beaconList];
    }

    if([self.delegate respondsToSelector:@selector(nearestBeaconChangeTo:)])
    {
        NSArray * sorted = [self beaconsSortedByRSSI:_beaconList];
        if (sorted.count == 0) {
            
        }else{
            CLBeacon * nearist = sorted[0];
            if (_nearistBeacon == nil) {
                _nearistBeacon = nearist;
                [self.delegate nearestBeaconChangeTo:nearist];
            }else{
                if ([self beacon:_nearistBeacon isEqualToBeacon:nearist]) {
                    //
                }else{
                    _nearistBeacon = nearist;
                    [self.delegate nearestBeaconChangeTo:nearist];
                }
            }

        }
    }
    
}

#pragma mark EASY FILTER - beaconsSortedByMajorMinor


-(NSArray*)beaconsSortedByMajorMinor:(NSArray*)original
{
    NSMutableDictionary * beaconDicWithSortingKey = [NSMutableDictionary dictionaryWithCapacity:5];
    int count = 1;
    
    for (int j = 0; j < original.count ; j++) {
        if ([original[j] isKindOfClass:[CLBeacon class]]) {
            CLBeacon * beacon = original[j];
            NSString * extendedMajor = [self string:[NSString stringWithFormat:@"%d",beacon.major.intValue] FilledWithZeroToLenth:5];
            NSString * extendedMinor = [self string:[NSString stringWithFormat:@"%d",beacon.minor.intValue] FilledWithZeroToLenth:5];
            NSString * sortingKey = [NSString stringWithFormat:@"%@_%@_%@_%d",beacon.proximityUUID.UUIDString,extendedMajor,extendedMinor,count];
            [beaconDicWithSortingKey setObject:beacon forKey:sortingKey];
            count ++;
        }else{
        
        }
    }
    
    
    if (count == 1) {
        return original;
    }else{
        
        NSArray * sortedKeys = [beaconDicWithSortingKey.allKeys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        NSMutableArray * arrayToReturn = [NSMutableArray arrayWithCapacity:5];
        for ( NSString * sortedKey in sortedKeys ) {
            [arrayToReturn addObject:beaconDicWithSortingKey[sortedKey]];
        }
        return arrayToReturn;
    }
    
}



#pragma mark EASY FILTER - beaconsSortedByRSSI


-(NSArray*)beaconsSortedByRSSI:(NSArray*)original
{
    NSMutableDictionary * beaconDicWithSortingKey = [NSMutableDictionary dictionaryWithCapacity:5];
    int count = 1;
    
    for (int j = 0; j < original.count ; j++) {
        if ([original[j] isKindOfClass:[CLBeacon class]]) {
            CLBeacon * beacon = original[j];
            
            NSString * biasedRSSI;
            
            if (beacon.proximity == CLProximityUnknown ) {
                biasedRSSI = @"0";
            }else{
                biasedRSSI =  [NSString stringWithFormat:@"%ld", (beacon.rssi + 1000) ];
            }
            
            NSString * sortingKey = [self string:biasedRSSI FilledWithZeroToLenth:5];
            [beaconDicWithSortingKey setObject:beacon forKey:sortingKey];
            count ++;
        }else{
            
        }
    }
    
    //NSLog(@"%@",beaconDicWithSortingKey.allKeys);
    
    
    //return @[@"1",@"2"];
    
    if (count == 1) {
        return original;
    }else{
        
        NSArray * sortedKeys = [beaconDicWithSortingKey.allKeys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        NSMutableArray * arrayToReturn = [NSMutableArray arrayWithCapacity:5];
        for ( NSString * sortedKey in sortedKeys ) {
            //[arrayToReturn addObject:beaconDicWithSortingKey[sortedKey]];
            [arrayToReturn insertObject:beaconDicWithSortingKey[sortedKey] atIndex:0];
        }
        return arrayToReturn;
    }

}

#pragma mark EASY FILTER - beaconsNoUnknownProximity


-(NSArray*)beaconsNoUnknownProximity:(NSArray*)original
{
    NSMutableArray * array = [NSMutableArray arrayWithCapacity:5];
    for (int j = 0; j < original.count ; j++) {
        if ([original[j] isKindOfClass:[CLBeacon class]]) {
            CLBeacon * beacon = original[j];
            if (beacon.proximity == CLProximityUnknown ) {
            
            }else{
                [array addObject:beacon];
            }
        }else{
            
        }
    }
    
    return array;
    
}


#pragma mark helper

-(NSString *)string:(NSString*)originalString  FilledWithZeroToLenth:(int)length
{
    NSMutableString * string = [NSMutableString stringWithCapacity:5];
    if (originalString.length < length) {
        for (int i = 0 ; i < (length - originalString.length ); i++ ) {
            [string appendString:@"0"];
        }
        [string appendString:originalString];
    }else{
        [string appendString:[originalString substringWithRange:NSMakeRange(0, length)]];
    }
    
    return string;
}


-(BOOL)beacon:(CLBeacon*)beacon1 isEqualToBeacon:(CLBeacon*)beacon2
{
    //NSLog(@"compare \n %@ %@ \n %@ %@ \n %@ %@",beacon1.major,beacon2.major ,beacon1.minor,beacon2.minor,beacon1.proximityUUID.UUIDString,beacon2.proximityUUID.UUIDString);
    
    if(beacon1.major == beacon2.major && beacon1.minor == beacon2.minor && [beacon1.proximityUUID.UUIDString isEqualToString:beacon2.proximityUUID.UUIDString]){
        //NSLog(@"YES");
        return YES;
    }else{
        return NO;
    }
    
}




@end
