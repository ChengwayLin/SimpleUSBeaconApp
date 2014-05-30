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

```objc
+ (USBCManager *)defaultManager;
```
**+ defaultManager**<br>
Returns an USBeaconManager object. (NOTE:This object is neither static nor singleton. So declare it as a property in your viewCotroller.)
<br><br>
```objc
-(void)updateDevicesWithDataQueryUUID:(NSString*)dataQueryUUID;
```
**- updateDevicesWithDataQueryUUID:** fetch beacon data from specific account Data Query UUID. You can register your own account on www.usbeacon.com.tw. Fetched beacon data will be stored on local. After data fetched and stored, USBeaconManager calls **-USBCManagerUpdateComplete** delegate method to inform your app. If errors occur during data downloading, it informs app through  **- USBCManagerUpdateError:**. <br><br>
To use local data, you can call **- deviceWithMajor: Minor:**, that would retun local data in **USBeaconDevice** object. Besides, you can also call **- allDevices** ,that would return all local data in an NSArray of **USBeaconDevice**;
<br><br>
```objc
-(USBeaconDevice *)deviceWithMajor:(int)major Minor:(int)minor;
```
**- deviceWithMajor: Minor:** return a USBeaconDevice object of speccific major and minor from local storage. If there is no this major/minor data, it return a empty USBeaconDevice.
<br><br>
```objc
-(NSArray *)allDevices;
```
**- allDevices** return an NSArray of USBeaconDevice ,that contains all local usbeacon device data.
<br><br>

###USBeaconManagerDelegate Protocol###

**@optional**
```objc
-(void)USBCManagerUpdateComplete;
```
Tells the delegate that data update process completed.
```objc
-(void)USBCManagerUpdateError:(NSError*)error;
```
Tells the delegate that data update process errors occured.
