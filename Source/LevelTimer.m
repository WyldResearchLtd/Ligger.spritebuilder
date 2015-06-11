//
//  LevelTimer.m
//  
//
//  Created by Gene Myers
//  Copyright (c) 2015 Fezzee Ltd. All rights reserved.
//

#import "LevelTimer.h"
//#import "GameScene.h"


@implementation LevelTimer

@synthesize seconds = _seconds;

-(id) initWithGame:(GameScene *)gameScene x:(float)posx y:(float)posy {
    
    self = [super init]; //initWithGame:game x:posx y:posy];
    NSLog(@"LEVEL TIMER INITIALISED");
    
    if (self != nil) {
        
        _timeWidth = 180;//180=250
        _seconds = 0;
        
        _game = gameScene;
        ////_timeLabel = [_game.imageCache getSkin:@"label_time.png"];
        //_timeLabel.position = CGPointMake(posx, posy);
        
        
        _timeBar = [CCSprite spriteWithImageNamed:@"Published-iOS/Sprites/resources-phone/timerbar.png"];
        NSAssert(_timeBar!=nil, @"timebar.png is Nil");
        //_timeBar = [_game.imageCache getSkin:@"time_bar.png"];
        [_timeBar setAnchorPoint:ccp(0,0)];
        _timeBar.position = CGPointMake(posx + _game.screenWidth * 0.08, posy - _timeBar.textureRect.size.height * 0.5);
     
        //[[game getScreen] addSubview:(UIView*)_timeLabel];
        [[_game getScreen] addChild:(CCNode*)_timeBar];
        // [[_game getScreen] addSprite:_timeBar];
        
        _textureRectangleFull = _textureRectangle = _timeBar.textureRect;
        _timeDecrement = _timeBar.textureRect.size.width * 0.017;  //0.004=250 0.04=25 0.08=12.5  0.016=63  0.015=67
        
    }

    return self;
}


-(void) tickTock {

    //return;
    if (_game.levelState == PlayGame) {
        _seconds++;
        //reduce time bar width
        if (_textureRectangle.size.width - _timeDecrement <= 0) {
            NSLog(@"Timer-Complete");
            [_game gameOver];
            _timeBar.visible = NO;
            [_timer invalidate];
        } else {
            NSLog(@"Timer-Interval");
            _textureRectangle.size.width -= _timeDecrement;
            [_timeBar setTextureRect:_textureRectangle];
        }
    }
}

-(void) pauseTimer {
   NSLog(@"Timer paused");
   [_timer invalidate]; 
}

-(void) startTimer {
    if (![_timer isValid]) {
        NSLog(@"Timer started");
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tickTock) userInfo:nil repeats:YES];
    }
}

-(void) reset {
    NSLog(@"Timer reset");
    _seconds = 0;
    _textureRectangle = _textureRectangleFull;
    [_timeBar setTextureRect:_textureRectangle];
    _timeBar.visible = YES;
}

-(void) dealloc {
    
    if ([_timer isValid]) {
       [_timer invalidate];
    }
    _timer = nil;
    
    //[super dealloc];
}


@end
