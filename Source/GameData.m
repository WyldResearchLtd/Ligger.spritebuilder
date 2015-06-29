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
+ (Navigation) navigation {
    [instance sharedInstance];
    return navigation;
}

+ (void) setNavigation:(Navigation)value
{
    if(value==Touch)
        NSLog(@"Touch Choosen");
    else
        NSLog(@"Swipe Choosen");
    navigation = value;
}

static _Bool audible = YES;//default audio is ON
+ (bool) audible {
    
    return audible;
}
+ (void) setAudible:(bool)isOn { audible = isOn; }



+(void) readAndInit
{
     NSLog(@"Read And Init ");
    NSMutableDictionary* settings = [GameData getGameSettings];
   
    audible = [settings objectForKey:@"Audio"]?true:false; //sets the bool correctly
    ligger = [settings objectForKey:@"Character"]?SparklePony:GeordieGunter; //0 = Male,1 = Female
    navigation = [settings objectForKey:@"Movement"]?Swipe:Touch; //0 = ,1 =
    
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

GameData* instance;
-(id)  sharedInstance
{
    if (instance==nil)
    {
        instance = [[GameData alloc]init];
        [GameData readAndInit];
    }
    return instance;
}

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
//should I user NSUserDefaults instead?
+(void) saveGameSettings
{
    //First get the already saved values
    NSMutableDictionary *data = [GameData getGameSettings];
    NSString *destPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    destPath = [destPath stringByAppendingPathComponent:@"LiggerGamedata.plist"];
    
    //TODO: Compare new values to saved and note any differences- Log changes  & Alert user
    
    
    //TODO: Implement unique IDing later
    //[data setObject:@"F6AB677C" forKey:@"UserIdentifier"];
    //[data setObject:@"F656A8BB67997E2C" forKey:@"DeviceIdentifier"];
    //TODO: Populate these correctly
    //[data setObject:[NSNumber numberWithInt:1] forKey:@"Character"];//0 = Male,1 = Female
    [data setObject:[NSNumber numberWithInt:[data objectForKey:@"Character"]] forKey:@"Character"];
    //[data setObject:[NSNumber numberWithInt:0] forKey:@"Movement"]; //0 = Swipe,1=Touch
    [data setObject:[NSNumber numberWithInt:[data objectForKey:@"Movement"]] forKey:@"Movement"];
    //[data setObject:[NSNumber numberWithBool:YES] forKey:@"Audio"];//there is a newer/better way to do this
    [data setObject:[NSNumber numberWithBool:[data objectForKey:@"Audio"]] forKey:@"Audio"];
    //[data setObject:[NSNumber numberWithInt:0] forKey:@"Soundtrack"]; //0 = SoulImmigrants
    
    [data writeToFile:destPath atomically:YES];
    NSLog(@"PList Written at %@",destPath);
    
    //should we check if it is empty, and if empty,
}

// see http://stackoverflow.com/questions/7628372/ios-how-to-write-a-data-in-plist
// should I use NSUserDefaults instead?
+(NSMutableDictionary*) getGameSettings
{
    NSString *destPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    destPath = [destPath stringByAppendingPathComponent:@"LiggerGamedata.plist"];
    
    // If the file doesn't exist in the Documents Folder, copy it.
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSError *error = nil;
    
    if (![fileManager fileExistsAtPath:destPath]) {
        NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"LiggerGamedata" ofType:@"plist"];
        [fileManager copyItemAtPath:sourcePath toPath:destPath error:&error];
        
        if (error!=nil)
        {
            NSLog(@">> SaveGamesettings() ERROR: %@",[error localizedDescription]);
        }
        
    } else {
        NSLog(@"File Exists at path");
    }
    
    // Load the Property List.
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:destPath];
    
    NSLog(@"========= Defaults =================");
    NSLog(@"UserIdentifier: %@",[data objectForKey:@"UserIdentifier"]);
    NSLog(@"DeviceIdentifier: %@",[data objectForKey:@"DeviceIdentifier"]);
    NSLog(@"Character: %@",[data objectForKey:@"Character"]);
    NSLog(@"Movement: %@",[data objectForKey:@"Movement"]);
    NSLog(@"Audio: %@",[data objectForKey:@"Audio"]);
    NSLog(@"Soundtrack: %@",[data objectForKey:@"Soundtrack"]);
    NSLog(@"====================================");
    
    return data;

}


@end
