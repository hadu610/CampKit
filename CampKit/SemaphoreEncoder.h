//
//  SemaphoreEncoder.h
//  CampKit
//
//  Created by Du Ha on 11/30/13.
//  Copyright (c) 2013 Du Ha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SemaphoreEncoder : UIViewController
- (IBAction)hideCaption:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *hideCaptionButton;
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (weak, nonatomic) IBOutlet UIImageView *photoHolder;

@property (weak, nonatomic) IBOutlet UITextView *characterInput;

@property (weak, nonatomic) IBOutlet UILabel *semaphoreLetterLabel;
@end
