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


//FIRST PASS LAYER & OPTIONS
@property(nonatomic) CCTextField *_txtUsername;
//FIRST PASS LAYER
@property (nonatomic) CCLabelTTF *_lblWarning; //displays under txtField- Username


// Popup Layers
//@property (nonatomic) CCLabelTTF *_lblLevel;//used by ??
@property (nonatomic) CCLabelTTF *_lblLevels;//used by GameOver popup
@property (nonatomic) CCLabelTTF *_lblCompleted;
@property (nonatomic) CCLabelTTF *_lblTime;
@property (nonatomic) CCLabelTTF *_lblHighScore;



//FirstPass
@property (nonatomic) CCButton *_btnSoulImmigrants;
@property (nonatomic) CCButton *_btnOther;
@property (nonatomic) AVAudioPlayer *backgroundMusicPlayer;

//Popup Layers
-(void) initWizard;
-(void) initLevelUpScore:(NSString*)score;
//-(void) initCompletedScore:(NSString*)score;
-(void) initWithScoreData:(ScoreData*)value;// andGameData:(GameData*)game;

// COMMON
-(void) btnBack;
//called from ....
-(void) btnContinue;

// Only called when completing the FirstPass page
// Sets the txtField to the Username field in Liggergamedata.plist
-(void) btnBackInit;


//called from ....
-(void) resumePause; //resumes pause and removes popover
-(void) back2Menu; //back to MainScene

//Game Over
-(void) btnOK;

//First Pass
//Display the T&Cs (Off of FirstPass)
-(void) btnTandCs;

-(void) btnOKTandCs;







@end
