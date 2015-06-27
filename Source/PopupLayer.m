//
//  PopupLayer.m
//  Ligger
//
//  Created by Gene Myers on 15/06/2015.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "PopupLayer.h"
#import "MainScene.h"
#import "GameScene.h"

@implementation PopupLayer



-(void) btnSparklePonyPressed
{
    NSLog(@"SparklePony Choosen");
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
     NSLog(@"GeordieGunter Choosen");
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
    NSLog(@"Swipe Choosen");
    if (self._btnSwipe.selected)
    {
        [self._btnSwipe setSelected:false];
        [self._btnNav setSelected:true];
        [GameData setNavigation:Swipe];
    }else{
        [self._btnSwipe setSelected:true];
        [self._btnNav setSelected:false];
        [GameData setNavigation:Touch];
    }
}
-(void) btnSwipeSelected
{
    NSLog(@"Nav Choosen");
    if (self._btnNav.selected)
    {
        [self._btnNav setSelected:false];
        [self._btnSwipe setSelected:true];
        [GameData setNavigation:Touch];
    }else{
        [self._btnNav setSelected:true];
        [self._btnSwipe setSelected:false];
        [GameData setNavigation:Swipe];
    }
}



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



-(void) initLevelUpScore:(NSString*)score
{
    [self._lblLevel setString:score];
}

-(void) initCompletedScore:(NSString*)score
{
    [self._lblCompleted setString:score];
}


-(void) btnBack
{
    NSLog(@"Back(btn) Choosen");
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

-(void) btnAudioOn
{
    NSLog(@"btnAudioOn Pressed");
}


/*
 * Game Over
 */
-(void) btnOK
{
    NSLog(@"OK(btn) Choosen");
    [((GameScene*)self.parent) backToMenu];
    
}

@end
