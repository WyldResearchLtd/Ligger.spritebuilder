//
//  GameScene.h
//  Ligger
//
//  Created by Gene Myers on 19/04/2015.
//  Copyright (c) 2015 Fezzee Limited. All rights reserved.
//

//#import "CCNode.h"
#import "Constants.h"
#import "CCActionInterval.h"
//#import "UITouch+CC.h"
#import "CCDirector.h"
#import "Constants.h"
#import "GameData.h"


@interface GameScene : CCNode

@property (nonatomic) NSMutableArray* obstacles;
@property (nonatomic) NSMutableArray* promotors;
@property (nonatomic) CCNode *bartender1;
@property (nonatomic) CCNode *bkstage_f;
@property (nonatomic) CCNode *bkstage_b;

@property bool swiped;

@property (nonatomic) id timer;
@property (nonatomic) PlayerState playerState;
@property (nonatomic) LevelState levelState;
@property (nonatomic) PlayerMoveState playerMoveState;
@property (nonatomic) GameData* gameData;
@property int moveLength;
@property int screenWidth;
@property int screenHeight;

@property (nonatomic) CCLabelBMFont *_lblHUDscore;

+ (Boolean) halt;
+ (void) setHalt:(Boolean)value;


-(Boolean) doesCollide:(CCNode*)obstacle withPlayer:(CCNode*) player;
-(Boolean) isServing:(int)idxBartender withPlayer:(CCNode*) player;

- (void)startHustleLeft;
- (void)startHustleRight;
- (void)startHustleUp;
- (void)startHustleDown;
- (CCNode*) getScreen;
- (void) gameOver;
- (void) backToMenu;

- (void) showPopoverNamed:(NSString*)popoverName;
- (void) removePopover;

@end
