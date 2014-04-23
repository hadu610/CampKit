//
//  MorseEncoderViewControler.h
//  CampKit
//
//  Created by Du Ha on 11/28/13.
//  Copyright (c) 2013 Du Ha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MorseEncoderViewControler : UIViewController

@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (weak, nonatomic) IBOutlet UITextView *encodeText;

@property (weak, nonatomic) IBOutlet UILabel *decodedLabel;
- (IBAction)saveToClipboard:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *saveToClipboardButton;
@property (weak, nonatomic) IBOutlet UILabel *instructionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *inPutImageView;
@property (weak, nonatomic) IBOutlet UIImageView *testImageView;
- (IBAction)sendSMS:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *SMSButton;
@property (weak, nonatomic) IBOutlet UIButton *clearAllTextButton;
- (IBAction)clearAllText:(id)sender;
@end
