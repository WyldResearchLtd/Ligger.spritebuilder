//
//  GameManager.m
//  Ligger
//
//  Created by Gene Myers on 01/07/2015.
//  Copyright (c) 2015 Fezzee. All rights reserved.
//

#import "GameManager.h"
//#import "GameData.h"

@implementation GameManager



-(id) initWithTimer:(LevelTimer*)timer
{
    if (self = [super init])
    {
        //for now, just keeping  reference
        self._timer = timer;
        
        //this is doing the first pass intialisation- getting a unique userID and a a deviceID
        NSLog(@"GameManager initialised");
        self._gameData = [[GameData alloc]init];
        double timestamp = [[NSDate date] timeIntervalSince1970];
        NSString* hexID = [[NSString stringWithFormat:@"%02x", (unsigned int) timestamp] uppercaseString];
        
        int rndValue = 1 + arc4random() % (65536 - 1);
        NSString* hexRandom = [[NSString stringWithFormat:@"%04x", (unsigned int) rndValue] uppercaseString];
        NSLog(@"Unique ID: %@-%@", hexID,hexRandom);
        
        NSUUID* uuid = [[UIDevice currentDevice] identifierForVendor];
        NSLog(@"DeviceID: %@", [uuid UUIDString]);
        
        self.gameSpeed = 1.5f;//this is the start speed
        
        //NOW LETS WRITE THE UNIQUE ID's to the File (Or use thos if they are already there)
        
        
    }
    return self;
}


// like i++;
//Increments the Level and the game speed accordingly
-(void) incrementLevelCount
{
    __level = [NSNumber numberWithInt:[__level intValue] + 1];
    
    //5 diff speeds- 5 levels
    //moves the game speed between 1.5 and 2.7 in .2 increments
    if (self.gameSpeed < 2.4)
    {
        self.gameSpeed += 0.3f;
        NSLog(@"Game Speed set to: %.2f", self.gameSpeed);
    }
    //lets set the speed?
    
}


/*
 * Sends GameData to the web service
 */
-(void) gameOver
{
    //self._gameData.GameScore
    //Create ScoreData!!
    
    //read GameSettings for past best
    //update Best-1,2,3 (Keys in gameSettings) if necessary
    
    //ADD These to create JSON for webservice
    //self._gameData.Gamelog
    //NSMutableDictionary* _gameSettings = [GameData getGameSettings];
    
    NSLog(@"GameManager::gameOver called");
    
}


//it should take your score totals/ and add them to the gamedata, along with your Settings and Scoring gamedata, and upload to the webservice



@end
