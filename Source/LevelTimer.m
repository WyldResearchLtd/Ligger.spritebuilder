//
//  LevelTimer.m
//  FroggerSparrow
//
//  Created by Rogerio Engelbert on 12/15/11.
//  Copyright (c) 2011 rengelbert.com. All rights reserved.
//

#import "LevelTimer.h"
#import "GameScene.h"
//#import "GameScreen.h"
//#import "GameData.h"

@implementation LevelTimer

@synthesize seconds = _seconds;

-(id) initWithGame:(GameScene *)game x:(float)posx y:(float)posy {
    
    //self = [super initWithGame:game x:posx y:posy];
    NSLog(@"LEVEL TIMER");
    
    if (self != nil) {
        
        _timeWidth = 180;
        _seconds = 0;
        
        
        ////_timeLabel = [_game.imageCache getSkin:@"label_time.png"];
        //_timeLabel.position = CGPointMake(posx, posy);
        
        
        _timeBar = [CCSprite spriteWithImageNamed:@"Published-iOS/Sprites/resources-phone/timerbar.png"];
        //_timeBar = [_game.imageCache getSkin:@"time_bar.png"];
        [_timeBar setAnchorPoint:ccp(0,0)];
        _timeBar.position = CGPointMake(posx + game.screenWidth * 0.08, posy - _timeBar.textureRect.size.height * 0.5);
     
        //[[game getScreen] addSubview:(UIView*)_timeLabel];
        [[game getScreen] addChild:(CCNode*)_timeBar];
        // [[_game getScreen] addSprite:_timeBar];
        
        _textureRectangleFull = _textureRectangle = _timeBar.textureRect;
        _timeDecrement = _timeBar.textureRect.size.width * 0.004;
        
    }

    return self;
}


-(void) tickTock {
    NSLog(@"TICK TOCK!");
    //return;
    if (true) { //_game.gameData.gameMode == GAME_STATE_PLAY) {
        NSLog(@"TICK TOCK-a");
        _seconds++;
        //reduce time bar width
        if (_textureRectangle.size.width - _timeDecrement <= 0) {
            NSLog(@"TICK TOCK-b");
            //[(GameScreen *) [_game getScreen] gameOver];
            _timeBar.visible = NO;
            [_timer invalidate];
        } else {
            NSLog(@"TICK TOCK-c");
            _textureRectangle.size.width -= _timeDecrement;
            [_timeBar setTextureRect:_textureRectangle];
        }
    }
}

-(void) pauseTimer {
   [_timer invalidate]; 
}

-(void) startTimer {
    if (![_timer isValid]) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tickTock) userInfo:nil repeats:YES];
    }
}

-(void) reset {
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