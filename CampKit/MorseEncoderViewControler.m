//
//  MorseCode.m
//  CampKit
//
//  Created by Du Ha on 11/28/13.
//  Copyright (c) 2013 Du Ha. All rights reserved.
//

#import "MorseEncoderViewControler.h"
#import "UIImage+ImageEffects.h"
#import <MessageUI/MessageUI.h>

@interface MorseEncoderViewControler() <UITextViewDelegate, MFMessageComposeViewControllerDelegate, UIAlertViewDelegate>
{
    NSDictionary *morseEncodedData;
    MFMessageComposeViewController *SMSViewController;
}

@end

@implementation MorseEncoderViewControler

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [_navigationBar setBackgroundImage:[UIImage new]
                             forBarMetrics:UIBarMetricsDefault];
    _navigationBar.shadowImage = [UIImage new];
    _navigationBar.translucent = YES;
//    UIImage *backgroundImage = [UIImage imageNamed:@"background2.jpg"];
    
//    _testImageView.image = [backgroundImage applyLightEffect];
    _encodeText.delegate = self;
    _decodedLabel.numberOfLines = 0;
    [_encodeText becomeFirstResponder];
    [_saveToClipboardButton setTitle:@"Copy" forState:UIControlStateNormal];
    _SMSButton.hidden = YES;
    _saveToClipboardButton.hidden = YES;
    _clearAllTextButton.hidden = YES;
    
    _decodedLabel.numberOfLines = 0;
    NSString* morsePlistPath = [[NSBundle mainBundle] pathForResource:@"MorseEncodedData" ofType:@"plist"];
    morseEncodedData = [[NSDictionary alloc] initWithContentsOfFile:morsePlistPath];
    
    [self encode: _encodeText];
    
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (_encodeText.text.length) {
        [_saveToClipboardButton setTitle:@"Copy" forState:UIControlStateNormal];
        [_saveToClipboardButton setUserInteractionEnabled:YES];
        [_saveToClipboardButton setSelected:NO];
        _saveToClipboardButton.hidden = NO;
        _instructionLabel.hidden = YES;
        _SMSButton.hidden = NO;
        _clearAllTextButton.hidden = NO;
    }
    else if (_encodeText.text.length == 0){
        _clearAllTextButton.hidden = YES;
        _saveToClipboardButton.hidden = YES;
        _SMSButton.hidden = YES;
        _instructionLabel.hidden = NO;
    }
    
    [self encode: textView];
}


- (void)encode: (UITextView *)textView
{
    _decodedLabel.text = @"decodeLabel";
    NSString *encodedString = @"";
    for (int i=0; i<textView.textStorage.length; i++) {
        NSString *letter = [[textView.text substringWithRange:NSMakeRange(i, 1)] uppercaseString];
        
        if ([morseEncodedData objectForKey:letter]) {
            if ([letter isEqualToString:@" "]) {
                encodedString = [encodedString stringByAppendingString:(NSString*)[morseEncodedData objectForKey:letter]];
            }
            else {
                 encodedString = [[encodedString stringByAppendingString:(NSString*)[morseEncodedData objectForKey:letter]] stringByAppendingString:@"   "];//3 spaces
            }
        }
        else {
            encodedString = [encodedString stringByAppendingString:letter];

        }
    }
    
    NSString *newEncodedString = @"";
    
    for (int i = 0; i<encodedString.length; i++) {
        newEncodedString = [newEncodedString stringByAppendingString:[self changeMorseUI:[encodedString substringWithRange:NSMakeRange(i, 1)]]];

    }
    _decodedLabel.text = newEncodedString;
}

- (IBAction)saveToClipboard:(id)sender
{
    [_saveToClipboardButton setTitle:@"Copied" forState:UIControlStateNormal];
    [_saveToClipboardButton setUserInteractionEnabled:NO];
    [_saveToClipboardButton setSelected:YES];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = _decodedLabel.text;
}

- (IBAction)sendSMS:(id)sender
{
    
    Class messageClass = (NSClassFromString(@"MFMessageComposeViewController"));
    if([messageClass canSendText]){
        SMSViewController = [[MFMessageComposeViewController alloc] init];
        SMSViewController.messageComposeDelegate = self;
        SMSViewController.body = _decodedLabel.text;
        
        [self presentViewController:SMSViewController animated:YES completion:^{
        }];    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No SMS Option" message:@"SMS is currently not available in this device" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
        [alert show];
    }
 
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissViewControllerAnimated:YES completion:^{
        [_encodeText becomeFirstResponder];
    }];
}

-(NSString*)changeMorseUI:(NSString*)string
{
    NSString *newString = @"";
    for (int i = 0; i<string.length; i++) {
        if ([[string substringWithRange:NSMakeRange(i, 1)] isEqualToString:@"."]) {
            newString = [newString stringByAppendingString:@"•"];
        }
        else if ([[string substringWithRange:NSMakeRange(i, 1)] isEqualToString:@"-"]) {
            newString = [newString stringByAppendingString:@"—"];
        }
        else
            newString = [newString stringByAppendingString:[string substringWithRange:NSMakeRange(i, 1)]];
    }
    return newString;
}


- (IBAction)clearAllText:(id)sender
{
    
    _instructionLabel.hidden = NO;
    _saveToClipboardButton.hidden = YES;
    _SMSButton.hidden = YES;
    _encodeText.text = @"";
    _decodedLabel.text = @"";
    _clearAllTextButton.hidden = YES;
}
@end
