//
//  CampKitViewController.m
//  CampKit
//
//  Created by Du Ha on 11/28/13.
//  Copyright (c) 2013 Du Ha. All rights reserved.
//

#import "CampKitViewController.h"
#import "MorseEncoderViewControler.h"
#import "UIImage+ImageEffects.h"


@interface CampKitViewController ()<UIAlertViewDelegate>

@end

@implementation CampKitViewController

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _backgroundImageView.image = [_backgroundImageView.image applyLightEffect];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    //testing
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)openTNTTWebsiteOnSafari:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Open in Safari" message:@"View TNTT website in Safari" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
    [alert show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.tntt.org/mm5/merchant.mvc?Screen=TLHL&Store_Code=TNTT"]];
    }
}

@end
