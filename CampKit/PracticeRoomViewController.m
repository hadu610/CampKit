//
//  PracticeRoomViewController.m
//  CampKit
//
//  Created by Du Ha on 12/8/13.
//  Copyright (c) 2013 Du Ha. All rights reserved.
//

#import "PracticeRoomViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface PracticeRoomViewController ()
{
    NSMutableArray *selectedKeys;
    NSMutableArray *morseKeys;
    NSMutableArray *semaphoreKeys;

    
    NSDictionary *morseEncodedData;
    NSDictionary *morseDecodedData;
    NSDictionary *semaphoreData;
    
    int questionIndex;
    int numOfTries;
    int score;
    
}

@end

@implementation PracticeRoomViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    morseKeys = [[NSMutableArray alloc]init];
    semaphoreKeys = [[NSMutableArray alloc]init];
    selectedKeys = [[NSMutableArray alloc]init];
    
    questionIndex = 0;
    numOfTries = 0;
    score = 0;
    
    morseEncodedData = [MorseData singleton].encodeData;
    
    NSString* semaphorePlistPath = [[NSBundle mainBundle] pathForResource:@"SemaphoreData" ofType:@"plist"];
    
    semaphoreData = [[NSDictionary alloc] initWithContentsOfFile:semaphorePlistPath];
    morseKeys = [[semaphoreData allKeys] mutableCopy];
    
    morseKeys = [[self shuffleArray:morseKeys] mutableCopy];
    semaphoreKeys = [[self shuffleArray:semaphoreKeys] mutableCopy];
    
    _userFeedbackLabel.hidden = YES;
    _nextButton.hidden = YES;
    [self showQuestion];
}

- (void)showQuestion
{
    int correctAnswerIndex = arc4random()%3 +1;
    UIButton *CorrectAnswerButton=(UIButton *)[self.view viewWithTag:correctAnswerIndex];
    if ([[morseKeys objectAtIndex:questionIndex] isEqualToString:@" "]) {
        [CorrectAnswerButton setTitle:@"Space" forState:UIControlStateNormal];
    }
    else {
        NSString *newStringUI = [self changeMorseUI:[morseKeys objectAtIndex:questionIndex]];
        [CorrectAnswerButton setTitle: newStringUI forState:UIControlStateNormal];
    }
    
    _morseLabel.text = [morseEncodedData objectForKey:[morseKeys objectAtIndex:questionIndex]];
    
    NSMutableArray *chosenKeysArray = [[NSMutableArray alloc]init];
    
    for (int i = 1; i<=4; i++) {
        int wrongAnswerIndex = arc4random()%(int)([morseKeys count]-1) +1;
        BOOL duplicate = NO;
        while (wrongAnswerIndex == questionIndex && !duplicate) {
            wrongAnswerIndex = arc4random()%(int)([morseKeys count]-1) +1;
            
        }
        if (i!=CorrectAnswerButton.tag) {
            UIButton *wrongAnswerButton=(UIButton *)[self.view viewWithTag:i];
            
            if ([[morseKeys objectAtIndex:wrongAnswerIndex] isEqualToString:@" "]) {
                [wrongAnswerButton setTitle:@"Space" forState:UIControlStateNormal];
            }
            else{
                NSString *key =[morseKeys objectAtIndex:wrongAnswerIndex];
                NSString *newStringUI = [self changeMorseUI:key];

                
                //avoid duplicate the keys that are already chosen in the 4 choices
                BOOL keySelected = NO;
                for (NSString *str in selectedKeys) {
                    if ([key isEqualToString:str]) {
                        keySelected = YES;
                        i--;
                        break;
                    }
                }
                if (!keySelected) {
                    
                    [wrongAnswerButton setTitle: newStringUI forState:UIControlStateNormal];
                    [selectedKeys addObject:key];
                    [chosenKeysArray addObject:wrongAnswerButton];
                }
            }
        }
    }
    questionIndex++;
    [selectedKeys removeAllObjects];
}

- (void)checkAnswer:(UIButton*)button
{
    _userFeedbackLabel.hidden = NO;
    
    NSString *morseString = _morseLabel.text;
    NSString *searchKey = button.titleLabel.text;
    
    if ([searchKey isEqualToString:@"Space"]) {
        searchKey = @" ";
        morseString = @"/";
    }
    
    if ([[morseDecodedData objectForKey:searchKey] isEqualToString:morseString]) {
        _userFeedbackLabel.text = @"Correct!";
        _nextButton.hidden = NO;
        score = score + (3-numOfTries);
        numOfTries = 0;
        _scoreLabel.text = [NSString stringWithFormat:@"Score: %d", score];
        [self buttonInteractionEnabled:NO];
    }
    else
    {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        
        button.userInteractionEnabled = NO;
        switch (++numOfTries) {
            case 1:
                _userFeedbackLabel.text = @"Try again!";
                break;
                
            case 2:
                _userFeedbackLabel.text = @"Come on!";
                break;
            case 3:
                _userFeedbackLabel.text = @"Really?";
                break;
                
            default:
                break;
        }
    }
}


- (NSMutableArray*)shuffleArray: (NSMutableArray*)array
{
    int count = (int)[array count];
    for (int i = 0; i < count; ++i) {
        // Select a random element between i and end of array to swap with.
        int nElements = count - i;
        int n = arc4random_uniform(nElements) + i;
        [array exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
    
    return array;
}

- (IBAction)answerButton1Click:(id)sender
{
    if (_nextButton.hidden) {
        [self checkAnswer:(UIButton*)sender];
    }
}

- (IBAction)answerButton2Click:(id)sender
{
    if (_nextButton.hidden) {
        [self checkAnswer:(UIButton*)sender];
    }
}

- (IBAction)answerButton3Click:(id)sender
{
    if (_nextButton.hidden) {
        [self checkAnswer:(UIButton*)sender];
    }
}

- (IBAction)answerButton4Click:(id)sender
{
    if (_nextButton.hidden) {
        [self checkAnswer:(UIButton*)sender];
    }
}
- (IBAction)goToNextQuestion:(id)sender {
    _userFeedbackLabel.hidden = YES;
    _nextButton.hidden = YES;
    
    [self showQuestion];
    [self buttonInteractionEnabled:YES];
}

- (void) buttonInteractionEnabled: (BOOL)isEnabled
{
    _answerButton1.userInteractionEnabled = isEnabled;
    _answerButton2.userInteractionEnabled = isEnabled;
    _answerButton3.userInteractionEnabled = isEnabled;
    _answerButton4.userInteractionEnabled = isEnabled;
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


@end
