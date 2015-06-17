#import "MainScene.h"
#import "GameScene.h"

@implementation MainScene

-(void) didLoadFromCCB
{
    // access audio object
    OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
    // play background sound
    [audio playBg:@"hustle.m4a" loop:YES];
    NSLog(@"MainScene created");
}

-(void) startButtonPressed
{

    NSLog(@"startbuttonPressed");

    
    CCScene* scene = [CCBReader loadAsScene:@"GameScene"];
    GameScene.halt = false;
    CCTransition* transition = [CCTransition transitionFadeWithDuration:1.5];
    [[CCDirector sharedDirector] presentScene:scene withTransition:transition];
    
    // access audio object
    OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
    // play background sound
    [audio playBg:@"hustle2.m4a" loop:YES];

    
}

@end
