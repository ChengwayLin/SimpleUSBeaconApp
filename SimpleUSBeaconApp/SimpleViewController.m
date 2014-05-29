//
//  SimpleViewController.m
//  SimpleUSBeaconApp
//
//  Created by wezger on 2014/5/16.
//  Copyright (c) 2014年 THLight Ltd. All rights reserved.
//

#import "SimpleViewController.h"



@interface SimpleViewController ()

@property (retain,nonatomic) USBCManager * manager;
@property (retain,nonatomic) BeaconDetect * detect;

//UI
@property (retain,nonatomic) IBOutlet UILabel * nearistBeaconLabel;
@property (retain,nonatomic) IBOutlet UITextView * beaconDataTextView;

@end

@implementation SimpleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //USBC Data Fetch.  ( To keep it simple, we just fetch data from usbeacom.com.tw every time the App start.)
    _manager = [USBCManager defaultManager];
    _manager.delegate = self;
    [_manager updateDevicesWithDataQueryUUID:@"B3AFBCB6-0129-49EB-A453-A283E9710CF1"]; //It's a Data Query UUID of test@thlight.com
    
}


#pragma mark USBCManagerDelegate

-(void)USBCManagerUpdateComplete
{
    
    NSLog(@"Beacon Data Fetched from Server has been saved in your iPhone/iPad");
    
    //Print All Fetched Data
    /*
     USBCManager * manager = [USBCManager defaultManager];
     NSArray * array = [manager allDevices];
     for (int i = 0; i < array.count; i++) {
     USBeaconDevice * device = (USBeaconDevice *)array[i];
     [device logDevice];
     }
     */
    
    
    //Let our iPhone search nearby iBeacons.
    NSArray * uuids = @[@"E2C56DB5-DFFB-48D2-B060-D0F5A71096E0",@"23542266-18D1-4FE4-B4A1-23F8195B9D39"];
    _detect = [BeaconDetect detectBeaconWithUUIDs:uuids];
    _detect.delegate = self;
    
    
    

    
    
}

-(void)USBCManagerUpdateError:(NSError *)error
{
    //NSLog(@"%@",error);
}


#pragma mark BeaconDetectDelegate
-(void)beaconListChangeTo:(NSArray*)beacons
{
    //Update Beacon List Here(including all UUID you targeted);
}

-(void)nearestBeaconChangeTo:(CLBeacon*)beacon
{
    
    _nearistBeaconLabel.text = [NSString stringWithFormat:@"%d %d",beacon.major.intValue,beacon.minor.intValue];
    
    USBeaconDevice * deviceData = [_manager deviceWithMajor:beacon.major.intValue Minor:beacon.minor.intValue];
    _beaconDataTextView.text = [NSString stringWithFormat:@"名稱: %@\n描述: %@\n電話: %@\n備註: %@\n網址: %@\n自定Key: %@",
                                deviceData.name,
                                deviceData.info.describe,
                                deviceData.info.tel,
                                deviceData.info.note,
                                deviceData.info.url,
                                deviceData.info.extend
                                ];
    
}



@end
