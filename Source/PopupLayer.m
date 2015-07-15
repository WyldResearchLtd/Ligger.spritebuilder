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
    PopupLayer* _popoverMenuLayer;
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


//This is for the LevelLayer
-(void) initLevelUpScore:(NSString*)score
{
    //TODO: is init called??
    //[self init];
    [self._lblCompleted setString:score];
}




//This is for the GameOverLayer
-(void) initWithScoreData:(ScoreData *)value //andGameData:(GameData*)game
{
    //TODO: format the string
    [self._lblCompleted setString:[NSString stringWithFormat:@"Score: %@", value.scoreValue.stringValue]];
    [self._lblTime setString:[NSString stringWithFormat:@"%@ secs left", value.timeRemaining.stringValue]];
    [self._lblLevels setString:[NSString stringWithFormat:@"Level: %@", value.scoreLevel.stringValue]];
    [self._lblHighScore setString:value.isHighScore?@"High Score":@"The Hustle Is On"];
    
     OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
     [audio setBgPaused:true];
    
//    OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
//    [audio playBg:@"Beethoven-Symp9-4th_mvmnt-Ode_to_Joy-Except.m4a" loop:YES];
//    [audio.backgroundTrack fadeTo:3.0 duration:10 target:self selector:@selector(doVolumeFade)];//fadeTo:2.0 duration: target:self selector:@selector(doVolumeFade)];
    
//    soundPath = [[NSBundle mainBundle] pathForResource:@"soundtrack" ofType:@"m4a"];
//    soundtrack = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:soundPath] error:nil];
//    [soundtrack setVolume: 0.0];
//    [soundtrack prepareToPlay];
    
    //play background sound
    NSError *error;
    NSURL * backgroundMusicURL = [[NSBundle mainBundle] URLForResource:@"Beethoven-Symp9-4th_mvmnt-Ode_to_Joy-Except" withExtension:@"m4a"];
    self.backgroundMusicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:backgroundMusicURL error:&error];
    self.backgroundMusicPlayer.numberOfLoops = -1;
    float fadeTo = self.backgroundMusicPlayer.volume;
    NSLog(@"Volume Setting: %.2f", fadeTo);
    self.backgroundMusicPlayer.volume = 0.01;
    [self.backgroundMusicPlayer prepareToPlay];
    [self.backgroundMusicPlayer play];
    [self doVolumeFadeIn:[NSNumber numberWithFloat:fadeTo]];
    
}


-(void)doVolumeFadeIn:(NSNumber*)fadeTo {
    if (self.backgroundMusicPlayer.volume < [fadeTo floatValue]) {
        self.backgroundMusicPlayer.volume = self.backgroundMusicPlayer.volume + 0.01;
        [self performSelector:@selector(doVolumeFadeIn:) withObject:fadeTo afterDelay:0.1];
    }
}

//-(void) doVolumeFade
//{
//    NSLog(@"~~~~~~~~~~~~~~~~ Volume Fade ~~~~~~~~~~~~~~~~~~~~~");
//}

-(void) btnBack
{
    NSLog(@"Back(btn) Choosen");
    [((MainScene*)self.parent) removePopover];
}


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
        self._lblWarning.string = @"*** Required field";
        return; 
    }
        
    [data setObject:self._txtUsername.string forKey:@"Username"];
    [GameData saveGameSettings:data];
    
    [((MainScene*)self.parent) removePopover];
    
}

//This gets pressed on the Levelup Popup
-(void) btnContinue
{
    NSLog(@"PopupLayer::btnContinue");
    [((GameScene*)self.parent) removePopover];
    
    [self.backgroundMusicPlayer stop];
    
    if ([GameData audible])
    {
        // access audio object- play music while loading sprites below
        OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
        if ([[GameData soundtrack] integerValue]==0)
            [audio playBg:@"hustle2.caf" loop:YES];
        else if ([[GameData soundtrack] integerValue]==1)
            [audio playBg:@"glitchglitchflame.m4a" loop:YES];
    }

    
}

//called
-(void) resumePause
{
     NSLog(@"PopupLayer::ResumePause");
   [((GameScene*)self.parent) removePopover];
}

-(void) back2Menu
{
    NSLog(@"PopupLayer::back2Menu");
    
    CCScene* scene = [CCBReader loadAsScene:@"MainScene"];
    CCTransition* transition = [CCTransition transitionFadeWithDuration:1.5];
    [[CCDirector sharedDirector] presentScene:scene withTransition:transition];
}

/*
 * Game Over- Back to Menu
 */
-(void) btnOK
{
    NSLog(@"PopupLayer::btnOK");
    //NSLog(@"OK(btn) Choosen");
    [((GameScene*)self.parent) backToMenu];
    
    [self.backgroundMusicPlayer stop];
}

/*
 * Display the T&Cs
 */
-(void) btnTandCs
{
    NSLog(@"PopupLayer::btnTandCs");
    //NSLog(@"T And C's (btn) Choosen");
    //Popup FirstPass UIs ???
    [self setVisible:false];
   [self showPopoverNamed:@"Popups/TandCs"];
}

//ERROR: This causes an exception when you try to go back from the T&C pages off of the FirstPass layer
-(void) btnOKTandCs
{
    NSLog(@"PopupLayer::btnOKTandCs");
    _popoverMenuLayer = self;
    [self setVisible:true];
    [self removePopover];  //DO NOT REMOVE BREAKPOINT UNTIL RESOLVED
}

-(void) btnExit
{
    NSLog(@"btnExit");
    exit(0);
}




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

-(void) initWizard
{
    
    NSLog(@">>>>>>>>>>>>>>>>>>>>Initalizing Wizard");
    [self._btnSoulImmigrants setSelected:true];
    [self._btnOther setSelected:false];
    

}


-(void) btnSoulImmigrants
{
    NSLog(@"OptionsLayer::btnSoulImmigrants -> Caufield Beats set");
    if (self._btnOther.selected)
    {
        [self._btnOther setSelected:false];
        [self._btnSoulImmigrants setSelected:true];
        [GameData setSoundtrack:[NSNumber numberWithInt:0]]; //0== Soul Immigrants
    }else{
        [self._btnOther setSelected:true];
        [self._btnSoulImmigrants setSelected:false];
        [GameData setSoundtrack:[NSNumber numberWithInt:1]];
    }
    
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
    
}


-(void) btnOther
{
    NSLog(@"OptionsLayer::btnOther -> Soul Immigrants set");
    if (self._btnSoulImmigrants.selected)
    {
        [self._btnSoulImmigrants setSelected:false];
        [self._btnOther setSelected:true];
        [GameData setSoundtrack:[NSNumber numberWithInt:1]];
    } else {
        [self._btnSoulImmigrants setSelected:true];
        [self._btnOther setSelected:false];
        [GameData setSoundtrack:[NSNumber numberWithInt:0]];
    }
    
    
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
}



@end

