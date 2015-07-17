/*
 *  GameManager.m
 *  Ligger
 *

 *  The GameManager contains ScoreData and GameData
 *  The GameManager encapsulates the LevelTimer
 *
 *  GameManager's lifecycle mimics the lifecycle of the game
 *      1) On the first game, a userID and DeviceID are recorded
 *      2) On Incrementing the level, the gamespeed is also adjusted
 *      3) On completion, writes the game/score/gamelog data to the webservice
 *
 *  Created by Gene Myers on 01/07/2015.
 *  Copyright (c) 2015 Fezzee Ltd All rights reserved.
 *
 */

#import "GameManager.h"
//#import "GameData.h"

@implementation GameManager


/*
 * Requires a LevelTimer object
 * Sets initial gamespeed
 * Logs UserID and DeviceID if missing
 *
 *
 */
-(id) initWithTimer:(LevelTimer*)timer
{
    if (self = [super init])
    {
        //keeping  reference
        self._timer = timer;
        
        self.gameSpeed = 1.5f;//this is the start speed

        //very importanly, the GameManager creats the GameData
        NSLog(@"GameManager initialised");
        self._gameData = [[GameData alloc]init];
        
        //We look at the plist, and if the UserID is blank, this is a first pass
        //[self._gameData.]
        //get settings
        //read UserIdenifier and DeviceIdentifier
        //if empty, then firstpass, do write
        //else return
        NSMutableDictionary* _settings = [GameData getGameSettings];
        if ( ((NSString*)[_settings objectForKey:@"UserIdentifier"]).length>0 ||
             ((NSString*)[_settings objectForKey:@"DeviceIdentifier"]).length>0 )
        {
            //this is doing the first pass intialisation- getting a unique userID and a a deviceID
            double timestamp = [[NSDate date] timeIntervalSince1970];
            NSString* hexID = [[NSString stringWithFormat:@"%02x", (unsigned int) timestamp] uppercaseString];
            
            int rndValue = 1 + arc4random() % (65536 - 1);
            NSString* hexRandom = [[NSString stringWithFormat:@"%04x", (unsigned int) rndValue] uppercaseString];
            NSString * userID = [NSString stringWithFormat:@"%@-%@", hexID,hexRandom];
            [_settings setObject:userID  forKey:@"UserIdentifier"];
            NSLog(@"User ID: %@", userID);
            
            NSUUID* uuid = [[UIDevice currentDevice] identifierForVendor];
            [_settings setObject:[uuid UUIDString]  forKey:@"DeviceIdentifier"];
            NSLog(@"DeviceID: %@", [uuid UUIDString]);
            
            [GameData saveGameSettings:_settings];
                 
        }
    }
    return self;
}


// like i++;
//Increments the Level and the game speed accordingly
-(void) incrementLevelCount
{
    self.level = [NSNumber numberWithInt:[self.level intValue] + 1];
    
    //5 diff speeds- 5 levels
    //moves the game speed between 1.5 and 2.7 in .2 increments
    if (self.gameSpeed < 2.4)
    {
        self.gameSpeed += 0.3f;
        NSLog(@"Game Speed set to: %.2f", self.gameSpeed);
    }
    
    
}


/*
 * Sends GameData to the web service
 */
-(void) gameOver
{
    NSMutableDictionary* _settings = [GameData getGameSettings];
    [_settings setObject:self._gameData.Gamelog forKey:@"log"];
    [GameData saveGameSettings:_settings];
    NSLog(@"GameManager::gameOver saved Log to Plist");
    
    NSLog(@"GameManager::gameOver completed");
}


//it should take your score totals/ and add them to the gamedata, along with your Settings and Scoring gamedata, and upload to the webservice



@end
