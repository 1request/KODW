//
//  Beacon.h
//  Beacon
//
//  Copyright (c) 2014 Stone. All rights reserved.
//

#import <Foundation/Foundation.h>

@import CoreLocation;
@import CoreBluetooth;

static NSString * const kUUID_Estimote = @"B9407F30-F5F8-466E-AFF9-25556B57FE6D";
static NSString * const kUUID_AprilBrother = @"E2C56DB5-DFFB-48D2-B060-D0F5A71096E0";
static NSString * const kUUID_RadBeacon = @"2F234454-CF6D-4A0F-ADF2-F4911BA9FFA6";


static NSString * const kIdentifier = @"SomeIdentifier";


@protocol BeaconNotificationDelegate <NSObject>

- (void)NotifyWhenEntryBeacon:(CLBeaconRegion*)beaconRegion;
- (void)NotifyWhenExitBeacon:(CLBeaconRegion*)beaconRegion;

@end


@interface Beacon : NSObject<CLLocationManagerDelegate>

@property (nonatomic,assign) id<BeaconNotificationDelegate> delegate;

- (void) startMonitorBeacon:(NSString*)uuid major:(uint16_t)kMajor minor:(uint16_t)kMinor;

@end
