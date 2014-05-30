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
```
@property (nonatomic,weak) id <USBCManagerDelegate> delegate;
```
**delegate**<br>
The delegate object to receive update events.
<br><br>

###Methods###

```
+ (USBCManager *)defaultManager;
```
**+ defaultManager**<br>
Returns an USBeaconManager object. (NOTE:This object is neither static object nor singleton. So declare it as a property in your viewCotroller.)
<br><br>
```
-(void)updateDevicesWithDataQueryUUID:(NSString*)dataQueryUUID;
```
**- updateDevicesWithDataQueryUUID:**<br> 
Fetches beacon data from specific account Data Query UUID. You can register your own account on usbeacon.com.tw. Fetched beacon data will be stored on local. After data fetched and stored, USBeaconManager calls **-USBCManagerUpdateComplete** delegate method to inform your app. If errors occur during data downloading, it informs app through  **- USBCManagerUpdateError:**. <br><br>
To use local data, you can call **- deviceWithMajor: Minor:**, that would retun local data in USBeaconDevice object. Besides, you can also call **- allDevices** ,that would return all local data in an NSArray of USBeaconDevice;
<br><br>
```
-(USBeaconDevice *)deviceWithMajor:(int)major Minor:(int)minor;
```
**- deviceWithMajor: Minor:**<br> 
Returns a USBeaconDevice object of speccific major and minor from local storage. If there is no this major/minor data, it return a empty USBeaconDevice.
<br><br>
```
-(NSArray *)allDevices;
```
**- allDevices** <br>
Returns an NSArray of USBeaconDevice ,that contains all local usbeacon device data.
<br><br>

###USBeaconManagerDelegate Protocol###

**@optional**
```
-(void)USBCManagerUpdateComplete;
```
Tells the delegate that data update process completed.
```
-(void)USBCManagerUpdateError:(NSError*)error;
```
Tells the delegate that data update process errors occured.
<br><br>

##USBeaconDevice Class##
###Overview###
The USBeaconDevice class represents a usbeacon data with a specific pair of major/minor. In most case, you do not create instances of this class directly. The USBeaconManager object return data in this model class for you.
###Properties###
```
@property int major;
```
**major**<br> 
major number of a usbeacon data.
```
@property int minor;
```
**minor**<br> 
minor number of a usbeacon data.

```
@property (nonatomic,retain) NSString * name;
```
**name**<br> 
name of a usbeacon data.

```
@property (nonatomic,retain) USBeaconInfo * info;
```
**info**<br> 
a object contains a set of infomation of default  proximity  - immediate.<br>

On usbeacon.com.tw ,you can specify different set of data at each proximity, so here we have four other USBeaconInfo properties: infoAtImmediate, infoAtNear , infoAtFar and infoAtUnknownProximity.<br><br>
If you merely assign data for default(immediate) form, then USBeaconDevice will obtain your data in infoAtImmediate and info.<br><br>
If you set '所有資料同Immediate', then info, infoAtImmediate, infoAtNear ,infoAtFar ,infoAtUnknownProximity would be the same.<br><br>
Else if you specified data for each proximity, infoAtImmediate, infoAtNear ,infoAtFar ,infoAtUnknownProximity would obtain data you assigned respectively. And info property would has a copy of infoAtImmediate.
<br><br>

```
@property (nonatomic,retain) USBeaconInfo * infoAtImmediate;
```
**infoAtImmediate**<br> 
a object contains a set of infomation of proximity immediate.
```
@property (nonatomic,retain) USBeaconInfo * infoAtNear;
```
**infoAtNear**<br> 
a object contains a set of infomation of proximity near.
```
@property (nonatomic,retain) USBeaconInfo * infoAtFar;
```
**infoAtFar**<br> 
a object contains a set of infomation of proximity far.
```
@property (nonatomic,retain) USBeaconInfo * infoAtUnknownProximity;
```
**infoAtUnknownProximity**<br> 
a object contains a set of infomation of proximity unknown proximity.

###Methods###

```
-(void)logDevice;
```
**-logDevice**<br> 
NSlog this USBeaconDevice.

