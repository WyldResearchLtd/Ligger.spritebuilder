//
//  LevelTimer.h
//
//
//  Created by Gene Myers
//  Copyright (c) 2015 Fezzee Ltd. All rights reserved.
//

#import "GameScene.h"

@interface LevelTimer : CCNode
{

    int _timeWidth;
    int _seconds;
    float _timeDecrement;
    
    //CCSprite * _timeLabel;
    CCSprite * _timeBar;
    
    NSTimer * _timer;
    CGRect _textureRectangleFull;
    CGRect _textureRectangle;

}

@property int seconds;
@property (nonatomic) GameScene* game;

-(id) initWithGame:(GameScene *)gameScene x:(float)posx y:(float)posy;
-(void) pauseTimer;
-(void) startTimer;
-(void) tickTock;
-(bool) timerPaused;

@end
