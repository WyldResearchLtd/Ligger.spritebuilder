//
//  LeaderboardLayer.h
//  Ligger
//
//  Created by Gene Myers on 01/07/2015.
//  Copyright (c) 2015 Fezzee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LeaderboardLayer : CCNode


@property (nonatomic) CCLabelTTF * _row1name;
@property (nonatomic) CCLabelTTF * _row2name;
@property (nonatomic) CCLabelTTF * _row3name;
@property (nonatomic) CCLabelTTF * _row4name;
@property (nonatomic) CCLabelTTF * _row5name;
@property (nonatomic) CCLabelTTF * _row6name;

@property (nonatomic) CCLabelTTF * _row1score;
@property (nonatomic) CCLabelTTF * _row2score;
@property (nonatomic) CCLabelTTF * _row3score;
@property (nonatomic) CCLabelTTF * _row4score;
@property (nonatomic) CCLabelTTF * _row5score;
@property (nonatomic) CCLabelTTF * _row6score;

@property (nonatomic) CCLabelTTF * _row1levels;
@property (nonatomic) CCLabelTTF * _row2levels;
@property (nonatomic) CCLabelTTF * _row3levels;
@property (nonatomic) CCLabelTTF * _row4levels;
@property (nonatomic) CCLabelTTF * _row5levels;
@property (nonatomic) CCLabelTTF * _row6levels;

@property (nonatomic) CCLabelTTF * _row1date;
@property (nonatomic) CCLabelTTF * _row2date;
@property (nonatomic) CCLabelTTF * _row3date;
@property (nonatomic) CCLabelTTF * _row4date;
@property (nonatomic) CCLabelTTF * _row5date;
@property (nonatomic) CCLabelTTF * _row6date;

//@property (nonatomic) NSArray * _ScoresDatum;
@property (nonatomic) NSDictionary* bestPersonal;

@property (nonatomic) CCLabelTTF * _lblStatus;

//-(id) initWithPersonalBest:(NSDictionary*) best;
-(id) setPersonalBest:(NSDictionary*) best;
-(void) refreshBoard;

@end
