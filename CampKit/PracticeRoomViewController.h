//
//  PracticeRoomViewController.h
//  CampKit
//
//  Created by Du Ha on 12/8/13.
//  Copyright (c) 2013 Du Ha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PracticeRoomViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *semaphoreImageView;

@property (weak, nonatomic) IBOutlet UILabel *morseLabel;


@property (weak, nonatomic) IBOutlet UIButton *answerButton1;

@property (weak, nonatomic) IBOutlet UIButton *answerButton2;

@property (weak, nonatomic) IBOutlet UIButton *answerButton3;

@property (weak, nonatomic) IBOutlet UIButton *answerButton4;

- (IBAction)answerButton1Click:(id)sender;

- (IBAction)answerButton2Click:(id)sender;

- (IBAction)answerButton3Click:(id)sender;

- (IBAction)answerButton4Click:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *userFeedbackLabel;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

- (IBAction)goToNextQuestion:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@end
