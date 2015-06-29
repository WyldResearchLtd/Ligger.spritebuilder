#import "MainScene.h"
#import "GameScene.h"
#import "PopupLayer.h"

@implementation MainScene
{
    __weak PopupLayer* _popoverMenuLayer;
    bool isFirstPass;
    //CCScene *scene;
    GameScene *scene;
}

-(void) didLoadFromCCB
{
    // play background sound
    if ([GameData audible])
    {
        // access audio object- play music while loading sprites below
        OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
        [audio playBg:@"hustle.caf" loop:YES];
    }
    NSLog(@"MainScene created");
    
    isFirstPass = [self isFirstPass];
    
    //preload it
    scene = (GameScene*)[CCBReader loadAsScene:@"GameScene"];
    GameScene.halt = false;
    
}


/*
 * we copy the plist to the Documents directory on first pass
 * so we use this as our check. The doc isn't copied until the 
 * Setup is saved for the first time
 */
-(bool) isFirstPass
{
    NSString *destPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    destPath = [destPath stringByAppendingPathComponent:@"LiggerGamedata.plist"];
    
    // If the file doesn't exist in the Documents Folder, copy it.
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:destPath]) {
        return true;
    }
    return false;
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

/*
 *  Play!
 */
-(void) startButtonPressed
{
    
    NSLog(@"startbuttonPressed");
    
    //MUST refresh this
    scene = (GameScene*)[CCBReader loadAsScene:@"GameScene"];


    CCTransition* transition = [CCTransition transitionFadeWithDuration:1.5];
    [[CCDirector sharedDirector] presentScene:(CCScene*)scene withTransition:transition];

    // access audio object
    OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
    // play background sound only if audio was already playing (from options)
    NSLog(@"Audible??: %@",[GameData audible]?@"YES":@"NO");
    if ([GameData audible])
    {
        NSLog(@"Audible=True- Play new Bg tune");
        [audio playBg:@"hustle2.caf" loop:YES];
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
            [_popoverMenuLayer initNavigation:Swipe];
            [_popoverMenuLayer initAudible:true];

        }
        else
        {
            //get saved values!
            [_popoverMenuLayer initAudible:[GameData audible]];
            [_popoverMenuLayer initCharacter:[GameData ligger]];
            [_popoverMenuLayer initNavigation:[GameData navigation]];
        }
        
    }
}

-(void) startCredits
{
    if (_popoverMenuLayer == nil)
    {
        [self showPopoverNamed:@"Popups/Credits"];
        NSLog(@"+++++++Show Credits++++++: ");
        
    }
}

-(void) startAbout
{
    if (_popoverMenuLayer == nil)
    {
        [self showPopoverNamed:@"Popups/Instructions"];
        NSLog(@"+++++++Show Instructions++++++: ");
        
    }
}

-(void) startLeaderboard
{
    if (_popoverMenuLayer == nil)
    {
        [self showPopoverNamed:@"Popups/Leaderboard"];
        NSLog(@"+++++++Show LEADERBOARD++++++: ");
        
    }
}

@end
