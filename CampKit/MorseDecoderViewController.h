//
//  MorseDecoderViewController.h
//  CampKit
//
//  Created by Du Ha on 11/29/13.
//  Copyright (c) 2013 Du Ha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MorseDecoderViewController : UIViewController
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;

- (IBAction)addASpaceCharacter:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *spaceButton;

- (IBAction)addADotCharacter:(id)sender;
- (IBAction)addADashCharacter:(id)sender;

- (IBAction)saveToClipboard:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *saveToClipboardButton;

- (IBAction)deleteLeftCharacter:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *deleteLeftCharacterButton;

- (IBAction)clearAllText:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *clearAllTextButton;

@property (weak, nonatomic) IBOutlet UILabel *encryptedLabel;
@property (weak, nonatomic) IBOutlet UILabel *decryptedLabel;
@property (weak, nonatomic) IBOutlet UILabel *instructionLabel;

@end
