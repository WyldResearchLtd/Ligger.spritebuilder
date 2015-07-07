#import "MainScene.h"
#import "GameScene.h"
#import "PopupLayer.h"
#import "OptionsLayer.h"
#import "GameData.h"

@implementation MainScene
{
    __weak PopupLayer* _popoverMenuLayer;
    __weak OptionsLayer* _popoverOptionsLayer;
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
        if ([[GameData soundtrack] integerValue]==0)
            [audio playBg:@"hustle.caf" loop:YES];
        else if ([[GameData soundtrack] integerValue]==1)
            [audio playBg:@"dustbowl.m4a" loop:YES];
    }
    NSLog(@"MainScene created");
    
    isFirstPass = [self isFirstPass];
    
    
    //Change to !isFirstPass so firstpass popover always shows
    if (isFirstPass)
    {
        //Popup FirstPass UIs ???
        if (_popoverMenuLayer == nil)
        {
            [self showPopoverNamed:@"Popups/FirstPass"];
            NSLog(@"+++showPopoverNamed:@Popups/FirstPass+++");
        }
    }
    //setup the time formatting for logging
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *todaysDate;
    todaysDate = [NSDate date];
    //log START of preload here with time
    NSLog(@"START of gamescene Preloading: %@",[formatter stringFromDate:todaysDate]);
    //preload GameScene- important to do it here
    scene = (GameScene*)[CCBReader loadAsScene:@"GameScene"];
     NSLog(@"END of gamescene Preloading: %@",[formatter stringFromDate:todaysDate]);
    //log END of preload here with time
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
    
    // If the file doesn't exist in the Documents Folder, its a first pass.
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
        CCNode* newMenuLayer = [CCBReader load:name];
        NSAssert(newMenuLayer!=nil, @"PopupLayer in showPopoverNamed is Nil");
        [self addChild:newMenuLayer];
        //TODO Ugly!!
        if ( ! [name isEqualToString:@"Popups/OptionsPopup"] )
            _popoverMenuLayer = (PopupLayer*)newMenuLayer;
        else
            _popoverOptionsLayer = (OptionsLayer*)newMenuLayer;
        _popoverMenuLayer.parent = self;
        //GameScene.halt=true;
        //_levelNode.paused = YES;
    }
}

//-(void) showPopoverNamed2:(NSString*)name
//{
//    if (_popoverMenuLayer == nil)
//    {
//        PopupLayer* newMenuLayer = (PopupLayer*)[CCBReader load:name];
//        NSAssert(newMenuLayer!=nil, @"PopupLayer in showPopoverNamed is Nil");
//        [self addChild:newMenuLayer];
//        _popoverMenuLayer = newMenuLayer;
//        _popoverMenuLayer.parent = self;
//        //GameScene.halt=true;
//        //_levelNode.paused = YES;
//    }
//}

-(void) removePopover
{
    if (_popoverMenuLayer)
    {
        _popoverMenuLayer.visible = YES;
        [_popoverMenuLayer removeFromParent];
        _popoverMenuLayer = nil;
        //_levelNode.paused = NO;
        //GameScene.halt = false;
        NSLog(@"Completed Popup removal");
    }
    else if (_popoverOptionsLayer)
    {
        _popoverOptionsLayer.visible = YES;
        [_popoverOptionsLayer removeFromParent];
        _popoverOptionsLayer = nil;
        NSLog(@"Completed OptionsPopup removal");
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
        //[audio playBg:@"hustle2.caf" loop:YES];
        [audio playBg:@"glitchglitchflame.m4a" loop:YES];
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

-(void) startOptions
{
    if (_popoverOptionsLayer == nil)
    {
        [self showPopoverNamed:@"Popups/OptionsPopup"];
        
        
//        if (isFirstPass)
//        {
//            NSLog(@"+++++++First Pass++++++");
//            isFirstPass = false;
//            [_popoverOptionsLayer initCharacter:GeordieGunter];
//            [_popoverOptionsLayer initNavigation:Swipe];
//            [_popoverOptionsLayer initAudible:true];
//            NSLog(@"MainScene::startOptions (FirstPass) User: %@", [GameData userName]);
//            [_popoverOptionsLayer initUsername:[GameData userName]];
//            
//        }
//        else
//        {
            NSLog(@"+++++++Options++++++: %@",_popoverOptionsLayer);
            //get saved values!
            NSLog(@"MainScene::startOptions Audible: %@", [GameData audible]?@"true":@"false");
            [_popoverOptionsLayer initAudible:[GameData audible]];
            NSLog(@"MainScene::startOptions Character: %@", [GameData ligger]?@"SparklePony":@"GeordieGunter");
            [_popoverOptionsLayer initCharacter:[GameData ligger]];
            NSLog(@"MainScene::startOptions Movement: %@", [GameData navigation]?@"Swipe":@"Touch");
            [_popoverOptionsLayer initNavigation:[GameData navigation]];
            NSLog(@"MainScene::startOptions User: %@", [GameData userName]);
            [_popoverOptionsLayer initUsername:[GameData userName]];
            NSLog(@"MainScene::startOptions Soundtrack: %@", [GameData soundtrack]);
            [_popoverOptionsLayer initSoundtrack:[GameData soundtrack]];
        
//        }
        
    }
}


@end
