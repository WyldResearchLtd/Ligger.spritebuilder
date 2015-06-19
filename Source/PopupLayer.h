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


//@property (nonatomic) CCNode* parent; //we let the superclass handle this
@property (nonatomic) CCButton *_btnGunter;
@property (nonatomic) CCButton *_btnSparkle;

@property (nonatomic) CCLabelTTF *_lblLevel;
@property (nonatomic) CCLabelTTF *_lblCompleted;

-(void) btnGunterPressed;
-(void) btnSparklePonyPressed;
-(void) btnBack;
-(void) btnContinue;
-(void) initCharacter:(Ligger)character;
-(void) initLevelUpScore:(NSString*)score;
-(void) initCompletedScore:(NSString*)score;

@end
