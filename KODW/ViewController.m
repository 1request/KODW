//
//  ViewController.m
//  KODW
//
//  Created by Harry Ng on 23/5/14.
//  Copyright (c) 2014 Request. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://explore.proto.io/share/?id=5efce23d-ad4c-4d1b-b835-55dcd66041a8&v=4"]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
