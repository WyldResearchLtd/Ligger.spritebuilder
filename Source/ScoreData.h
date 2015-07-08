//
//  ScoreData.h
//  Ligger
//
//  Created by Gene Myers on 01/07/2015.
//  Copyright (c) 2015 Fezzee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScoreData : NSObject
{
    //int scoreValue;
    //int scoreLevel;
}

@property (nonatomic) NSString* UserGUID;
@property (nonatomic) NSString* DeviceGUID;
@property (nonatomic) NSString* scoreName;
@property (nonatomic) NSString* timeRemaining;
@property (nonatomic) NSString* scoreDate;
@property (nonatomic) NSNumber* scoreValue;
@property (nonatomic) NSNumber* scoreLevel;
@property (nonatomic)bool isHighScore; //flag this if this score is added to the Best- keywords

-(id) initWithScore:(int)score MaxLevel:(int)level Name:(NSString*)name Date:(NSString*)date GUID:(NSString*)guid Device:(NSString*)device Remaing:(NSString*)time;

@end
