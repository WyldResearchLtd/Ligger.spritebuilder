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
        if ( ((NSString*)[_settings objectForKey:@"UserIdentifier"]).length==0 ||
             ((NSString*)[_settings objectForKey:@"DeviceIdentifier"]).length==0 )
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
        
       //send async
    //[self performSelector:@selector(sendArchivedData) withObject:nil];
        
    }
    return self;
}

-(void) checkForArchivedScores
{
    [self performSelector:@selector(sendArchivedData) withObject:nil];
}


-(void) sendArchivedData
{
    NSString *destPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSArray *files = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:destPath  error:nil];
    for (int i = 0; i < files.count; i++)
    {
        if ([((NSString*)files[i]) hasPrefix:@"ARCHIVE-"])
        {
            NSString* fileSpec = [destPath stringByAppendingPathComponent:files[i]];
            //first upload
            NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:fileSpec];
            NSError* err;
            NSData* aData = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:&err];
            NSString* strJson = [[NSString alloc] initWithData:aData encoding:NSUTF8StringEncoding];
            [self sendArchive:strJson fromPath:fileSpec];
            
        }
    }
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
-(void) gameOver:(ScoreData*) scoreData;
{
    NSMutableDictionary* _settings = [GameData getGameSettings];
    [_settings setObject:self._gameData.Gamelog forKey:@"log"];
    [_settings setObject:[scoreData getScoreObjects] forKey:@"scoreObj"];
    [GameData saveGameSettings:_settings];
    NSLog(@"GameManager::gameOver saved Log to Plist");
    
    NSError* err;
    NSData* aData = [NSJSONSerialization dataWithJSONObject:[GameData getGameSettings] options:NSJSONWritingPrettyPrinted error:&err];
    NSString* strLog = [[NSString alloc] initWithData:aData encoding:NSUTF8StringEncoding];
    //NSString* strLog = [[GameData getGameSettings] description];
    [self sendLog:strLog];
    NSLog(@"GameManager::gameOver sent Plist to Web Service");
    
    
    //NSLog(@"GameManager::gameOver completed");
}


//using NSURLConnection for compatability with iOS6

- (void)sendLog:(NSString*) log
{
    @try {
    NSURL *url = [NSURL URLWithString:@"http://ligger-api.fezzee.net"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    NSData* dataIn = [log dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:dataIn];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         if (connectionError != nil)
         {
             //convert the json 'log' back into a dictionary
             NSError* jsonError;
             NSData *objectData = [log dataUsingEncoding:NSUTF8StringEncoding];
             NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData
                                                                         options:NSJSONReadingMutableContainers
                                                                           error:&jsonError];
             //make an archive copy of the LiggerGamedata.plist
             //NSLog(@"Log upload error: %@", jsonError);
             //do something with jsonError?
             [self._gameData  logGameError:[connectionError description] atSecs:((LevelTimer*)self._timer).seconds];
             //NSMutableDictionary* _settings = [GameData getGameSettings];
             [json setObject:self._gameData.Gamelog forKey:@"log"];
             [GameData archiveGameSettings:json];
         }
//         else
//         {
//             //finally remove the scoreObject from LiggerGamedata.plist
//             //this is how we know if we should retry sending- if the scoreObj is missing, we dont try
//             NSMutableDictionary* _settings = [GameData getGameSettings];
//             [_settings setObject:nil forKey:@"scoreObj"];
//             [GameData saveGameSettings:_settings];
//         }

     }];
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        NSLog(@"%@", [NSThread callStackSymbols]);
        [self._gameData  logGameError:[NSString stringWithFormat:@"EXCEPTION: %@ STACKTRACE: %@", e, [NSThread callStackSymbols]] atSecs:((LevelTimer*)self._timer).seconds];
        
        //convert the json 'log' back into a dictionary
        NSError* jsonError;
        NSData *objectData = [log dataUsingEncoding:NSUTF8StringEncoding];
        NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData
                                                                    options:NSJSONReadingMutableContainers
                                                                      error:&jsonError];
        //make an archive copy of the LiggerGamedata.plist
        [json setObject:self._gameData.Gamelog forKey:@"log"];
        [GameData archiveGameSettings:json];
    }
    @finally {
        //
    }
}


- (void)sendArchive:(NSString*) log fromPath:(NSString*)fileSpec
{
    @try {
        NSURL *url = [NSURL URLWithString:@"http://ligger-api.fezzee.net"];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"POST"];
        NSData* dataIn = [log dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:dataIn];
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (connectionError == nil)
             {
                 //if sent ok, delete the archive
                 NSFileManager *fileManager = [NSFileManager defaultManager];
                 NSError *error = nil;
                 [fileManager removeItemAtPath:fileSpec error:&error];
                 if (error)
                     NSLog(@"GameManager::sendArchive File Delete Error : %@", error);
             }
             //if there was an error, don't delete the Archive
             
         }];
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        NSLog(@"%@", [NSThread callStackSymbols]);
        [self._gameData  logGameError:[NSString stringWithFormat:@"EXCEPTION: %@ STACKTRACE: %@", e, [NSThread callStackSymbols]] atSecs:((LevelTimer*)self._timer).seconds];
        
        //convert the json 'log' back into a dictionary
        NSError* jsonError;
        NSData *objectData = [log dataUsingEncoding:NSUTF8StringEncoding];
        NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData
                                                                    options:NSJSONReadingMutableContainers
                                                                      error:&jsonError];
        //make an archive copy of the LiggerGamedata.plist
        [json setObject:self._gameData.Gamelog forKey:@"log"];
        [GameData archiveGameSettings:json];
    }
    @finally {
        //
    }
}


@end
