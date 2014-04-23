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
        [self createSceneContents];
        [self addChild:[self createDodgeItButton]];
        [self addChild:[self createFindingNumbersButton]];
    }
    return self;
}


- (SKSpriteNode *)createDodgeItButton
{
    SKSpriteNode *fireNode = [SKSpriteNode spriteNodeWithImageNamed:@"DodgeItButton.png"];
    fireNode.position = CGPointMake(self.frame.size.width*.5,self.frame.size.height*.6);
    fireNode.name = @"dodgeItButton";
    fireNode.zPosition = 1.0;
    fireNode.xScale = .5;
    fireNode.yScale = .5;
    return fireNode;
}

- (SKSpriteNode *)createFindingNumbersButton
{
    
    SKSpriteNode *fireNode = [SKSpriteNode spriteNodeWithImageNamed:@"FindingNumbersButton.png"];
    fireNode.position = CGPointMake(self.frame.size.width*.5,self.frame.size.height*.45);
    fireNode.name = @"findingNumbersButton";
    fireNode.zPosition = 1.0;
    fireNode.xScale = .5;
    fireNode.yScale = .5;
    return fireNode;
}


- (void) createSceneContents {
    float screenWidth = self.frame.size.width;
    float screenHeight = self.frame.size.height;
    
    //adding the background
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"HomeScreenBackground.png"];
    
    background.xScale = screenWidth/background.frame.size.width;
    background.yScale = screenHeight/background.frame.size.height;
    background.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
    background.zPosition = -1;

    [self addChild:background];
    
    self.scaleMode = SKSceneScaleModeFill;
    
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    self.physicsWorld.gravity = CGVectorMake(0, 0);
}

- (void)goToDodgeItGame {
    ORBGameScene *dodgeItGame = [[ORBGameScene alloc] initWithSize:self.size];
    [self.view presentScene:dodgeItGame transition:[SKTransition doorsOpenHorizontalWithDuration:0.5]];
}

- (void)goToFindingNumbersGame {
    CircleGameScene *findingNumbersGame = [[CircleGameScene alloc] initWithSize:self.size];
    [self.view presentScene:findingNumbersGame transition:[SKTransition doorsOpenHorizontalWithDuration:0.5]];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    if ([node.name isEqualToString:@"dodgeItButton"]) {
        [self goToDodgeItGame];
    }
    else if ([node.name isEqualToString:@"findingNumbersButton"]) {
        [self goToFindingNumbersGame];
    }
    
    

}

@end
