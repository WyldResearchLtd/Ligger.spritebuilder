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
#import "GameManager.h"

@class GameManager;
@interface GameScene : CCNode

@property (nonatomic) NSMutableArray* obstacles;
@property (nonatomic) NSMutableArray* promotors;
@property (nonatomic) CCNode *bartender1;
@property (nonatomic) CCNode *bkstage_f;
@property (nonatomic) CCNode *bkstage_b;
@property (nonatomic) CCSprite *_hudLigger1;
@property (nonatomic) CCSprite *_hudLigger2;

@property bool swiped;

@property (nonatomic) id timer;
@property (nonatomic) GameData* gameData;
//gameManager is a provate instance variable- see .m file

@property (nonatomic) PlayerState playerState;
@property (nonatomic) LevelState levelState;
@property (nonatomic) PlayerMoveState playerMoveState;

@property int moveLength;
@property int screenWidth;
@property int screenHeight;
//HUD Stuff
@property (nonatomic) CCLabelBMFont *_lblHUDscore;
@property (nonatomic) CCSprite * _beerOne;
@property (nonatomic) CCSprite * _beerTwo;
@property (nonatomic) CCSprite * _hudLigger;
@property (nonatomic) CCNode * _nodeHUD;
@property (nonatomic) CCButton * arrowUp;
@property (nonatomic) CCButton * arrowDown;
@property (nonatomic) CCButton * arrowLeft;
@property (nonatomic) CCButton * arrowRight;

//- (void) refreshUI;
+ (Boolean) halt;
+ (void) setHalt:(Boolean)value;

-(Boolean) doesCollide:(CCNode*)obstacle withPlayer:(CCNode*) player;
-(Boolean) isServing:(int)idxBartender withPlayer:(CCNode*) player;
-(void) loadLevel;

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
