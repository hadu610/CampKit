//
//  ORBMenuScene.m
//  Orbivoid
//
//  Created by Joachim Bengtsson on 2013-09-01.
//  Copyright (c) 2013 Neto. All rights reserved.
//

#import "ORBMenuScene.h"
#import "ORBGameScene.h"
#import "CircleGameScene.h"

@implementation ORBMenuScene
- (instancetype)initWithSize:(CGSize)size
{
    if(self = [super initWithSize:size]) {
//        SKEmitterNode *background = [SKEmitterNode orb_emitterNamed:@"Background"];
//            background.particlePositionRange = CGVectorMake(self.size.width*2, self.size.height*2);
//            [background advanceSimulationTime:10];
//        
//        [self addChild:background];
        
        [self createSceneContents];
        
        SKLabelNode *tapToPlay = [SKLabelNode labelNodeWithFontNamed:@"Avenir-Black"];
        
        tapToPlay.text = @"Slide ->Finding Numbers OR Tap ->Dodge It";
        
        tapToPlay.fontSize = 35;
        tapToPlay.position = CGPointMake(CGRectGetMidX(self.frame),
                                         CGRectGetMidY(self.frame));
        tapToPlay.fontColor = [SKColor colorWithHue:0 saturation:0 brightness:1 alpha:0.7];
        tapToPlay.zPosition = 2;
        
        [self addChild:tapToPlay];
        
//        SKLabelNode *title = [SKLabelNode labelNodeWithFontNamed:@"Avenir-Black"];
//        title.text = @"Dodge It!";
//        title.fontSize = 70;
//        title.position = CGPointMake(CGRectGetMidX(self.frame),
//                                       CGRectGetMidY(self.frame));
//        title.fontColor = [SKColor colorWithHue:0 saturation:0 brightness:1 alpha:1.0];
//        
//        [self addChild:title];
        
        
        
        UIButton *dodgeItButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [dodgeItButton addTarget:self action:@selector(goToDodgeItGame) forControlEvents:UIControlEventTouchUpInside];
        [dodgeItButton setTitle:@"Dodge It" forState:UIControlStateNormal];
        dodgeItButton.frame = CGRectMake(self.frame.origin.x*.5,self.frame.origin.y*.5, 160.0, 40.0);
        [dodgeItButton.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:80.0]];
        dodgeItButton.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:dodgeItButton];

        UIButton *findingNumbersButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [findingNumbersButton addTarget:self action:@selector(goToFindingNumbers) forControlEvents:UIControlEventTouchUpInside];

        [findingNumbersButton setTitle:@"Finding Numbers" forState:UIControlStateNormal];
        findingNumbersButton.frame = CGRectMake(dodgeItButton.frame.origin.x,
                                         dodgeItButton.frame.origin.y+50, 160.0, 40.0);
        
        [findingNumbersButton.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:80.0]];
        [self.view addSubview:findingNumbersButton];
        

    }
    return self;
}


- (void) createSceneContents {
    //adding the background
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"background.JPG"];
    background.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
    background.zPosition = -1;
    [self addChild:background];
    
    self.scaleMode = SKSceneScaleModeAspectFit;
    
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    self.physicsWorld.gravity = CGVectorMake(0, 0);
}

- (void)goToDodgeItGame {
    ORBGameScene *dodgeItGame = [[ORBGameScene alloc] initWithSize:self.size];
    [self.view presentScene:dodgeItGame transition:[SKTransition doorsOpenHorizontalWithDuration:0.5]];
}

- (void)goToFindingNumbers {
    CircleGameScene *findingNumbersGame = [[CircleGameScene alloc] initWithSize:self.size];
    [self.view presentScene:findingNumbersGame transition:[SKTransition doorsOpenHorizontalWithDuration:0.5]];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    ORBGameScene *dodgeItGame = [[ORBGameScene alloc] initWithSize:self.size];
    [self.view presentScene:dodgeItGame transition:[SKTransition doorsOpenHorizontalWithDuration:0.5]];

}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CircleGameScene *findingNumbersGame = [[CircleGameScene alloc] initWithSize:self.size];
    [self.view presentScene:findingNumbersGame transition:[SKTransition doorsOpenHorizontalWithDuration:0.5]];
}
@end
