//
//  OptionsLayer.m
//  Ligger
//
//  Created by Gene Myers on 05/07/2015.
//  Copyright (c) 2015 Fezzee. All rights reserved.
//

#import "OptionsLayer.h"
#import "MainScene.h"
#import "GameScene.h"

@implementation OptionsLayer
{

   // PopupLayer* _popoverMenuLayer;
}

//- (BOOL) popoverMenuLayer
//{
//    return _popoverMenuLayer;
//}
//
//- (void)setPopoverMenuLayer:(PopupLayer*)newValue {
//    _popoverMenuLayer = newValue;
//}

-(void) btnSparklePonyPressed
{
    NSLog(@"OptionsLayer::btnSparklePony -> SparklePony set");
    if (self._btnGunter.selected)
    {
        [self._btnGunter setSelected:false];
        [self._btnSparkle setSelected:true];
        [GameData setLigger:SparklePony];
    }else{
        [self._btnGunter setSelected:true];
        [self._btnSparkle setSelected:false];
        [GameData setLigger:GeordieGunter];
    }
    
}


-(void) btnGunterPressed
{
    NSLog(@"OptionsLayer::btnGunterPressed -> GeordieGunter set");
    if (self._btnSparkle.selected)
    {
        [self._btnSparkle setSelected:false];
        [self._btnGunter setSelected:true];
        [GameData setLigger:GeordieGunter];
    } else {
        [self._btnSparkle setSelected:true];
        [self._btnGunter setSelected:false];
        [GameData setLigger:SparklePony];
    }
}

-(void) btnNavSelected
{
    NSLog(@"OptionsLayer::btnNavSelected -> Touch set");
    if (self._btnSwipe.selected)
    {
        [self._btnSwipe setSelected:false];
        [self._btnNav setSelected:true];
        [GameData setNavigation:Touch];
    }else{
        [self._btnSwipe setSelected:true];
        [self._btnNav setSelected:false];
        [GameData setNavigation:Swipe];
    }
}
-(void) btnSwipeSelected
{
    NSLog(@"OptionsLayer::btnSwipeSelected -> Swipe set");
    if (self._btnNav.selected)
    {
        [self._btnNav setSelected:false];
        [self._btnSwipe setSelected:true];
        [GameData setNavigation:Swipe];
    }else{
        [self._btnNav setSelected:true];
        [self._btnSwipe setSelected:false];
        [GameData setNavigation:Touch];
    }
}

-(void) btnToggleAudioState
{
    NSLog(@"OptionsLayer::btnAudioOn Pressed");
    OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];

    if (audio.bgPaused)
    {
        [audio setBgPaused:false];
        [GameData setAudible:true];
    }
    else if (!(audio.bgPlaying))
    {
        //[audio playBg:@"hustle.caf" loop:YES]; //hustle2 is the Gameplay track
        [audio playBg:@"glitchglitchflame.m4a" loop:YES];
        [GameData setAudible:true];
    }
    else
    {
        [audio setBgPaused:true];
        [GameData setAudible:false];
    }
    NSLog(@"Setting Audible (AudioOn) to: %@",[GameData audible]?@"True":@"False");
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
}

//////////////////


-(void) initCharacter:(Ligger)character
{
    switch (character)
    {
        case GeordieGunter:
            [self._btnGunter setSelected:true];
            [self._btnSparkle setSelected:false];
            [GameData setLigger:GeordieGunter];
            break;
        case SparklePony:
            [self._btnSparkle setSelected:true];
            [self._btnGunter setSelected:false];
            [GameData setLigger:SparklePony];
            break;
    }
}


-(void) initNavigation:(Navigation)nav
{
    switch (nav)
    {
        case Touch:
            [self._btnNav setSelected:true];
            [self._btnSwipe setSelected:false];
            [GameData setNavigation:Touch];
            break;
        case Swipe:
            [self._btnSwipe setSelected:true];
            [self._btnNav setSelected:false];
            [GameData setNavigation:Swipe];
            break;
    }
}

-(void) initAudible:(bool)isAudible
{
    if (isAudible)
    {
        //when the toggle button is selected it shows the OFF icon
        //so these seems backwards
        [self._btnAudio setSelected:false];
    } else {
        [self._btnAudio setSelected:true];
    }
}

//[data setObject:self._txtUsername.string forKey:@"Username"];

-(void) initUsername:(NSString*) name
{
    //[GameData setUserName:name];
    NSLog(@"OptionsLayer::initUsername User: %@", [GameData userName]);
    self._txtUsername.string = [GameData userName];
    
}


-(void) initSoundtrack:(NSNumber*) value
{
    if ([value integerValue]==0) //The Soul Immigrants
    {
        //when the toggle button is selected it shows the OFF icon
        //so these seems backwards
        [self._btnSoulImmigrants setSelected:true];
        [self._btnOther setSelected:false];
    }
    else if ([value integerValue]==1) //The Caufield Beats{
    {
        [self._btnSoulImmigrants setSelected:false];
        [self._btnOther setSelected:true];
    }
    
}

-(void) btnBack
{
    NSLog(@"Back(btn) Choosen");
    [((MainScene*)self.parent) removePopover];
}

//OPTIONS
// Only called when going back from Options
-(void) btnBackSave
{
    NSLog(@"Back & Save Choosen");
    
    NSMutableDictionary* settings = [GameData getGameSettings];
    //so, savefields here????
    [settings setObject:self._txtUsername.string forKey:@"Username"];
    [GameData saveGameSettings:settings];
    
    [((MainScene*)self.parent) removePopover];

}




@end
