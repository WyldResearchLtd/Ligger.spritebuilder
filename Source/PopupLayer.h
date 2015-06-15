//
//  PopupLayer.h
//  Ligger
//
//  Created by Gene Myers on 15/06/2015.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "CCNode.h"
#import "GameScene.h"

@interface PopupLayer : CCNode

@property (weak) GameScene* gameScene;

-(void) btnGunterPressed;
-(void) btnSparklePonyPressed;
-(void) btnBack;
-(void) btnContinue;

@end