##USBeaconInfo Class##
###Overview###
USBeaconInfo is a model class to store a subset of usbeacon data for a specific proximity.

###Properties###
```
@property (nonatomic,retain) NSString * tel;
```

```
@property (nonatomic,retain) NSString * url;
```

```
@property (nonatomic,retain) NSString * img;
```

```
@property (nonatomic,retain) NSString * note;
```

```
@property (nonatomic,retain) NSString * youtube;
```

```
@property (nonatomic,retain) NSString * describe;
```

```
@property (nonatomic,retain) NSDictionary * extend;
```
**extend**<br> 
extented data you defined on website is stored as NSDictionary in this extend property.


##BeaconDetect Class##
###Overview###
BeaconDetect is a helper class based on iOS CoreLocation framework. It is to help you quickly set up iBeacon ranging process. It has some filter method let you sort CLbeacon Arrays with UUID/RSSI or return an array without iBeacon in Unknown Proximity. 

###Properties###
```
@property (nonatomic,retain) NSMutableArray * targetUUIDs;
```
**targetUUIDs**<br>
Targeted uuids that BeaconDetect object is searching for. If you initialized this object with **+ detectBeaconWithUUIDs:** method, then it stored uuids in targetUUIDs.
```

@property (nonatomic,retain) NSString * targetUUID;
```
**targetUUID**<br>
The only targeted uuid that BeaconDetect object is searching for. If you initialized this object with **+ detectBeaconWithUUID:** method, then the uuid is assigned to targetUUID.
```
@property (nonatomic,retain) NSArray * beaconList;
```
**beaconList**<br>
This array maintains all CLbeacons ranged by the system. The contain all beacons from all targeted uuids. Every time system range beacons, BeaconDetect call delegate method **- nearestBeaconChangeTo:**
```
@property (nonatomic,retain) CLBeacon * nearistBeacon;
```
**nearistBeacon**<br>
The property hold the nearist beacon around your iDevice. When nearistBeacon changed, it calls delegate method **- beaconListChangeTo:**.
```
@property (nonatomic,retain) id <BeaconDetectDelegate> delegate;
```
**delegate**<br>
The delegate object to receive update event.


###Methods###
```
+ (BeaconDetect *)detectBeaconWithUUID:(NSString*)uuid;
```
**+ detectBeaconWithUUID:**<br> 
Returns a BeaconDetect object and start to monitor region with the specific uuid and than range beacons.
```
+ (BeaconDetect *)detectBeaconWithUUIDs:(NSArray*)uuids;
```
**+ detectBeaconWithUUIDs:**<br> 
Returns a BeaconDetect object and start to monitor regions with the specific uuids and than range beacons.
```
-(NSArray*)beaconsNoUnknownProximity:(NSArray*)original;
```
**- beaconsNoUnknownProximity:**<br> 
Returns an array with no CLBeacon with no iBeacon in Unknown Proximity.
```
-(NSArray*)beaconsSortedByMajorMinor:(NSArray*)original;
```
**- beaconsSortedByMajorMinor:**<br> 
Returns an array sorted with UUID-MAJOR-MINOR
```
-(NSArray*)beaconsSortedByRSSI:(NSArray*)original;
```
**- beaconsSortedByRSSI:**<br> 
Returns an array sorted with RSSI value

###BeaconDetectDelegate Protocol###

**@optional**<br>
```
-(void)nearestBeaconChangeTo:(CLBeacon*)beacon;
```
**- nearestBeaconChangeTo:**<br> 
would be called, when nearistBeacon property changes.
```
-(void)beaconListChangeTo:(NSArray*)beacons;
```
**- beaconListChangeTo:**<br> 
would be called everytime the systme updated new ranged iBeacons.


How Use USBeaconSDK in Your Project
=================
1. drag USBeaconSDK folder into your Xcode Project (Make sure you check you project name at Add to Target )
2. In Build Phases > Link Binary with Libraries, add 'libz.dylib' and 'libsqlite3.dylib'
3. In Build Setting > Linking > Other Linker Flags, if right field is empty, then add -ObjC. (This is because USbeaconManager.a is based on FMDB. and FMDM has .o file)
4. Done. Start use it
