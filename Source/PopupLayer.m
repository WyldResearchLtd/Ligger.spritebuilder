//
//  PopupLayer.m
//  Ligger

// This class handles the behaviour of a number of simple popup layers
// -- End of Level, End of Game, Resume Pause, etc....
//
//  Created by Gene Myers Fezzee. All rights reserved.
//

#import "PopupLayer.h"
#import "MainScene.h"
#import "GameScene.h"

@implementation PopupLayer
{
    //__weak PopupLayer* _popoverMenuLayer;
    //PopupLayer* _popover;
    PopupLayer* _popoverMenuLayer;
    //bool isFirstPass;
}

- (BOOL) popoverMenuLayer
{
    return _popoverMenuLayer;
}

- (void)setPopoverMenuLayer:(PopupLayer*)newValue {
    _popoverMenuLayer = newValue;
}

//Cocos2D methods
-(id) init {
    if((self=[super init]))
    {
        NSLog(@">>>>>> PopupLayer init() >>>>>>");
    }
    return self;
}



//-(void) btnSparklePonyPressed
//{
//    NSLog(@"OptionsLayer::btnSparklePony -> SparklePony set");
//    if (self._btnGunter.selected)
//    {
//        [self._btnGunter setSelected:false];
//        [self._btnSparkle setSelected:true];
//        [GameData setLigger:SparklePony];
//    }else{
//        [self._btnGunter setSelected:true];
//        [self._btnSparkle setSelected:false];
//        [GameData setLigger:GeordieGunter];
//    }
//    
//}
//
//
//-(void) btnGunterPressed
//{
//     NSLog(@"OptionsLayer::btnGunterPressed -> GeordieGunter set");
//    if (self._btnSparkle.selected)
//    {
//        [self._btnSparkle setSelected:false];
//        [self._btnGunter setSelected:true];
//        [GameData setLigger:GeordieGunter];
//    } else {
//        [self._btnSparkle setSelected:true];
//        [self._btnGunter setSelected:false];
//        [GameData setLigger:SparklePony];
//    }
//}
//
//-(void) btnNavSelected
//{
//    NSLog(@"OptionsLayer::btnNavSelected -> Touch set");
//    if (self._btnSwipe.selected)
//    {
//        [self._btnSwipe setSelected:false];
//        [self._btnNav setSelected:true];
//        [GameData setNavigation:Touch];
//    }else{
//        [self._btnSwipe setSelected:true];
//        [self._btnNav setSelected:false];
//        [GameData setNavigation:Swipe];
//    }
//}
//-(void) btnSwipeSelected
//{
//    NSLog(@"OptionsLayer::btnSwipeSelected -> Swipe set");
//    if (self._btnNav.selected)
//    {
//        [self._btnNav setSelected:false];
//        [self._btnSwipe setSelected:true];
//        [GameData setNavigation:Swipe];
//    }else{
//        [self._btnNav setSelected:true];
//        [self._btnSwipe setSelected:false];
//        [GameData setNavigation:Touch];
//    }
//}
//
//-(void) btnToggleAudioState
//{
//    NSLog(@"OptionsLayer::btnAudioOn Pressed");
//    OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
//    
//    if (__btnAudio.selected)
//    {
//        NSLog(@"OptionsLayer::btnAudioOn Selected");
//        //[audio setBgPaused:true];
//    }
//    //inverts audio on/off
//    [audio setBgPaused:!(audio.bgPaused)];
//    NSLog(@"Setting Audible (AudioOn) to: %@",!(audio.bgPaused)?@"YES":@"NO");
//    [GameData setAudible:!(audio.bgPaused)];
//
//    
//}
//
//
//-(void) initCharacter:(Ligger)character
//{
//    switch (character)
//    {
//        case GeordieGunter:
//            [self._btnGunter setSelected:true];
//            [self._btnSparkle setSelected:false];
//            [GameData setLigger:GeordieGunter];
//            break;
//        case SparklePony:
//            [self._btnSparkle setSelected:true];
//            [self._btnGunter setSelected:false];
//            [GameData setLigger:SparklePony];
//            break;
//    }
//}
//
//
//-(void) initNavigation:(Navigation)nav
//{
//    switch (nav)
//    {
//        case Touch:
//            [self._btnNav setSelected:true];
//            [self._btnSwipe setSelected:false];
//            [GameData setNavigation:Touch];
//            break;
//        case Swipe:
//            [self._btnSwipe setSelected:true];
//            [self._btnNav setSelected:false];
//            [GameData setNavigation:Swipe];
//            break;
//    }
//}
//
//-(void) initAudible:(bool)isAudible
//{
//    if (isAudible)
//    {
//        //when the toggle button is selected it shows the OFF icon
//        //so these seems backwards
//        [self._btnAudio setSelected:false];
//    } else {
//        [self._btnAudio setSelected:true];
//    }
//}
//
////[data setObject:self._txtUsername.string forKey:@"Username"];
//
//-(void) initUsername:(NSString*) name
//{
//    [GameData setUserName:name];
//    self._txtUsername.string = [GameData userName];
//
//}


-(void) initLevelUpScore:(NSString*)score
{
    [self._lblLevel setString:score];
}

//-(void) initCompletedScore:(NSString*)score
//{
//    
//    [self._lblCompleted setString:score];
//}


-(void) initWithScoreData:(ScoreData *)value
{
    //format the string?
    [self._lblCompleted setString:value.scoreValue.stringValue];
    [self._lblTime setString:value.timeRemaining];
    //((LevelTimer*)_timer).seconds
}


