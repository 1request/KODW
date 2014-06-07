//
//  Beacon.m
//  Beacon
//
//  Copyright (c) 2014 Stone. All rights reserved.
//

#import "Beacon.h"




@interface Beacon ()

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLBeaconRegion *beaconRegion;
@property (nonatomic, strong) CLBeaconRegion *beaconRegion1;
@property (nonatomic, strong) CLBeaconRegion *beaconRegion2;
@property (nonatomic, strong) CLBeaconRegion *beaconRegion3;
@property (nonatomic, strong) CLBeaconRegion *beaconRegion4;
@property (nonatomic, strong) CLBeaconRegion *beaconRegion5;
@property (nonatomic, strong) CLBeaconRegion *beaconRegion6;


@end



@implementation Beacon

#pragma mark - Common
- (void)createBeaconRegion:(NSString*)uuid major:(uint16_t)kMajor minor:(uint16_t)kMinor{
    if (self.beaconRegion)
        return;
    
    NSUUID *proximityUUID = [[NSUUID alloc] initWithUUIDString:uuid];
    
//    NSUUID *rad = [[NSUUID alloc] initWithUUIDString:kUUID_RadBeacon];
    
    // Custom major / minor
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:proximityUUID major:kMajor minor:kMinor identifier:kIdentifier];
    self.beaconRegion.notifyEntryStateOnDisplay = YES;
    self.beaconRegion.notifyOnEntry = YES;
    self.beaconRegion.notifyOnExit = YES;
    
    // FIXME: Hardcode Beacons
    self.beaconRegion1 = [[CLBeaconRegion alloc] initWithProximityUUID:proximityUUID major:9 minor:62253 identifier:@"Reception"];
    self.beaconRegion1.notifyEntryStateOnDisplay = YES;
    self.beaconRegion1.notifyOnEntry = YES;
    self.beaconRegion1.notifyOnExit = YES;
    
    self.beaconRegion2 = [[CLBeaconRegion alloc] initWithProximityUUID:proximityUUID major:9  minor:26057 identifier:@"beacon2"];
    self.beaconRegion2.notifyEntryStateOnDisplay = YES;
    self.beaconRegion2.notifyOnEntry = YES;
    self.beaconRegion2.notifyOnExit = YES;
    
    
    self.beaconRegion3 = [[CLBeaconRegion alloc] initWithProximityUUID:proximityUUID major:9  minor:50549 identifier:@"beacon3"];
    self.beaconRegion3.notifyEntryStateOnDisplay = YES;
    self.beaconRegion3.notifyOnEntry = YES;
    self.beaconRegion3.notifyOnExit = YES;
    
    self.beaconRegion4 = [[CLBeaconRegion alloc] initWithProximityUUID:proximityUUID major:8  minor:7102 identifier:@"beacon4"];
    self.beaconRegion4.notifyEntryStateOnDisplay = YES;
    self.beaconRegion4.notifyOnEntry = YES;
    self.beaconRegion4.notifyOnExit = YES;
    
    self.beaconRegion5 = [[CLBeaconRegion alloc] initWithProximityUUID:proximityUUID major:8  minor:31008 identifier:@"beacon5"];
    self.beaconRegion5.notifyEntryStateOnDisplay = YES;
    self.beaconRegion5.notifyOnEntry = YES;
    self.beaconRegion5.notifyOnExit = YES;
    
    self.beaconRegion6 = [[CLBeaconRegion alloc] initWithProximityUUID:proximityUUID major:8  minor:31664 identifier:@"beacon6"];
    self.beaconRegion6.notifyEntryStateOnDisplay = YES;
    self.beaconRegion6.notifyOnEntry = YES;
    self.beaconRegion6.notifyOnExit = YES;
    
    
}

- (void)createLocationManager
{
    if (!self.locationManager) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
    }
}


