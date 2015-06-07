//
//  GameScene.h
//  Ligger
//
//  Created by Gene Myers on 19/04/2015.
//  Copyright (c) 2015 Fezzee Limited. All rights reserved.
//

#import "CCNode.h"
#import "Constants.h"
#import "CCActionInterval.h"
//#import "UITouch+CC.h"
#import "CCDirector.h"
#import "Constants.h"

@interface GameScene : CCNode

@property (nonatomic) NSMutableArray* obstacles;
@property (nonatomic) NSMutableArray* promotors;
@property (nonatomic) CCNode *obstacle1;
@property (nonatomic) CCNode *obstacle2;
@property (nonatomic) CCNode *obstacle3;
@property (nonatomic) CCNode *obstacle4;
@property (nonatomic) CCNode *obstacle5;
@property (nonatomic) CCNode *obstacle6;
@property (nonatomic) CCNode *obstacle7;
@property (nonatomic) CCNode *obstacle8;
@property (nonatomic) CCNode *obstacle9;
@property (nonatomic) CCNode *obstacle10;
@property (nonatomic) CCNode *bartender1;
@property (nonatomic) CCNode *promotor1;
@property (nonatomic) CCNode *promotor2;
@property (nonatomic) CCNode *promotor3;
@property (nonatomic) CCNode *promotor4;

@property (nonatomic) PlayerState playerState;
@property (nonatomic) LevelState levelState;

+ (Boolean) halt;
+ (void) setHalt:(Boolean)value;


-(Boolean) doesCollide:(CCNode*)obstacle withPlayer:(CCNode*) player;
-(Boolean) isServing:(int)idxBartender withPlayer:(CCNode*) player;

- (void)startHustleLeft;
- (void)startHustleRight;
- (void)startHustleUp;
- (void)startHustleDown;


@end
