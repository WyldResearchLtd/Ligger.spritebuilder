#import "MainScene.h"
#import "GameScene.h"


@implementation MainScene
{
    CCButton* _btnPlay;
}

-(void) didLoadFromCCB
{
    // access audio object
    OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
    // play background sound
    [audio playBg:@"hustle.caf" loop:YES];
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
    [audio playBg:@"hustle2.caf" loop:YES];

    
}

@end