- (void) startMonitorBeacon:(NSString*)uuid major:(uint16_t)kMajor minor:(uint16_t)kMinor{
    
    [self createLocationManager];
    
    DLog(@"Turning on monitoring...");
    
    if (![CLLocationManager isMonitoringAvailableForClass:[CLBeaconRegion class]]) {
        DLog(@"Couldn't turn on region monitoring: Region monitoring is not available for CLBeaconRegion class.");
        return;
    }
    
    [self createBeaconRegion:uuid major:kMajor minor:kMinor];
    
    [self.locationManager requestAlwaysAuthorization];
    
    [self.locationManager startMonitoringForRegion:self.beaconRegion];
    
//    [self.locationManager startMonitoringForRegion:self.beaconRegion1];
//    DLog(@"Monitoring turned on for region: %@.", self.beaconRegion1);
//    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.locationManager startMonitoringForRegion:self.beaconRegion2];
//        DLog(@"Monitoring turned on for region: %@.", self.beaconRegion2);
//        
//        
//    });
//    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.locationManager startMonitoringForRegion:self.beaconRegion3];
//        DLog(@"Monitoring turned on for region: %@.", self.beaconRegion3);
//        
//    });
//    
//    [self.locationManager startMonitoringForRegion:self.beaconRegion4];
//    [self.locationManager startMonitoringForRegion:self.beaconRegion5];
//    [self.locationManager startMonitoringForRegion:self.beaconRegion6];
    
    
}


- (void)stopMonitoringForBeacons
{
//    [self.locationManager stopMonitoringForRegion:self.beaconRegion1];
//    [self.locationManager stopMonitoringForRegion:self.beaconRegion2];
    
    DLog(@"Turned off monitoring");
}


#pragma mark - Location manager delegate methods
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (![CLLocationManager locationServicesEnabled]) {
        DLog(@"Couldn't turn on monitoring: Location services are not enabled.");
        return;
    }
    
    if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorized) {
        DLog(@"Couldn't turn on monitoring: Location services not authorised.");
    }
    
    if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedAlways) {
        DLog(@"Couldn't turn on monitoring: Location services (Always) not authorised.");
        return;
    }
    
}

- (void)locationManager:(CLLocationManager *)manager
        didRangeBeacons:(NSArray *)beacons
               inRegion:(CLBeaconRegion *)region {
    
    DLog(@"%s Range region: %@ with beacons %@",__PRETTY_FUNCTION__ ,region , beacons);
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLBeaconRegion *)region
{
    DLog(@"Entered region: %@", region);
    
    if (self.delegate) {
        [self.delegate NotifyWhenEntryBeacon:region];
    }
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLBeaconRegion *)region
{
    DLog(@"Exited region: %@", region);
    
    if (self.delegate) {
        [self.delegate NotifyWhenExitBeacon:region];
    }
    
}

- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region
{
    NSString *stateString = nil;
    switch (state) {
        case CLRegionStateInside:
            stateString = @"inside";
            break;
        case CLRegionStateOutside:
            stateString = @"outside";
            break;
        case CLRegionStateUnknown:
            stateString = @"unknown";
            break;
    }
    DLog(@"State changed to %@ for region %@.", stateString, region);
    
    
}

- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLBeaconRegion *)region withError:(NSError *)error
{
    NSString *message = [NSString stringWithFormat:@"error: %@ / region: %@", [error description], region.minor];
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"KODW" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [view show];
}

#pragma mark - Local notifications
- (void)sendLocalNotificationForBeaconRegion:(CLBeaconRegion *)region
{
    UILocalNotification *notification = [UILocalNotification new];
    
    // Notification details
    notification.alertBody = [NSString stringWithFormat:@"Entered beacon region for UUID: %@",
                              region.proximityUUID.UUIDString];   // Major and minor are not available at the monitoring stage
    notification.alertAction = NSLocalizedString(@"View Details", nil);
    notification.soundName = UILocalNotificationDefaultSoundName;
    notification.regionTriggersOnce = YES;
    
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
}

@end
