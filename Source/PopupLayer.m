//
//  PopupLayer.m
//  Ligger
//
//  Created by Gene Myers on 15/06/2015.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "PopupLayer.h"

@implementation PopupLayer

-(void) btnSparklePonyPressed
{
    NSLog(@"SparklePony Choosen");
}


-(void) btnGunterPressed
{
        NSLog(@"GeordieGunter Choosen");
}


-(void) btnBack
{
    NSLog(@"Back(btn) Choosen");
    [self.gameScene removePopover];
  
}


-(void) btnContinue
{
    NSLog(@"Continue(btn) Choosen");
    [self.gameScene removePopover];
    
}

/*
 * Game Over
 */
-(void) btnOK
{
    NSLog(@"OK(btn) Choosen");
    [self.gameScene backToMenu];
    
}

@end
