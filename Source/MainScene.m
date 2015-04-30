#import "MainScene.h"
#import "GameScene.h"

@implementation MainScene

-(void) didLoadFromCCB
{
    NSLog(@"MainScene created");
}

-(void) startButtonPressed
{
    NSLog(@"startbuttonPressed");
    
    
    
    CCScene* scene = [CCBReader loadAsScene:@"GameScene"];
    GameScene.halt = false;
    CCTransition* transition = [CCTransition transitionFadeWithDuration:1.5];
    [[CCDirector sharedDirector] presentScene:scene withTransition:transition];
}

@end
