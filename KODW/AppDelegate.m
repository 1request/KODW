//
//  AppDelegate.m
//  KODW
//
//  Created by Harry Ng on 23/5/14.
//  Copyright (c) 2014 Request. All rights reserved.
//

#import "AppDelegate.h"
#define kRequestActivity @"/collectionapi/logs"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    self.beacon = [Beacon new];
    self.beacon.delegate = self;
    if ([self.beacon respondsToSelector:@selector(startMonitorBeacon:major:minor:)]) {
        [self.beacon startMonitorBeacon:kUUID_Estimote major:1000 minor:2000];
    }
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [[NSNotificationCenter defaultCenter] addObserverForName:@"Entry" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        [self NotifyWhenEntry];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:@"Exit" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        [self NotifyWhenExit];
    }];

}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)NotifyWhenEntry{
    
//    NSString *tip = @"Welcome to HKDC! open app.";
//    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"KODW" message:tip delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//    [alert show];
    
}

- (void)NotifyWhenExit{
//    NSString *tip = @"Goodbye, See you next time in HKDC!";
//    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"KODW" message:tip delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//    [alert show];
}

#pragma mark - beacon delegate methods

- (void)NotifyWhenEntryBeacon:(CLBeaconRegion *)beaconRegion{
    
    
    NSString *tip = @"Welcome to HKDC !";
    NSString *message = [NSString stringWithFormat:@"%@ region: %@", tip, beaconRegion.minor];
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"KODW" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [view show];
    
    if ([beaconRegion.minor integerValue] == 2000) {
        
        tip = @"Today's Event : KODW Workshop ";
    }else if ([beaconRegion.minor integerValue] == 2001) {
        
        tip = @"Happy Hour Today ";
    }
    
    
    [self sendLocalNotificationWithMessage:tip];
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Entry" object:nil];
    
    NSLog(@"detect beacon %@", beaconRegion);
    
    NSString *majorMinor = [NSString stringWithFormat:@"%@-%@", [beaconRegion major], [beaconRegion minor]];
    
    [AppDelegate sendData:[beaconRegion proximityUUID] major:[beaconRegion major] minor:[beaconRegion minor]];
}

- (void)NotifyWhenExitBeacon:(CLBeaconRegion *)beaconRegion{
    NSString *tip = @"Goodbye, See you next time!";
    
    if ([beaconRegion.minor integerValue] == 2000) {
        
        tip = @"Today's Event : KODW Conference ";
    }else if ([beaconRegion.minor integerValue] == 2001) {
        
        tip = @"Don't Forget Happy Hour Today :) ";
    }
    
    
    [self sendLocalNotificationWithMessage:tip];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Exit" object:nil];
    
    NSLog(@"detect beacon %@", beaconRegion);
}


#pragma mark - Local notifications
- (void)sendLocalNotificationWithMessage:(NSString*)message
{
    UILocalNotification *notification = [UILocalNotification new];
    
    // Notification details
    notification.alertBody = message;
    // notification.alertBody = [NSString stringWithFormat:@"Entered beacon region for UUID: %@",
    //                         region.proximityUUID.UUIDString];   // Major and minor are not available at the monitoring stage
    notification.alertAction = NSLocalizedString(@"View Details", nil);
    notification.soundName = UILocalNotificationDefaultSoundName;
    notification.regionTriggersOnce = YES;
    
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
}

+ (void)sendData:(NSUUID *)beaconId major:(NSNumber *)kMajor minor:(NSNumber *)kMinor
{
    NSLog(@"sending data...");
    
    NSNumber *time = [NSNumber numberWithLongLong:[[NSDate date] timeIntervalSince1970] * 1000];
    NSString *deviceId = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    
//    NSArray *objects = [NSArray arrayWithObjects:[beaconId UUIDString], [kMajor stringValue], [kMinor stringValue], deviceId, time, @"0", nil];
    NSArray *objects = [NSArray arrayWithObjects:[beaconId UUIDString], @"9", @"26057", @"3516AE72-4277-4783-93E8-CB5830E44ED2", time, nil];
    NSArray *keys = [NSArray arrayWithObjects:@"uuid", @"major", @"minor", @"deviceId", @"time", nil];
    NSDictionary *jsonDict = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    
    NSError *error;
    NSData *requestData = [NSJSONSerialization dataWithJSONObject:jsonDict
                                                          options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                            error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:requestData encoding:NSUTF8StringEncoding];
    
    NSLog(@"jsonRequest is %@", jsonString);
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", @"http://192.168.0.110:4000", kRequestActivity]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];
    
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    if (connection) {
        [connection start];
    }
    
}

@end
