//
//  USBeaconInfo.m
//  USBeaconKit
//
//  Created by wezger on 2014/5/5.
//  Copyright (c) 2014年 THLight Ltd. All rights reserved.
//

#import "USBeaconInfo.h"

@implementation USBeaconInfo

+(USBeaconInfo *)info{

    USBeaconInfo * info = [[USBeaconInfo alloc] init];
    return info;
}


-(NSString*)logString
{
    
    NSString * string  = [NSString stringWithFormat:@"\ndescribe = %@ \ntel = %@ \nurl = %@ \nimg = %@ \nnote = %@ \nyoutube = %@ \nextend = %@",
                          _describe,
                          _tel,
                          _url,
                          _img,
                          _note,
                          _youtube,
                          _extend
                ];
    

    return string;

}

@end
