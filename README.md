SimpleUSBeaconApp
=================

SimpleUSBeaconApp is to show a basic functionality of USBeaconSDK. 

##App Concept##
The concept is simple. When app starts, it fetches beacon data from http://www.usbeacon.com.tw from a test account test@thlight.com ( DataQueryUUID:B3AFBCB6-0129-49EB-A453-A283E9710CF1 ) . Fetched data would be stored using SQLite on iDevices.
<br>

After fetching process completes, the app starts to range nearby iBeacons. In this App, it searches iBeacons with UUID:E2C56DB5-DFFB-48D2-B060-D0F5A71096E0 (UUID of apple AirLocate). When iBeacons with this UUID are found, the app shows the nearist one on the screen.
<br>

The corresponding data would be displayed.  If the nearest iBeacon around your device is one of the following:
<br>


|   name   | UUID | Major | Minor |
| ------------- | ------------- | ------------- |  ------------- |
| BEACON1  | E2C56DB5-DFFB-48D2-B060-D0F5A71096E0 | 99 | 0 |
| BEACON2  | E2C56DB5-DFFB-48D2-B060-D0F5A71096E0 | 99 | 1 |
| BEACON1  | E2C56DB5-DFFB-48D2-B060-D0F5A71096E0 | 99 | 2 |
| BEACON2  | E2C56DB5-DFFB-48D2-B060-D0F5A71096E0 | 99 | 3 |


<br>

USBeaconSDK (Beta)
=================

##USBeaconManager Class##
###Overview###

The USBeaconManager declares the programmatic interface for fetching Beacon related data from server of http://www.usbeacon.com.tw and manage local beacon data for developer.


###Properties###

###Methods###

**+ defaultManager **
```objc
+ (USBCManager *)defaultManager;
```
defaultManager return an USBeaconManager object. This object is not static or singleton. So declare it as a property in your viewCotroller.

```objc
-(void)updateDevicesWithDataQueryUUID:(NSString*)dataQueryUUID;
```


```objc
-(USBeaconDevice *)deviceWithMajor:(int)major Minor:(int)minor;
```

```objc
-(NSArray *)allDevices;

```

###USBeaconManagerDelegate###

**@optional**
```objc
-(void)USBCManagerUpdateComplete;
```
```objc
-(void)USBCManagerUpdateError:(NSError*)error;
```
