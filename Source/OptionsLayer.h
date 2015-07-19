//
//  OptionsLayer.h
//  Ligger
//
//  Created by Gene Myers on 05/07/2015.
//  Copyright (c) 2015 Fezzee. All rights reserved.
//

#import "CCNode.h"
#import "GameScene.h"

@interface OptionsLayer : CCNode 

@property (nonatomic) CCButton *_btnGunter;
@property (nonatomic) CCButton *_btnSparkle;
@property (nonatomic) CCButton *_btnNav;
@property (nonatomic) CCButton *_btnSwipe;
@property (nonatomic) CCButton *_btnAudio;
@property (nonatomic) CCButton *_lblAudio;
@property (nonatomic) CCButton *_btnSoulImmigrants;
@property (nonatomic) CCButton *_btnOther;
@property(nonatomic) CCTextField *_txtUsername;
@property (nonatomic) CCLabelTTF *_lblWarning; //displays under txtField- Username

@property (nonatomic) CCButton *_btnDeletePlist;
@property (nonatomic) CCButton *_btnClearHistory;



-(void) btnGunterPressed;
-(void) btnSparklePonyPressed;
-(void) btnSwipeSelected;
-(void) btnNavSelected;
-(void) btnToggleAudioState;
-(void) btnSoulImmigrants;
-(void) btnOther;


-(void) btnBack;
-(void) btnBackSave;

-(void) initCharacter:(Ligger)character;
-(void) initNavigation:(Navigation)nav;
-(void) initAudible:(bool)isAudible;
-(void) initUsername:(NSString*) name;
-(void) initSoundtrack:(NSNumber*) value;

@end
