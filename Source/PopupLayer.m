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


/*
 * Game Over
 */
-(void) btnOK
{
    NSLog(@"OK(btn) Choosen");
    [((GameScene*)self.parent) backToMenu];
    
}

@end
