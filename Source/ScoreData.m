//
//  ScoreData.m
//  Ligger
//
//  Created by Gene Myers on 01/07/2015.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "ScoreData.h"

/*
 * These scores can be your scores from a Game (GameData/Best Personal Score) or other people scores from the leader board
 */
@implementation ScoreData



-(id) initWithScore:(int)score MaxLevel:(int)level Name:(NSString*)name Date:(NSString*)date GUID:(NSString*)guid
{
    if (self = [super init]) {
        //
        _scoreValue = [NSNumber numberWithInt:score];
        _scoreLevel = [NSNumber numberWithInt:level];
        _scoreName = name;
        _scoreDate = date;
        _GUID = guid;
    }
    return self;
}

@end
