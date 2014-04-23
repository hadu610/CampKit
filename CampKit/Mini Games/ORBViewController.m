//
//  ORBViewController.m
//  Orbivoid
//
//  Created by Joachim Bengtsson on 2013-08-27.
//  Copyright (c) 2013 Neto. All rights reserved.
//

#import "ORBViewController.h"
#import "ORBGameScene.h"
#import "ORBMenuScene.h"

@implementation ORBViewController

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
    
    // Configure the view.
    SKView * skView = (SKView *)self.view;
//    skView.showsFPS = YES;
//    skView.showsNodeCount = YES;
    
    // Create and configure the scene.
    SKScene * scene = [ORBMenuScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeResizeFill;
    
    
    // Present the scene.
    [skView presentScene:scene];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end
