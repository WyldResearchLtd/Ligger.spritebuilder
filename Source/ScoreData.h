//
//  ScoreData.h
//  Ligger
//
//  Created by Gene Myers on 01/07/2015.
//  Copyright (c) 2015 Fezzee. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GameData;
@interface ScoreData : NSObject
{
    //int scoreValue;
    //int scoreLevel;
}

@property (nonatomic) NSString* UserGUID;
@property (nonatomic) NSString* DeviceGUID;
@property (nonatomic) NSString* scoreName;
@property (nonatomic) NSNumber* timeRemaining;
@property (nonatomic) NSString* scoreDate;   //DateTime
@property (nonatomic) NSNumber* scoreValue;  //THE score
@property (nonatomic) NSNumber* scoreLevel; //max level
@property (nonatomic) bool isHighScore; //flag this if this score is added to the Best- keywords
@property (nonatomic) bool isGameOver; //flag this if the game is over

-(id) initWithScore:(int)score MaxLevel:(NSNumber*)level Name:(NSString*)name Date:(NSString*)date GUID:(NSString*)guid Device:(NSString*)device Remaing:(int)time;
-(NSDictionary*) getScoreObjects;//:(GameData*)data;


@end
