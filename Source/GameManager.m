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


-(id) initWithGamedata:(GameData*)gameData
{
    if (self = [super init])
    {
        //this is doing the first pass intialisation- getting a unique userID and a a deviceID
        NSLog(@"GameManager initialised");
        self._gameData = gameData;
        double timestamp = [[NSDate date] timeIntervalSince1970];
        NSString* hexID = [[NSString stringWithFormat:@"%02x", (unsigned int) timestamp] uppercaseString];

        int rndValue = 1 + arc4random() % (65536 - 1);
         NSString* hexRandom = [[NSString stringWithFormat:@"%04x", (unsigned int) rndValue] uppercaseString];
        NSLog(@"Unique ID: %@-%@", hexID,hexRandom);
        
        NSUUID* uuid = [[UIDevice currentDevice] identifierForVendor];
        NSLog(@"DeviceID: %@", [uuid UUIDString]);
    }
    return self;
}



@end
