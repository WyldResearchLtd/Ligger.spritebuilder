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
//OPTIONS LAYER
//@property (nonatomic) CCButton *_btnGunter;
//@property (nonatomic) CCButton *_btnSparkle;
//
//@property (nonatomic) CCButton *_btnNav;
//@property (nonatomic) CCButton *_btnSwipe;
//
//@property (nonatomic) CCButton *_btnAudio;
//@property (nonatomic) CCButton *_lblAudio;

//FIRST PASS LAYER & OPTIONS
@property(nonatomic) CCTextField *_txtUsername;
//FIRST PASS LAYER
@property (nonatomic) CCLabelTTF *_lblWarning; //displays under txtField- Username


// Popup Layers
@property (nonatomic) CCLabelTTF *_lblLevel;
@property (nonatomic) CCLabelTTF *_lblCompleted;





//@property (nonatomic)  PopupLayer* popover;




////OPTIONS LAYER
//-(void) btnGunterPressed;
//-(void) btnSparklePonyPressed;
//-(void) btnSwipeSelected;
//-(void) btnNavSelected;
//-(void) btnToggleAudioState;
//
//SETTINGS INIT OPTION LAYER
//-(void) initCharacter:(Ligger)character;
//-(void) initNavigation:(Navigation)nav;
//-(void) initAudible:(bool)isAudible;
//-(void) initUsername:(NSString*) name;

//Popup Layers
-(void) initLevelUpScore:(NSString*)score;
-(void) initCompletedScore:(NSString*)score;

// COMMON
-(void) btnBack;
//called from ....
//-(void) btnContinue;
//// Only called when going back from Options
//-(void) btnBackSave;
// Only called when completing the FirstPass page
// Sets the txtField to the Username field in Liggergamedata.plist
-(void) btnBackInit;


//called from ....
-(void) resumePause; //resumes pause and removes popover
-(void) back2Menu; //back to MainScene

//Game Over
-(void) btnOK;

//Display the T&Cs (Off of FirstPass)
-(void) btnTandCs;

-(void) btnOKTandCs;







@end
