//
//  AppDelegate.h
//  KODW
//
//  Created by Harry Ng on 23/5/14.
//  Copyright (c) 2014 Request. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Beacon.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, BeaconNotificationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) Beacon *beacon;

@end
