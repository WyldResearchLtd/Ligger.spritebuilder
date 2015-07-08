//
//  GameManager.m
//  Ligger
//
//  Created by Gene Myers on 01/07/2015.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "GameManager.h"
//#import "GameData.h"

@implementation GameManager


//-(id) initWithGamedata:(GameData*)gameData
//{
//    if (self = [super init])
//    {
//        //this is doing the first pass intialisation- getting a unique userID and a a deviceID
//        NSLog(@"GameManager initialised");
//        self._gameData = gameData;
//        double timestamp = [[NSDate date] timeIntervalSince1970];
//        NSString* hexID = [[NSString stringWithFormat:@"%02x", (unsigned int) timestamp] uppercaseString];
//
//        int rndValue = 1 + arc4random() % (65536 - 1);
//         NSString* hexRandom = [[NSString stringWithFormat:@"%04x", (unsigned int) rndValue] uppercaseString];
//        NSLog(@"Unique ID: %@-%@", hexID,hexRandom);
//        
//        NSUUID* uuid = [[UIDevice currentDevice] identifierForVendor];
//        NSLog(@"DeviceID: %@", [uuid UUIDString]);
//        
//        //NOW LETS WRITE THE UNIQUE ID's to the File (Or use thos if they are already there)
//        
//
//    }
//    return self;
//}

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
        
        //NOW LETS WRITE THE UNIQUE ID's to the File (Or use thos if they are already there)
        
        
    }
    return self;
}


/*
 * This is the workhorse of this class. It writes the GameData, tallies it, displays it on the personal best board, and then sends it to the web service
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
