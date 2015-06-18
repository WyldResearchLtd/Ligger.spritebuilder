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

-(void) moveForward:(CGPoint) position atSecs:(int) secs; //
-(void) moveBack:(CGPoint) position atSecs:(int) secs; //
-(void) moveBack2:(CGPoint) position atSecs:(int) secs; //
-(void) reachBartender:(int) secs;
-(void) finishOneBeer:(int) secs;
-(void) finishTwoBeers:(int) secs;
-(void) calcBonus:(int)secsRemaining forPromotor:(int)index;
-(void) MushroomMan:(CGPoint) position atSecs:(int) secs;
-(void) goodTrip:(CGPoint) position atSecs:(int) secs;
-(void) badTrip:(CGPoint) position atSecs:(int) secs;

-(void) reset;
-(void) printLog;

@end
