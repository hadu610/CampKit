//
//  CampBooksViewController.m
//  CampKit
//
//  Created by Du Ha on 12/4/13.
//  Copyright (c) 2013 Du Ha. All rights reserved.
//

#import "CampBooksViewController.h"

@interface CampBooksViewController ()

@end

@implementation CampBooksViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (BOOL)prefersStatusBarHidden {
    return YES;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"book" ofType:@"pdf" inDirectory:@""];
//    NSURL *url = [NSURL fileURLWithPath:path];
//    NSURL *url = [NSURL URLWithString:@"http://www.tntt.org/mm5/merchant.mvc?Screen=TLHL&Store_Code=TNTT"];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    [_BooksWebView loadRequest:request];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.tntt.org/mm5/merchant.mvc?Screen=TLHL&Store_Code=TNTT"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
