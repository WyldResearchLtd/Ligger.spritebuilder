#import "MainScene.h"
#import "GameScene.h"
#import "PopupLayer.h"

@implementation MainScene
{
    __weak PopupLayer* _popoverMenuLayer;
    bool isFirstPass;
    CCScene* scene;
}

-(void) didLoadFromCCB
{
    // access audio object
    OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
    // play background sound
    [audio playBg:@"hustle.caf" loop:YES];
    NSLog(@"MainScene created");
    isFirstPass = true;
    //preload it
    scene = [CCBReader loadAsScene:@"GameScene"];
    GameScene.halt = false;
}

-(void) startButtonPressed
{

    NSLog(@"startbuttonPressed");
    
    //we play the preloaded scene
    CCTransition* transition = [CCTransition transitionFadeWithDuration:1.5];
    [[CCDirector sharedDirector] presentScene:scene withTransition:transition];
    
    // access audio object
    OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
    // play background sound
    [audio playBg:@"hustle2.caf" loop:YES];

    
}

-(void) showPopoverNamed:(NSString*)name
{
    if (_popoverMenuLayer == nil)
    {
        PopupLayer* newMenuLayer = (PopupLayer*)[CCBReader load:name];
        NSAssert(newMenuLayer!=nil, @"PopupLayer in showPopoverNamed is Nil");
        [self addChild:newMenuLayer];
        _popoverMenuLayer = newMenuLayer;
        _popoverMenuLayer.parent = self;
        //GameScene.halt=true;
        //_levelNode.paused = YES;
    }
}

-(void) removePopover
{
    if (_popoverMenuLayer)
    {
        NSLog(@"Popup removed");
        _popoverMenuLayer.visible = YES;
        [_popoverMenuLayer removeFromParent];
        _popoverMenuLayer = nil;
        //_levelNode.paused = NO;
        //GameScene.halt = false;
        NSLog(@"Completed Popup removal");
    }
    else
    {
        NSLog(@"Unable to remove Popup");
    }
}



-(void) startOptions
{
    if (_popoverMenuLayer == nil)
    {
        [self showPopoverNamed:@"Popups/OptionsPopup"];
        NSLog(@"+++++++Options++++++: ");
        
        if (isFirstPass)
        {
            isFirstPass = false;
            [_popoverMenuLayer initCharacter:GeordieGunter];
        }
        else
        {
            //get saved value!
        }
        
    }
}

@end
