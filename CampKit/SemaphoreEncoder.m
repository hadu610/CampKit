//
//  SemaphoreEncoder.m
//  CampKit
//
//  Created by Du Ha on 11/30/13.
//  Copyright (c) 2013 Du Ha. All rights reserved.
//

#import "SemaphoreEncoder.h"

@interface SemaphoreEncoder () <UITextViewDelegate>
{
    NSDictionary *semaphoreData;
}

@end

@implementation SemaphoreEncoder

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
    
    NSString* semaphorePlistPath = [[NSBundle mainBundle] pathForResource:@"SemaphoreData" ofType:@"plist"];
    semaphoreData = [[NSDictionary alloc] initWithContentsOfFile:semaphorePlistPath];
    
    _characterInput.delegate = self;
    [_characterInput becomeFirstResponder];
    _characterInput.autocorrectionType = UITextAutocorrectionTypeNo;
    _characterInput.alpha = 0;
    
    NSArray *allKeys =  [semaphoreData allKeys];
    NSString *randomLetter = [allKeys objectAtIndex:arc4random()%[allKeys count]];
    _semaphoreLetterLabel.text = randomLetter;
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self showPhotoForALetter:randomLetter];

    });
}


- (void)textViewDidChange:(UITextView *)textView
{
    [self showPhotoForALetter: textView.text];
}

- (void)showPhotoForALetter: (NSString*)letter
{
    letter = [letter uppercaseString];
    
    if ([semaphoreData objectForKey:letter]) {
        UIImage *semaImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [semaphoreData objectForKey:letter]]];
        // BUGS: Space.png shows in simulator but not in actual device
        
        _photoHolder.image = semaImage;
        _photoHolder.contentMode = UIViewContentModeScaleAspectFit;
    }
    else {
        _photoHolder.image = [UIImage imageNamed:@"Face.png"];
        letter = @"";
    }


    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         _photoHolder.alpha = 0;}
                     completion:^(BOOL finished){if (finished){
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             _photoHolder.alpha = .5;
                         
                         
                         }
                         completion:NULL];}}];
    
    
    if ([letter isEqualToString:@" "])
        _semaphoreLetterLabel.text = @"Space";
    else
        _semaphoreLetterLabel.text = letter;
    
    _characterInput.text = @"";
}

- (void)animateView:(UIImageView*)imageView
{
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         imageView.alpha = 0;}
                     completion:^(BOOL finished){if (finished){
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             imageView.alpha = .5;}
                         completion:NULL];}}];
}

- (IBAction)hideCaption:(id)sender {
    if ([_hideCaptionButton.title isEqualToString:@"Hide Letter"]) {
        _hideCaptionButton.title = @"Show Letter";
        _semaphoreLetterLabel.hidden = YES;
    }
        else
        {
            _hideCaptionButton.title = @"Hide Letter";
            _semaphoreLetterLabel.hidden = NO;
        }

}
@end
