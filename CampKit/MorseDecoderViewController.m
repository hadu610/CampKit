//
//  MorseDecoderViewController.m
//  CampKit
//
//  Created by Du Ha on 11/29/13.
//  Copyright (c) 2013 Du Ha. All rights reserved.
//

#import "MorseDecoderViewController.h"

@interface MorseDecoderViewController ()
{
    NSDictionary *morseDecodedData;
    int doubleTap;
    NSString *morseString;
    NSString *englishString;

    
}

@end

@implementation MorseDecoderViewController

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
    
    [_navigationBar setBackgroundImage:[UIImage new]
                         forBarMetrics:UIBarMetricsDefault];
    _navigationBar.shadowImage = [UIImage new];
    _navigationBar.translucent = YES;
    

    morseDecodedData = [MorseData singleton].decodeData;
    
    _encryptedLabel.numberOfLines = 0;
    _decryptedLabel.numberOfLines = 0;
    _saveToClipboardButton.hidden = YES;
    _clearAllTextButton.hidden = YES;
    
    morseString = @"";
    [self updateEncryptedLabel:morseString];
    englishString = @"";
    [self updateDecryptedLabel:englishString];
    
     doubleTap = 0;//include this line in every button tap method
}

- (IBAction)addASpaceCharacter:(id)sender
{
     doubleTap++;
    if (morseString.length) {
        _saveToClipboardButton.hidden = NO;
        if (doubleTap==1) {
            morseString = [morseString stringByAppendingString:@"  "];
            [self decode];
        }
        else if (doubleTap==2)
            morseString = [morseString stringByReplacingCharactersInRange:NSMakeRange(morseString.length-1, 2) withString:@"/"];
    }
    
    [self updateEncryptedLabel:morseString];
}

- (IBAction)addADotCharacter:(id)sender
{
    _clearAllTextButton.hidden = NO;
    _instructionLabel.hidden = YES;
    doubleTap = 0;//include this line in every button tap method
    morseString = [morseString stringByAppendingString:@"."];
    [self updateEncryptedLabel:morseString];
}

- (IBAction)addADashCharacter:(id)sender
{
    _clearAllTextButton.hidden = NO;
    _instructionLabel.hidden = YES;
    doubleTap = 0;//include this line in every button tap method
    morseString = [morseString stringByAppendingString:@"-"];
    [self updateEncryptedLabel:morseString];
}
- (IBAction)deleteLeftCharacter:(id)sender
{
    doubleTap = 0;//include this line in every button tap method

    if (morseString.length>1) {
        morseString = [morseString substringToIndex:morseString.length-1];
        if ([[morseString substringWithRange:NSMakeRange(morseString.length-1, 1)] isEqualToString:@"/"]) {
            [self decode];
        }
    }
    else
    {
        morseString = @"";
        englishString = @"";
        _saveToClipboardButton.hidden = YES;
        _instructionLabel.hidden = NO;
        _clearAllTextButton.hidden = YES;
    }
    
    [self updateEncryptedLabel:morseString];
    [self updateDecryptedLabel:englishString];
}

- (void)updateEncryptedLabel:(NSString*)string
{
    string = [self changeMorseUI:string];
    _encryptedLabel.text = string;
}

- (void)updateDecryptedLabel:(NSString*)string
{
    string = [self changeMorseUI:string];
    _decryptedLabel.text = string;
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

- (IBAction)saveToClipboard:(id)sender {
    [_saveToClipboardButton setTitle:@"Copied" forState:UIControlStateNormal];
    [_saveToClipboardButton setUserInteractionEnabled:NO];
    [_saveToClipboardButton setSelected:YES];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = englishString;
}

- (void)decode
{
    int startIndex = 0;
    NSString *temp = @"";
    for (int i=0; i<morseString.length; i++) {
        NSString *encryptedLetter = @"";
        if (([[morseString substringWithRange:NSMakeRange(i, 2)] isEqualToString:@"  "] ||
             [[morseString substringWithRange:NSMakeRange(i, 1)] isEqualToString:@"/"]) && i>0) {
            
            encryptedLetter = [morseString substringWithRange:NSMakeRange(startIndex, i-startIndex)];
            
            if ([morseDecodedData objectForKey:encryptedLetter]) {
                temp = [temp stringByAppendingString:[morseDecodedData objectForKey:encryptedLetter]];
                
                if ([[morseString substringWithRange:NSMakeRange(i, 1)] isEqualToString:@"/"]) {
                    temp = [temp stringByAppendingString:@" "];
                }
            }
            else
                temp = [temp stringByAppendingString:encryptedLetter];

            startIndex = ++i;
        }
        
    }
    englishString = [temp lowercaseString];
    [self updateDecryptedLabel:englishString];
}
- (IBAction)clearAllText:(id)sender {
    morseString = @"";
    englishString = @"";
    _saveToClipboardButton.hidden = YES;
    _clearAllTextButton.hidden = YES;
    _instructionLabel.hidden = NO;
    [self updateEncryptedLabel:morseString];
    [self updateDecryptedLabel:englishString];
}
@end
