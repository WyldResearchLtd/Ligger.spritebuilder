//
//  GameData.h
//  Ligger
//
//  Created by Gene Myers on 15/06/2015.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@class ScoreData;
@interface GameData : NSObject

@property int GameScore;
@property (nonatomic) NSMutableArray* Gamelog; //this is the scoring moves
//@property (nonatomic) NSMutableArray* settings; //this are the app settings- see instance variable instead
//static NSMutableDictionary* _settings;

//Game Settings
+ (Ligger) ligger;
+ (void) setLigger:(Ligger)character;
+ (Navigation) navigation;
+ (void) setNavigation:(Navigation)character;
+ (bool) audible;
+ (void) setAudible:(bool)setOn;
+ (NSString*) userName;
+ (void) setUserName:(NSString*)name;
+ (NSNumber*) soundtrack;
+ (void) setSoundtrack:(NSNumber*)value;

//+(void) saveGameSettings;
+(void) saveGameSettings:(NSMutableDictionary*)gameData;
+(NSMutableDictionary*) getGameSettings;
+(void) readAndInit;
+(NSMutableDictionary*) getPersonalBest;

-(bool) updateHighScore:(ScoreData*)scoreData;


//log player actions
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

//TODO: Add Non-Scoring milestones- Collision1, Collision2, Levelup, Game Over to GameData

-(void) reset;
-(void) printLog;

@end

/*
 
 Pass obstacle (forward only or back with 1 Beer): 10 points.
 
 Pass obstacle (forward only or back with 2 Beer): 20 points.
 
 Getting to Bartender: 100 points. (either for 2 or 1 beer)
 
 Returning with Two Beers: 1,000 points.
 
 Returning with One Beer: 500 points.
 
 Bonus score: 10 points x each second remaining on timer x Promotor Index (eg-1=Michael, 4=Rob).
 
 Mushroom Man: 500 points bonus.
 
 Good Trip: 200 points.
 
 Bad Trip: -400 points.
 
 */
