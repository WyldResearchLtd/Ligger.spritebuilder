//
//  LevelTimer.h
//  FroggerSparrow
//
//  Created by Rogerio Engelbert on 12/15/11.
//  Copyright (c) 2011 rengelbert.com. All rights reserved.
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
    

@end
