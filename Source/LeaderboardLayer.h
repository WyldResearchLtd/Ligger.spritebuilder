//
//  LeaderboardLayer.h
//  Ligger
//
//  Created by Gene Myers on 01/07/2015.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LeaderboardLayer : CCNode
{
    
//    int _row1score;
//    int _row2score;
//    int _row3score;
//    int _row4score;
//    int _row5score;
//    int _row6score;
//    
//    int _row1levels;
//    int _row2levels;
//    int _row3levels;
//    int _row4levels;
//    int _row5levels;
//    int _row6levels;
    
}

//@property (nonatomic) NSString * _row1name;
//@property (nonatomic) NSString * _row2name;
//@property (nonatomic) NSString * _row3name;
//@property (nonatomic) NSString * _row4name;
//@property (nonatomic) NSString * _row5name;
//@property (nonatomic) NSString * _row6name;
//
//@property (nonatomic) NSNumber * _row1score;
//@property (nonatomic) NSNumber * _row2score;
//@property (nonatomic) NSNumber * _row3score;
//@property (nonatomic) NSNumber * _row4score;
//@property (nonatomic) NSNumber * _row5score;
//@property (nonatomic) NSNumber * _row6score;
//
//@property (nonatomic) NSNumber * _row1levels;
//@property (nonatomic) NSNumber * _row2levels;
//@property (nonatomic) NSNumber * _row3levels;
//@property (nonatomic) NSNumber * _row4levels;
//@property (nonatomic) NSNumber * _row5levels;
//@property (nonatomic) NSNumber * _row6levels;
//
//@property (nonatomic) NSString * _row1date;
//@property (nonatomic) NSString * _row2date;
//@property (nonatomic) NSString * _row3date;
//@property (nonatomic) NSString * _row4date;
//@property (nonatomic) NSString * _row5date;
//@property (nonatomic) NSString * _row6date;

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

@property (nonatomic) NSArray * _ScoresDatum;
@property (nonatomic) NSDictionary* bestPersonal;

//-(id) initWithPersonalBest:(NSDictionary*) best;
-(id) setPersonalBest:(NSDictionary*) best;
-(void) refreshBoard;

@end
