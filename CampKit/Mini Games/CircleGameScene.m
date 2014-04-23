//
//  CircleGameScene.m
//  Orbivoid
//
//  Created by Du Ha on 11/8/13.
//  Copyright (c) 2013 Neto. All rights reserved.
//

#import "CircleGameScene.h"
#import "ORBGameScene.h"
#import "ORBMenuScene.h"

@interface CircleGameScene() <SKPhysicsContactDelegate> {
    SKSpriteNode *circleSprite;
    float cirleDiameter;
    int numCircle;
    int targetNumber;
    NSMutableArray *circles;
    NSMutableArray *labels;
    NSMutableArray *numListArray;
    CFTimeInterval startTime;
    bool UIEnabled;
    
}
@end


@implementation CircleGameScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        UIEnabled = YES;
        [self createSceneContents];
        numCircle = 30;
        targetNumber = 1;
        circles = [[NSMutableArray alloc]init];
        labels = [[NSMutableArray alloc]init];
        numListArray = [[NSMutableArray alloc]init];

        for (int i = 1; i<=numCircle; i++) {
            cirleDiameter = self.frame.size.width/10; //iPad mini scale
//            cirleDiameter = self.frame.size.width/8;
            
            SKTexture *texture = [SKTexture textureWithImageNamed:@"circle2.png"];
            SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithTexture:texture];
            sprite.name = [NSString stringWithFormat:@"%d", i];
            
            float x = arc4random()%(int)(self.frame.size.width-cirleDiameter)+cirleDiameter;
            float y = arc4random()%(int)(self.frame.size.height-cirleDiameter)+cirleDiameter;
            
            sprite.position = CGPointMake(x,y);
            sprite.size = CGSizeMake(cirleDiameter, cirleDiameter);
            sprite.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:sprite.frame.size.width*.5];
            
            sprite.physicsBody.dynamic = YES;
            
            sprite.physicsBody.restitution = .5;
            sprite.physicsBody.mass = .2;
            sprite.physicsBody.friction = 0;
//            sprite.physicsBody.allowsRotation = NO;
            
            [circles addObject:sprite];
            [self addChild: [circles objectAtIndex:i-1]];
            
            
            SKLabelNode *numberLabel = [SKLabelNode labelNodeWithFontNamed:@"Baskerville"];
            numberLabel.name = [NSString stringWithFormat:@"%d", i];
            numberLabel.text = [NSString stringWithFormat:@"%d", i];
            numberLabel.fontSize = 40; //iPad mini scale
//            numberLabel.fontSize = 20;

            numberLabel.position = CGPointMake(x, y-10);//iPad mini scale
//            numberLabel.position = CGPointMake(sprite.position.x, sprite.position.y-10);

            numberLabel.fontColor = [SKColor redColor];
            
            numberLabel.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:numberLabel.frame.size.height];
            
            numberLabel.physicsBody.dynamic = YES;
            
            numberLabel.physicsBody.restitution = .5;
            numberLabel.physicsBody.mass = .2;
            numberLabel.physicsBody.friction = 0;
            numberLabel.physicsBody.allowsRotation = NO;
            
            [labels addObject:numberLabel];
            [self addChild: [labels objectAtIndex:i-1]];
            
            CGPoint anchor = CGPointMake(0.5, 0.5);
            SKPhysicsJointFixed* fixedJoint = [SKPhysicsJointFixed jointWithBodyA:sprite.physicsBody
                                                                            bodyB:numberLabel.physicsBody
                                                                           anchor:anchor];
            [self.scene.physicsWorld addJoint:fixedJoint];
                        
            float Fx = [self getRandomNumberBetweenMin:-10000 andMax:10000];
            float Fy = [self getRandomNumberBetweenMin:-10000 andMax:10000];
            
            [sprite.physicsBody applyForce:CGVectorMake(Fx,Fy)];
        }
         startTime = CACurrentMediaTime();
    }
    return self;
}

- (int) getRandomNumberBetweenMin:(int)min andMax:(int)max
{
	return ( (arc4random() % (max-min+1)) + min );
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (targetNumber<=numCircle) {
        UITouch *touch = [[event allTouches] anyObject];
        CGPoint touchLocation = [touch locationInNode:self];
        
        SKSpriteNode *currentNode = ((SKSpriteNode*)[circles objectAtIndex:targetNumber-1]);
        SKLabelNode *currentNodeLabel = ((SKLabelNode*)[labels objectAtIndex:targetNumber-1]);
        
        if ([[self nodeAtPoint:touchLocation].name isEqualToString:currentNode.name] ||

            [[self nodeAtPoint:touchLocation].name isEqualToString:currentNodeLabel.name]) {
            [self runAction:[SKAction playSoundFileNamed:@"Spawn.m4a" waitForCompletion:NO]];
            
            [currentNode runAction:[SKAction sequence:@[
                                                        [SKAction scaleBy:1.5 duration:.05],
                                                        [SKAction fadeOutWithDuration:.05],
                                                        ]]];
            
            [currentNodeLabel runAction:[SKAction sequence:@[
                                                             [SKAction scaleBy:1.5 duration:.05],
                                                             [SKAction fadeOutWithDuration:.05],
                                                             ]]];
            
            
            targetNumber++;
        }
    }
    
    
    if (targetNumber>numCircle && UIEnabled) {
        UIEnabled = NO;
        CFTimeInterval elapsedTime = CACurrentMediaTime() - startTime;

        SKLabelNode *title = [SKLabelNode labelNodeWithFontNamed:@"Avenir-Black"];
        
        title.text = [NSString stringWithFormat:@"%d Seconds", (int)elapsedTime];
        title.fontSize = 70;
        title.position = CGPointMake(CGRectGetMidX(self.frame),
                                     CGRectGetMidY(self.frame));
        title.fontColor = [SKColor whiteColor];
        
        [self addChild:title];
        
        [self runAction:[SKAction sequence:@[
                                             [SKAction waitForDuration:3],
                                             [SKAction runBlock:^{
                                                                    ORBMenuScene *menu = [[ORBMenuScene alloc] initWithSize:self.size];
                                                                    [self.view presentScene:menu transition:[SKTransition doorsCloseHorizontalWithDuration:0.5]];}],
                                             ]]];
    }
}

-(void)update:(CFTimeInterval)currentTime {

}

- (void) createSceneContents {
    self.backgroundColor = [SKColor blackColor];
    
    self.scaleMode = SKSceneScaleModeAspectFit;
    
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    self.physicsWorld.gravity = CGVectorMake(0, 0);
}

@end
