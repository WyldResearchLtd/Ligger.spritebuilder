//
//  GameData.h
//  Ligger
//
//  Created by Gene Myers on 15/06/2015.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@interface GameData : NSObject

@property int GameScore;
@property (nonatomic) NSMutableArray* Gamelog;

+ (Ligger) ligger;
+ (void) setLigger:(Ligger)character;
+ (Navigation) navigation;
+ (void) setNavigation:(Navigation)character;

-(void) moveForward:(CGPoint) position atSecs:(int) secs hud:(CCLabelBMFont*)label; //
-(void) moveBack:(CGPoint) position atSecs:(int)secs hud:(CCLabelBMFont*)label; //
-(void) moveBack2:(CGPoint) position atSecs:(int)secs hud:(CCLabelBMFont*)label; //
-(void) reachBartender:(int)secs hud:(CCLabelBMFont*)label;
-(void) finishOneBeer:(int)secs hud:(CCLabelBMFont*)label;
-(void) finishTwoBeers:(int)secs hud:(CCLabelBMFont*)label;
-(void) calcBonus:(int)secsRemaining forPromotor:(int)index hud:(CCLabelBMFont*)label;
-(void) MushroomMan:(CGPoint) position atSecs:(int)secs hud:(CCLabelBMFont*)label;
-(void) goodTrip:(CGPoint) position atSecs:(int)secs hud:(CCLabelBMFont*)label;
-(void) badTrip:(CGPoint) position atSecs:(int)secs hud:(CCLabelBMFont*)label;

-(void) reset;
-(void) printLog;

@end
