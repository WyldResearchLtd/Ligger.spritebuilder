//
//  ScoreData.m
//  Ligger
//
//  Created by Gene Myers on 01/07/2015.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "ScoreData.h"
#import "GameData.h"

/*
 * These scores can be your scores from a Game (GameData/Best Personal Score) or other people scores from the leader board
 */
@implementation ScoreData



-(id) initWithScore:(int)score MaxLevel:(int)level Name:(NSString*)name Date:(NSString*)date GUID:(NSString*)guid Device:(NSString*)device Remaing:(NSString*)time
{
    if (self = [super init]) {
        //
        _scoreValue = [NSNumber numberWithInt:score];
        _scoreLevel = [NSNumber numberWithInt:level];
        _scoreName = name;
        _scoreDate = date;
        _UserGUID = guid;
        _DeviceGUID = device;
        _timeRemaining = time;
    }
    return self;
}


-(id) initWithDictionary:(NSDictionary*) dict
{
    if (self = [super init]) {
        //TODO: NOT IMPLIMENTED
        
    }
    return self;
}


//returns this object as a Dictionary of values
-(NSDictionary*) getScoreObjects:(GameData*)data
{
    # warning NEEDS TESTING
    NSArray* objects = [NSArray arrayWithObjects: _scoreValue, _timeRemaining, _scoreLevel, _scoreName, _scoreDate,
     _UserGUID, _DeviceGUID,
     nil];
    
    NSArray* keys = [NSArray arrayWithObjects: @"scoreValue", @"timeRemaining", @"scoreLevel", @"scoreName", @"scoreDate",
                        @"UserGUID", @"DeviceGUID",
                        nil];

    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithObjects:objects forKeys:keys];

     return dict;
}

@end
