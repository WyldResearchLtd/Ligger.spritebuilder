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

@property (nonatomic) CCButton *_btnNav;
@property (nonatomic) CCButton *_btnSwipe;

@property (nonatomic) CCLabelTTF *_lblLevel;
@property (nonatomic) CCLabelTTF *_lblCompleted;

@property (nonatomic) CCButton *_btnAudio;
@property (nonatomic) CCButton *_lblAudio;

-(void) btnGunterPressed;
-(void) btnSparklePonyPressed;
-(void) btnSwipeSelected;
-(void) btnNavSelected;
-(void) btnBack;
-(void) btnContinue;
-(void) btnToggleAudioState;

-(void) initCharacter:(Ligger)character;
-(void) initNavigation:(Navigation)nav;
-(void) initAudible:(bool)isAudible;

-(void) initLevelUpScore:(NSString*)score;
-(void) initCompletedScore:(NSString*)score;


@end
