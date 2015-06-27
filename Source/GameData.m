//
//  GameData.m
//  Ligger
//
//  Created by Gene Myers on 15/06/2015.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "GameData.h"

@implementation GameData

static Ligger ligger = GeordieGunter;//default
//a static implemntation of Halt
+ (Ligger) ligger { return ligger; }
+ (void) setLigger:(Ligger)value
{
    if(value==SparklePony)
        NSLog(@"SparklePony Choosen");
    else
        NSLog(@"GeordieGunter Choosen");
    ligger = value;
}


static Navigation navigation = Swipe;//default
+ (Navigation) navigation { return navigation; }
+ (void) setNavigation:(Navigation)value
{
    if(value==Touch)
        NSLog(@"Touch Choosen");
    else
        NSLog(@"Swipe Choosen");
    navigation = value;
}

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

// All of thee method also update the HUD

-(void) moveForward:(CGPoint)position atSecs:(int)secs hud:(CCLabelBMFont*)label
{
    _GameScore += 10;
    [self addToGameLog:@"moveForward" atSecs:secs forPosition:position];
    [label setString:[NSString stringWithFormat:@"%d", _GameScore]];
    
}
-(void) moveBack:(CGPoint) position atSecs:(int)secs hud:(CCLabelBMFont*)label
{
    _GameScore += 10;
    [self addToGameLog:@"moveBack" atSecs:secs forPosition:position];
    [label setString:[NSString stringWithFormat:@"%d", _GameScore]];
}
-(void) moveBack2:(CGPoint) position atSecs:(int)secs hud:(CCLabelBMFont*)label
{
    _GameScore += 20;
    [self addToGameLog:@"moveBack2" atSecs:secs forPosition:position];
    [label setString:[NSString stringWithFormat:@"%d", _GameScore]];
}
-(void) reachBartender:(int)secs hud:(CCLabelBMFont*)label
{
    _GameScore += 100;
    [self addToGameLog:@"reachBartender" atSecs:secs forPosition:CGPointMake(0,0)];
    [label setString:[NSString stringWithFormat:@"%d", _GameScore]];
}
-(void) finishOneBeer:(int)secs hud:(CCLabelBMFont*)label
{
    _GameScore += 500;
    [self addToGameLog:@"finishOneBeer" atSecs:secs forPosition:CGPointMake(0,0)];
    [label setString:[NSString stringWithFormat:@"%d", _GameScore]];
}
-(void) finishTwoBeers:(int)secs hud:(CCLabelBMFont*)label
{
    _GameScore += 1000;
    [self addToGameLog:@"finishTwoBeers" atSecs:secs forPosition:CGPointMake(0,0)];
    [label setString:[NSString stringWithFormat:@"%d", _GameScore]];
}
-(void) calcBonus:(int)secsRemaining forPromotor:(int)index hud:(CCLabelBMFont*)label
{
     _GameScore += (10*secsRemaining*index);
    //don't log the secsRemaing as secs
    NSMutableString *bonusMsg = [NSMutableString string];
    [bonusMsg appendFormat:@"Bonus SecsRemaing: %d Index: %d",secsRemaining, index];
    [self addToGameLog:bonusMsg atSecs:0 forPosition:CGPointMake(0,0)];
    [label setString:[NSString stringWithFormat:@"%d", _GameScore]];
}
-(void) MushroomMan:(CGPoint) position atSecs:(int)secs hud:(CCLabelBMFont*)label
{
    _GameScore += 500;
    [self addToGameLog:@"MushroomMan" atSecs:secs forPosition:position];
    [label setString:[NSString stringWithFormat:@"%d", _GameScore]];

}
-(void) goodTrip:(CGPoint) position  atSecs:(int)secs hud:(CCLabelBMFont*)label
{
     _GameScore += 200;
    [self addToGameLog:@"goodTrip" atSecs:secs forPosition:position];
    [label setString:[NSString stringWithFormat:@"%d", _GameScore]];
}
-(void) badTrip:(CGPoint) position atSecs:(int)secs hud:(CCLabelBMFont*)label
{
     _GameScore -= 400;
    [self addToGameLog:@"badTrip" atSecs:secs forPosition:position];
    [label setString:[NSString stringWithFormat:@"%d", _GameScore]];
}

/////////////////////////////////////////////////////////////////////////////////////////


-(void) addToGameLog:(NSString*)msg atSecs:(int) seconds forPosition:(CGPoint) position
{
    NSMutableString *entry = [NSMutableString string];
    if (seconds!=0)
        [entry appendFormat:@"Seconds: %d",seconds];
    if (position.x !=0 && position.y != 0)
        [entry appendFormat:@" Position: %f.2,%f.2",position.x,position.y];
    [entry appendFormat:@" Msg: %@",msg];
    [_Gamelog addObject:entry];
    NSLog(@"%@",entry);
}

-(void) reset
{
    _GameScore = 0;
    _Gamelog = [[NSMutableArray alloc] init];
    NSMutableString *entry = [NSMutableString string];
    [entry appendFormat:@"GameStarted at: %@",[NSDate date]];
    [self addToGameLog:entry atSecs:0 forPosition:CGPointMake(0,0)];
}

-(void) printLog
{
    for (int i =0; i < self.Gamelog.count; i++)
    {
        NSLog(@">> %@",self.Gamelog[i]);
    }
}

// see http://stackoverflow.com/questions/7628372/ios-how-to-write-a-data-in-plist
-(void) saveGamedata
{
    NSString *destPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    destPath = [destPath stringByAppendingPathComponent:@"ligger.plist"];
    
    // If the file doesn't exist in the Documents Folder, copy it.
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:destPath]) {
        NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"ligger" ofType:@"plist"];
        [fileManager copyItemAtPath:sourcePath toPath:destPath error:nil];
    }
    
    // Load the Property List.
    NSArray *liggerArray = [[NSArray alloc] initWithContentsOfFile:destPath];
    
    //should we check if it is empty, and if empty, set it with defaults?
    
    
    
}


@end