-(void) btnBack
{
    NSLog(@"Back(btn) Choosen");
    [((MainScene*)self.parent) removePopover];
}



////OPTIONS
//// Only called when going back from Options
//-(void) btnBackSave
//{
//    NSLog(@"Back & Save Choosen");
//    [((MainScene*)self.parent) removePopover];
//    NSMutableDictionary* settings = [GameData getGameSettings];
//    //so, savefields here????
//    [settings setObject:self._txtUsername.string forKey:@"Username"];
//    [GameData saveGameSettings:settings];
//    
//}


// Only called when completing the FirstPass page
// Sets the txtField to the Username field in Liggergamedata.plist
-(void) btnBackInit
{
    NSLog(@"Back & Init Choosen");
    
     NSMutableDictionary *data = [GameData getGameSettings];
    //((GameData*)data).username =
    //log the value written in the textbox here to test
    NSLog(@"OptionsLayer::btnBackInit 'Username' = txtUsername: '%@'", self._txtUsername.string);

                                
    NSString *trimmedString = [self._txtUsername.string stringByTrimmingCharactersInSet:
                                                           [NSCharacterSet whitespaceCharacterSet]];
    
    if (trimmedString.length == 0)
    {
        NSLog(@"ERROR: EMPTY ENTRY");
        //not sucessful
        //this returns you to Menu- it should exit?
        self._lblWarning.string = @"Required field.";
        return; 
    }
        
    [data setObject:self._txtUsername.string forKey:@"Username"];
    [GameData saveGameSettings:data];
    
    [((MainScene*)self.parent) removePopover];
    
}


-(void) btnContinue
{
    NSLog(@"Continue(btn) Choosen");
    [((GameScene*)self.parent) removePopover];
    
}

//called
-(void) resumePause
{
     NSLog(@"ResumePause");
   [((GameScene*)self.parent) removePopover];
}

-(void) back2Menu
{
    NSLog(@"back2Menu");
    
    CCScene* scene = [CCBReader loadAsScene:@"MainScene"];
    CCTransition* transition = [CCTransition transitionFadeWithDuration:1.5];
    [[CCDirector sharedDirector] presentScene:scene withTransition:transition];
}

/*
 * Game Over- Back to Menu
 */
-(void) btnOK
{
    NSLog(@"OK(btn) Choosen");
    [((GameScene*)self.parent) backToMenu];
}

/*
 * Display the T&Cs
 */
-(void) btnTandCs
{
    NSLog(@"T And C's (btn) Choosen");
    //Popup FirstPass UIs ???
   [self showPopoverNamed:@"Popups/TandCs"];
}

//ERROR: This causes an exception when you try to go back from the T&C pages off of the FirstPass layer
-(void) btnOKTandCs
{
    NSLog(@"btnOKTandCs");
    //_popoverMenuLayer =
    [self removePopover];  //DO NOT REMOVE BREAKPOINT UNTIL RESOLVED
}

-(void) btnExit
{
    NSLog(@"btnExit");
    exit(0);
}



//-(void) initCharacter:(Ligger)character
//{
//    switch (character)
//    {
//        case GeordieGunter:
//            [self._btnGunter setSelected:true];
//            [self._btnSparkle setSelected:false];
//            [GameData setLigger:GeordieGunter];
//            break;
//        case SparklePony:
//            [self._btnSparkle setSelected:true];
//            [self._btnGunter setSelected:false];
//            [GameData setLigger:SparklePony];
//            break;
//    }
//}
//
//
//-(void) initNavigation:(Navigation)nav
//{
//    switch (nav)
//    {
//        case Touch:
//            [self._btnNav setSelected:true];
//            [self._btnSwipe setSelected:false];
//            [GameData setNavigation:Touch];
//            break;
//        case Swipe:
//            [self._btnSwipe setSelected:true];
//            [self._btnNav setSelected:false];
//            [GameData setNavigation:Swipe];
//            break;
//    }
//}
//
//-(void) initAudible:(bool)isAudible
//{
//    if (isAudible)
//    {
//        //when the toggle button is selected it shows the OFF icon
//        //so these seems backwards
//        [self._btnAudio setSelected:false];
//    } else {
//        [self._btnAudio setSelected:true];
//    }
//}
//
////[data setObject:self._txtUsername.string forKey:@"Username"];
//
//-(void) initUsername:(NSString*) name
//{
//    [GameData setUserName:name];
//    self._txtUsername.string = [GameData userName];
//    
//}

-(void) showPopoverNamed:(NSString*)name
{
    if (_popoverMenuLayer == nil)
    {
        //PopupLayer* newMenuLayer
        _popoverMenuLayer = (PopupLayer*)[CCBReader load:name];
        NSAssert(_popoverMenuLayer!=nil, @"PopupLayer in showPopoverNamed is Nil");
        [self addChild:_popoverMenuLayer];
        _popoverMenuLayer.parent = self;
        GameScene.halt=true;
        //_levelNode.paused = YES;
    }
}

-(void) removePopover
{
    //PopupLayer* tmp = _popover;
    if (_popoverMenuLayer != nil)
    {
        NSLog(@"Popup removed");
        _popoverMenuLayer.visible = YES;
        [_popoverMenuLayer removeFromParent];
        _popoverMenuLayer = nil;
        //_levelNode.paused = NO;
        GameScene.halt = false;
        NSLog(@"Completed Popup removal");
    }
    else
    {
        NSLog(@"Unable to remove Popup");
    }
}

@end

