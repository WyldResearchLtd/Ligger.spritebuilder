//
//  GameScene.m
//  Ligger
//
//  Created by Gene Myers on 13/04/2015.
//  Copyright (c) 2015 Fezzee Ltd. All rights reserved.
//

#import "GameScene.h"
#import "LevelTimer.h"
#import "Obstacle.h"
#import "PopupLayer.h"
#import "ScoreData.h"


@implementation GameScene
{
    //__weak CCPhysicsNode* _physicsNode;
    //__weak CCNode* _backgroundNode;
    __weak CCNode* _levelNode;
    __weak CCNode* _playerNode;
    __weak PopupLayer* _popoverMenuLayer;
    GameManager* _gameManager;
}

static Boolean halt = false;
//a static implemntation of Halt
+ (Boolean) halt { return halt; }
+ (void) setHalt:(Boolean)value { halt = value; }


int idxBartender = 0;//the current choosen bartender
int cntBartender = 0; //current bartender frame count
int ttBartender = 0; //the total time for this bartender round
bool bBartenderServing = false;
bool isPromotorSetupStarted = false;
bool isCollisionInProgress = false;

-(void) didLoadFromCCB
{
    
    
    self.levelState = GameSetup;
    NSLog(@"GameScene: didLoadFromCCB created, Level: %d", self.levelState);
    
    
    
    //screen coords for displaying the timer
    CGSize winSize = [[CCDirector sharedDirector] viewSize];
    self.screenWidth = winSize.width;
    self.screenHeight = winSize.height;
    NSLog(@"GameScene: LevelTimer created");
    _timer = [[LevelTimer alloc] initWithGame:self x:-46 y:self.screenHeight-6];
    

    _gameManager = [[GameManager alloc] initWithTimer:_timer];
    //TODO: Replace all of the calls to self.gameData with calls to _gameManager._gameData, and integrate the LevelTimer more too
    self.gameData = _gameManager._gameData;
    NSLog(@"GameScene: GameManager (GameData) created");
    

    // load the current level- this takes time
    [self loadLevel];
    NSLog(@"GameScene: Level Loaded");
    
    
    NSLog(@"GameScene: Setup Swipe Recognisers");
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeGesture:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [[[CCDirector sharedDirector] view] addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self  action:@selector(handleSwipeGesture:)];
    ;swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [[[CCDirector sharedDirector] view] addGestureRecognizer:swipeRight];
    
    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc]  initWithTarget:self action:@selector(handleSwipeGesture:)];
    swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
    //[self addGestureRecognizer:swipeUp];
    [[[CCDirector sharedDirector] view] addGestureRecognizer:swipeUp];
    
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeGesture:)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    [[[CCDirector sharedDirector] view] addGestureRecognizer:swipeDown];
    
    // enable receiving input events
    self.userInteractionEnabled = YES;

    
    NSLog(@"GameScene: didLoadFromCCB completed, Level: %@", _levelNode);
}

// This is the Pause button
-(void) pauseButtonPressed
{
    
    //if a popup menu isn't hding this....
    if (_popoverMenuLayer == nil)
    {
        NSLog(@"pauseButtonPressed");
        
        [self.timer pauseTimer];
        
        [self showPopoverNamed:@"Popups/PausePopup"];

    }
}

-(void) calcBonus
{
   
     NSLog(@"Calc Bonus");
    if (self.playerState==TwoBeers)
        [self.gameData finishTwoBeers:((LevelTimer*)self.timer).seconds hud:self._lblHUDscore];
    else if (self.playerState==OneBeer)
        [self.gameData finishOneBeer:((LevelTimer*)self.timer).seconds hud:self._lblHUDscore];
    [self.gameData calcBonus:kTOTALTIMER-((LevelTimer*)self.timer).seconds forPromotor:kPROMOTORS+1-(int)self.promotors.count hud:self._lblHUDscore];
    NSLog(@"Game Duration: %d",((LevelTimer*)_timer).seconds);
     NSLog(@"+++++++GAME SCORE++++++: %d", _gameData.GameScore);
}

-(void) gameOver
{
    
    if (_popoverMenuLayer == nil)
    {
        
        //get time formatting-NOW for gametimestamp
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        //Optionally for time zone conversions
        [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
        //NOW
        NSString *stringFromDate = [formatter stringFromDate:[NSDate date]];
        
        //[_gameManager incrementLevelCount];
        
        
        //Update the "Best" scores in LiggerGamedata.plist
        ScoreData* scoreData = [[ScoreData alloc] initWithScore:_gameData.GameScore MaxLevel:[_gameManager level] Name:[GameData userName] Date:stringFromDate   GUID:[GameData userID] Device:[GameData deviceID]  Remaing:kTOTALTIMER-((LevelTimer*)self.timer).seconds];
        //this is an important and powerful line
        //GameData::isScoreHigh sets the 'Best-' fields in LiggerGamedata.plist if needed, and returns true if done
        scoreData.isHighScore = [_gameManager._gameData updateHighScore:scoreData];
        //this is used to in PopupLayer to distinguish between a LevelUp and GameOver
        //could replace this by checking for a scoreObj!!
        scoreData.isGameOver = true;
        
        //Call the GameManager here= GameOver!
        //lets pass this a ScoreData object too.
        [_gameManager gameOver:scoreData];
        

        [self showPopoverNamed:@"Popups/GameOver"];
        [_popoverMenuLayer initWithScoreData:scoreData];
        //for debuging
        [_gameData printLog];
    }
     NSLog(@"Game Over*****************");
}

//- (void) refreshUI
//{
//    [self loadLevel];
//}

- (CCNode*) getScreen
{
    return self;
}

//called from two places
-(void) setPlayerAtStart:(CCNode*)player
{
    player.position = ccp(280.268311,48.001999);
}

-(void) loadLevel
{
    NSLog(@"±±±±±±±±±± LOAD LEVEL ±±±±±±±±±±±±±±±");
    [_gameData reset];
    if (GameData.navigation==Touch)
    {
        self.arrowUp.visible =true;
        self.arrowDown.visible =true;
        self.arrowLeft.visible =true;
        self.arrowRight.visible =true;
        
        self.arrowUp.enabled = true;
        self.arrowDown.enabled = true;
        self.arrowLeft.enabled = true;
        self.arrowRight.enabled = true;
    } else if (GameData.navigation==Swipe){
        //load the HUD sprites
        self._beerOne = [CCSprite spriteWithImageNamed:@"Published-iOS/Sprites/resources-phone/beer.png"];
        self._beerTwo = [CCSprite spriteWithImageNamed:@"Published-iOS/Sprites/resources-phone/beer.png"];
        [self._beerOne setAnchorPoint:ccp(0,0)];
        [self._beerTwo setAnchorPoint:ccp(0,0)];
        self._beerOne.position = CGPointMake(80.0f, 30.0f);
        self._beerTwo.position = CGPointMake(105.0f, 30.0f);
        [self._nodeHUD addChild:(CCNode*)self._beerOne];
        [self._nodeHUD addChild:(CCNode*)self._beerTwo];
        [self._beerOne setVisible:false];
        [self._beerTwo setVisible:false];
        
        self.arrowUp.visible =false;
        self.arrowDown.visible =false;
        self.arrowLeft.visible =false;
        self.arrowRight.visible =false;
        
        self.arrowUp.enabled = false;
        self.arrowDown.enabled = false;
        self.arrowLeft.enabled = false;
        self.arrowRight.enabled = false;
    }
    
    
    if (GameData.ligger==SparklePony)
    {
        _playerNode = [self getChildByName:@"player2f" recursively:TRUE];
        if (GameData.navigation==Swipe)
        {
            self._hudLigger2.visible = true;
            self._hudLigger1.visible = false;
            self._hudLigger = self._hudLigger2;
        }
    }
    else
    {
        _playerNode = [self getChildByName:@"player1m" recursively:TRUE];
        if (GameData.navigation==Swipe)
        {
            self._hudLigger1.visible = true;
            self._hudLigger2.visible = false;
            self._hudLigger = self._hudLigger1;
        }
    }
    
    [self setPlayerAtStart:_playerNode];
    
    self.playerState = NoBeers;
    NSAssert(_playerNode, @"player node not found in loadLevel");
    
    //Can use self and recursively:YES, or use _levelNode and NO to recursive
    Obstacle* ob1 = [[Obstacle alloc] initWithDirection:MoveRight forSprite:[_levelNode getChildByName:@"obstacle1" recursively:NO] atStartPosition:CGPointMake(-70.0f,112.0f)];
    Obstacle* ob2 = [[Obstacle alloc] initWithDirection:MoveLeft forSprite:[_levelNode getChildByName:@"obstacle2" recursively:NO] atStartPosition:CGPointMake(634.5f,174.5f)];
    Obstacle* ob3 = [[Obstacle alloc] initWithDirection:MoveRight forSprite:[_levelNode getChildByName:@"obstacle3" recursively:NO] atStartPosition:CGPointMake(-101.0f,238.5f)];
    Obstacle* ob4 = [[Obstacle alloc] initWithDirection:MoveLeft forSprite:[_levelNode getChildByName:@"obstacle4" recursively:NO] atStartPosition:CGPointMake(634.5f,306.5)];
    Obstacle* ob5 = [[Obstacle alloc] initWithDirection:MoveRight forSprite:[_levelNode getChildByName:@"obstacle5" recursively:NO] atStartPosition:CGPointMake(-101.0f,372.0f)];
    Obstacle* ob6 = [[Obstacle alloc] initWithDirection:MoveLeft forSprite:[_levelNode getChildByName:@"obstacle6" recursively:NO] atStartPosition:CGPointMake(631.5f,494.6f)];
    Obstacle* ob7 = [[Obstacle alloc] initWithDirection:MoveRight forSprite:[_levelNode getChildByName:@"obstacle7" recursively:NO] atStartPosition:CGPointMake(-90.5f,563.2f)];
    Obstacle* ob8 = [[Obstacle alloc] initWithDirection:MoveLeft forSprite:[_levelNode getChildByName:@"obstacle8" recursively:NO] atStartPosition:CGPointMake(674.0f,627.2f)];
    Obstacle* ob9 = [[Obstacle alloc] initWithDirection:MoveRight forSprite:[_levelNode getChildByName:@"obstacle9" recursively:NO] atStartPosition:CGPointMake(-101.0f,690.2f)];
    Obstacle* ob10 = [[Obstacle alloc] initWithDirection:MoveLeft forSprite:[_levelNode getChildByName:@"obstacle10" recursively:NO] atStartPosition:CGPointMake(634.5f,751.2f)];


    if (EASYPASS)
    {
        self.obstacles = [NSMutableArray arrayWithObjects:ob1,ob2,ob3,ob4,ob5,ob6,ob7,ob8,ob9,ob10, nil];
    }
    else
    {
        
        //
        
//        Obstacle *ob1a = [ob7 copy];
//        ob1a.position = CGPointMake(-350.0f,112.0f);

        
        Obstacle* ob1a = [[Obstacle alloc] initWithDirection:MoveRight forSprite:[_levelNode getChildByName:@"congaline-r" recursively:NO] atStartPosition:CGPointMake(-350.0f,112.0f)];
        Obstacle* ob2a = [[Obstacle alloc] initWithDirection:MoveLeft forSprite:[_levelNode getChildByName:@"golfcart-l" recursively:NO] atStartPosition:CGPointMake(950.0f,174.5f)];
        Obstacle* ob3a = [[Obstacle alloc] initWithDirection:MoveRight forSprite:[_levelNode getChildByName:@"fstreaker-r" recursively:NO] atStartPosition:CGPointMake(-350.0f,238.5f)];
        Obstacle* ob4a = [[Obstacle alloc] initWithDirection:MoveLeft forSprite:[_levelNode getChildByName:@"hulahoop-l" recursively:NO] atStartPosition:CGPointMake(950.0f,306.5f)];
        Obstacle* ob5a = [[Obstacle alloc] initWithDirection:MoveRight forSprite:[_levelNode getChildByName:@"hulahoop-2-r" recursively:NO] atStartPosition:CGPointMake(-450.0f,372.0f)];
        Obstacle* ob6a = [[Obstacle alloc] initWithDirection:MoveLeft forSprite:[_levelNode getChildByName:@"bongos-2-l" recursively:NO] atStartPosition:CGPointMake(950.0f,494.6f)];
        Obstacle* ob7a = [[Obstacle alloc] initWithDirection:MoveRight forSprite:[_levelNode getChildByName:@"huggers-r" recursively:NO] atStartPosition:CGPointMake(-440.5f,563.2f)];
        Obstacle* ob8a = [[Obstacle alloc] initWithDirection:MoveLeft forSprite:[_levelNode getChildByName:@"bongos-3-l" recursively:NO] atStartPosition:CGPointMake(957.5f,627.2f)];
        Obstacle* ob9a = [[Obstacle alloc] initWithDirection:MoveRight forSprite:[_levelNode getChildByName:@"fstreaker-2-r" recursively:NO] atStartPosition:CGPointMake(-450.0f,690.2f)];
        Obstacle* ob10a = [[Obstacle alloc] initWithDirection:MoveLeft forSprite:[_levelNode getChildByName:@"forklift-l" recursively:NO] atStartPosition:CGPointMake(964.0f,751.2f)];

//        Obstacle* ob1a = [[Obstacle alloc] initWithDirection:MoveRight forSprite:[CCBReader load:@"Prefabs/CongaLine"] atPosition:
//            CGPointMake(-350.0f,112.0f)];
        
        //doesn't need to be added as a child, because its on the scene Level1
        Obstacle* ob11 = [[Obstacle alloc] initWithDirection:MoveRight forSprite:[_levelNode getChildByName:@"obstacle11" recursively:NO] atStartPosition:CGPointMake(-75.0f,814.7f)];

        //[self addChild:ob1a.sprite];
        
        self.obstacles = [NSMutableArray arrayWithObjects:ob1,ob1a,ob2,ob2a,ob3,ob3a,ob4,ob4a,ob5,ob5a,ob6,ob6a,ob7,ob7a,ob8,ob8a,ob9,ob9a,ob10,ob10a,ob11, nil];
        //self.obstacles = [NSMutableArray arrayWithObjects:ob1,ob1a,ob2,ob2a,ob3,ob4,ob5,ob6,ob7,ob8,ob9,ob10, nil];

        
    }
    
    self.bartender1 = [self getChildByName:@"bartender1" recursively:YES];
    NSAssert(self.bartender1,@"backstage-front node not found in loadLevel");
    
    CCNode* promotor1 = [self getChildByName:@"promotor1" recursively:YES];
    CCNode* promotor2 = [self getChildByName:@"promotor2" recursively:YES];
    CCNode* promotor3 = [self getChildByName:@"promotor3" recursively:YES];
    CCNode* promotor4 = [self getChildByName:@"promotor4" recursively:YES];
    
    self.promotors = [NSMutableArray arrayWithObjects:promotor1,promotor2,promotor3,promotor4, nil];
    
    self.bkstage_f = [self getChildByName:@"backstage-front" recursively:YES];
    self.bkstage_b = [self getChildByName:@"backstage-back" recursively:YES];
    NSAssert(self.bkstage_f, @"backstage-front node not found in loadLevel");
    NSAssert(self.bkstage_b, @"backstage-back node not found in  loadLevel");
    
    [self startGame];
}

-(void) updateHUD
{
    switch (self.playerState) {
        case TwoBeers:
            [self._hudLigger setVisible:false];
            [self._beerOne setVisible:true];
            [self._beerTwo setVisible:true];
            break;
        case OneBeer:
            [self._beerTwo  setVisible:false];
            break;
        default: //NoBeers
            [self._hudLigger  setVisible:true];
            [self._beerOne  setVisible:false];
            break;
    }
}


/*
 * This is the Workhorse method for the animation.
 * Here we
 */

-(void) update:(CCTime)delta
{
   if (isCollisionInProgress) return;
    
   if (!GameScene.halt)
   {
        //NSLog(@"Player Row: %f",_playerNode.position.y);
        // update scroll node position to player node, with offset to center player in the view
        [self scrollToTarget:_playerNode];
       
        [self moveObstacles];
       
        if (self.levelState==GameSetup)
        {
            [self advancePromotor];
        }
        else if (self.levelState==PlayGame)
        {
            [self moveBartender];
        }
       else if (self.levelState==CompleteLevel)
       {
           [self completeLevel];
       }
       else if (self.levelState==LevelUp)
       {
           [self LevelUp];
       }
   }
}

//TODO: move to Obstacle class?
-(Boolean) doesCollide:(CCNode*)obstacle withPlayer:(CCNode*) player
{
    Boolean rtn = false;
    CGPoint obstacleWorld = [obstacle convertToWorldSpace:obstacle.position];
    CGPoint playerWorld = [player convertToWorldSpace: player.position];
    if (obstacleWorld.y >= playerWorld.y - player.boundingBox.size.height && obstacleWorld.y - obstacle.boundingBox.size.height <= playerWorld.y)
    {
        //and the horizontal axis collides
        if (obstacleWorld.x + obstacle.boundingBox.size.width >= playerWorld.x && obstacleWorld.x <= + playerWorld.x + player.boundingBox.size.height)
        {
            rtn = true;//doesCollide
        }
    }
  
    return rtn;
}

-(Boolean) isServing:(int)idxBartender withPlayer:(CCNode*) player
{
    Boolean rtn = false;
    CGPoint playerWorld = [player convertToWorldSpace: player.position];
    int idxPlayer = playerWorld.x;
    //NSLog(@"Player at bar: %d Bartender: %d",idxPlayer,indexBartender);
    //NSLog(@"Player at bar pos: %d Bartender: %d Row: %f %f",idxPlayer/108,idxBartender*2,player.position.y,playerWorld.y);
    if (player.position.y>800 && ((idxPlayer/108)==(idxBartender*2)))
    {
        if (! bBartenderServing)
        {
            NSLog(@"PLAYER %d being Served",(idxPlayer/108)/2);
            rtn= TRUE;
        }
    }
    
    return rtn;
}

-(void) moveObstacles
{
   // NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>>> Move obsticles>>>>>>>>>>>>>>>>>>>");
    //Move the OBSTACLES across the screen
    for (int i = 0; i < self.obstacles.count; i++)
    {
        CCNode *obstacle = nil;
        obstacle = ((Obstacle*)self.obstacles[i]).sprite;
        NSAssert(_gameManager!=nil,@"GameManager is NIL");
        float speed = [_gameManager gameSpeed];
        obstacle.position = ccpSub(obstacle.position, ccp( (!((Obstacle*)self.obstacles[i]).direction==MoveRight)?speed:-speed,0));
   
        //ERROR- this doesn't work- only makes one iteration
//        Obstacle *obstacle = ((Obstacle*)self.obstacles[i]);//.sprite;
//        obstacle.sprite.position = ccpSub(obstacle.sprite.position, ccp( (!obstacle.direction==MoveRight)?kSPEED:-kSPEED,0));

        
        //check for collisions first
        if ([self doesCollide:obstacle withPlayer:_playerNode])
        {
            NSLog(@"++++ COLLIDE ++++++");

            if (self.playerState==TwoBeers)
            {
                //Partical SPLASH!
                NSLog(@"++++ SPLASH 2Beers++++++");
                
                
                [self particleEffect:_playerNode loadCCBName:@"Prefabs/Splash"];

                self.playerState=OneBeer;
                [self updateHUD];
                [self performSelector:@selector(startHustleDown) withObject:nil];
                
                [self performSelector:@selector(pauseGame) withObject:nil];
                [self performSelector:@selector(resetGame) withObject:nil afterDelay:0.5f];
                [self performSelector:@selector(startGame) withObject:nil afterDelay:0.6f];
                
                //[self performSelector:@selector(movePlayerToMedian) withObject:nil afterDelay:1.5f];
                //this is set to false in method movePlayerToMedian
                
                isCollisionInProgress = true;
                
                
                //[NSThread sleepForTimeInterval:0.1f];
            }
            else //if NoBeers or OneBeer- Stop
            {
                NSLog(@"++++ SPLASH ++++++");
                
                [self particleEffect:_playerNode loadCCBName:@"Prefabs/Splash"];
                //changed from above
                [self performSelector:@selector(pauseGame) withObject:nil];
                [self performSelector:@selector(restartSetup) withObject:nil afterDelay:1.5f];
                //removed the promotor from the collection
                [((CCNode*)self.promotors[0]) removeFromParent];
                if (self.promotors.count>0)
                    [self.promotors removeObjectAtIndex:0];
       
                
                [self performSelector:@selector(startGame) withObject:nil afterDelay:1.6f];
            }
            return;
        }
        
        
        
        //check the direction and move the obstacle
        if (((Obstacle*)self.obstacles[i]).direction == MoveLeft)//i%2)
        {
            //Check if they have gone off screen, if they have reposition them
            if (obstacle.position.x < -obstacle.contentSize.width )
            {
                //NSLog(@"Offscreen switch- Move Left-----------------");
                //NSLog(@"Position start: %.2f,%.2f", obstacle.position.x,obstacle.position.y);
                //obstacle.position = ccp(_levelNode.contentSizeInPoints.width+obstacle.contentSize.width+45,obstacle.position.y);
                obstacle.position = ccp(800-obstacle.contentSize.width,obstacle.position.y);
                //NSLog(@"Position start: %.2f,%.2f", obstacle.position.x,obstacle.position.y);
            }
            
        } else {
            //Check if they have gone off screen to the right, if they have reposition them
            if (obstacle.position.x > _levelNode.contentSizeInPoints.width+45 )
            {
                //NSLog(@"Offscreen switch- Move Right-----------------");
                //NSLog(@"Position start: %.2f,%.2f", obstacle.position.x,obstacle.position.y);
                //obstacle.position = ccp(0-obstacle.contentSize.width+45,obstacle.position.y);
                obstacle.position = ccp(-45,obstacle.position.y);
                //NSLog(@"Position start: %.2f,%.2f", obstacle.position.x,obstacle.position.y);
            }
        }
    }
    
    //Calculte scoring, because if this reached, there hasn't been a collision
    if (self.playerMoveState==PlayerUp && self.swiped)
    {
        [self.gameData moveForward:_playerNode.position atSecs:((LevelTimer*)self.timer).seconds hud:self._lblHUDscore];
        //[self.lblHUDscore setString:[NSString stringWithFormat:@"Score: %d", _gameData.GameScore]];
        self.swiped=false;
    }
    else if (self.playerMoveState==PlayerDown && self.playerState==OneBeer && self.swiped)
    {
        [self.gameData moveBack:_playerNode.position atSecs:((LevelTimer*)self.timer).seconds hud:self._lblHUDscore];
        self.swiped=false;
    }
    else if (self.playerMoveState==PlayerDown && self.playerState==TwoBeers && self.swiped)
    {
        [self.gameData moveBack2:_playerNode.position atSecs:((LevelTimer*)self.timer).seconds hud:self._lblHUDscore];
        self.swiped=false;

    }

}



-(void) moveBartender
{
    if (bBartenderServing || (self.playerState == TwoBeers)) return; //stops re-entry issues
    
    //Move the bartender and time his stay
    if (0==cntBartender)  //first pass,
    {

        // generate a real number between 0 and 5 - the number of bars
        int oldIdx = idxBartender;
        //this loop gets a new random Character if it matches the previous Character
        while (idxBartender==oldIdx) {
            idxBartender = (int)(arc4random() % (5*1000)) / 1000.f; //5 is the number of Bars
        }
        
        // generate a random number between kStartOffset and kStopOffset+kStartOffset
        float stay = ((arc4random() % (kStopOffset *1000)) / 1000.f)+ kStartOffset;//kStartOffset is the starting number of secs
        //NSLog(@"Bartender Stay %f", stay);
        
        ttBartender = stay * 60; //60 fps
        
        int point = (72+(105*idxBartender)+1); //72 & 105- magic numbers
        //this gets a random character- no longer used
        //((CCNode*)self.bartenders[idxBartender]).position = CGPointMake( point, ((CCNode*)self.bartenders[idxBartender]).position.y);
        ((CCNode*)self.bartender1).position = CGPointMake( point, ((CCNode*)self.bartender1).position.y);
        
        //if ([self doesCollide:self.bartenders[idxBartender] withPlayer:_playerNode])
        if ([self isServing:idxBartender withPlayer:_playerNode])
        {
            NSLog(@"BARTENDER %d SERVING(1)", idxBartender);
            //calc score
            [self.gameData reachBartender:((LevelTimer*)self.timer).seconds hud:self._lblHUDscore];
            //set state
            [self performSelector:@selector(serve2Beers) withObject:nil];
            bBartenderServing = true;
            [self updateHUD];
            
        }
        
        cntBartender = 1;
        
    }
    else if (cntBartender==ttBartender)
    {
        //TODO - Time still wrong....
        NSLog(@"BARTENDER RESET: Cnt: %d Secs: %d", cntBartender, ttBartender/60);//60fps
        cntBartender = 0;
    }
    else
    {
        //if we know we're already serving, dont check again
        if ([self isServing:idxBartender withPlayer:_playerNode])
        {
            bBartenderServing = true;
            NSLog(@"BARTENDER %d SERVING(2)", idxBartender);
            //calc score
            [self.gameData reachBartender:((LevelTimer*)self.timer).seconds hud:self._lblHUDscore];
            //set state
            [self performSelector:@selector(serve2Beers) withObject:nil];
            [self updateHUD];
             //turn the ligger around
            [self performSelector:@selector(faceHustleDown) withObject:nil  afterDelay:0.5f];
            //reset the bartender- folder arms
            [self performSelector:@selector(nextCustomer) withObject:nil afterDelay:0.6f];
            //forces it restart timer
            cntBartender=0;
        }
        else
           cntBartender += 1;
    }
}

-(void) advancePromotor
{
    
    if (self.promotors.count==0)
    {
        NSLog(@"No more promotors******");
       
        [self gameOver];
        
        
        return;
    }
    
    if (!isPromotorSetupStarted)
    {
        
        [self performSelector:@selector(startAnimation:forSequence:) withObject:((CCNode*)self.promotors[0]) withObject:@"walk"];
        isPromotorSetupStarted = true;
    }
    
    if (((CCNode*)self.promotors[0]).position.x < 250)
    {
        ((CCNode*)self.promotors[0]).position = ccpSub(((CCNode*)self.promotors[0]).position, ccp(-1.0,0));
    }
    else
    {
        [self pauseAnimation:(CCNode*)self.promotors[0]];
        //just face the Ligger Up
        [self performSelector:@selector(faceHustleUp) withObject:nil];
        isPromotorSetupStarted = false;
        self.levelState = PlayGame;
        [((LevelTimer*)_timer) startTimer];
        NSLog(@"Game LevelTimer Started");
    }
}

-(void) completeLevel
{
    if (_playerNode.position.x > 281)
    {
        //move to left
        _playerNode.position = ccpSub(_playerNode.position, ccp(1.0,0));
    }
    else
    {
        //particle explosion?
        //walk the ligger to right
        [self performSelector:@selector(walkRight) withObject:nil];
        //start promotor animation
        [self performSelector:@selector(startAnimation:forSequence:) withObject:((CCNode*)self.promotors[0]) withObject:@"walk"];
        (self.levelState=LevelUp);
        NSLog(@"+++++++START LEVELUP SEQUENCE+++++++");
        //HACK: this is requiref playerState=OneBeer
        [((LevelTimer*)_timer) startTimer];
    }
    
}

-(void) LevelUp
{
    if ( ! ((LevelTimer*)_timer).timerPaused)
    {
        [((LevelTimer*)_timer) pauseTimer];
        NSLog(@"GAME LEVELTIMER PAUSED");
        
        [_gameManager incrementLevelCount];
        
        //this is the perfect plave to calc the Bonus, at the start of the level up
        [self calcBonus];
        
    }
    
    //MOVE THE PROMOTOR AND PLAYER
    _playerNode.position = ccpSub(_playerNode.position, ccp(-1.0,0));
    ((CCNode*)self.promotors[0]).position = ccpSub(((CCNode*)self.promotors[0]).position, ccp(-1.0,0));


    //move the backstage entrance until it gets to its final point
    if (self.bkstage_b.position.x > 498.5)
    {
        self.bkstage_f.position = ccpSub(self.bkstage_f.position, ccp(1.0,0));
        self.bkstage_b.position = ccpSub(self.bkstage_b.position, ccp(1.0,0));
    }
    
    //Check if the promotor has gone off screen
    
    if (((CCNode*)self.promotors[0]).position.x > _levelNode.contentSizeInPoints.width+45)
    {
        NSLog(@"PROMOTOR Offscreen");
                
        [self restartSetup];
        
        //if the promotor has gone offscreen, move his position to the end of the array
        [self StopPromotorWalk];
        CCNode *tmp = ((CCNode*)self.promotors[0]);
        if (self.promotors.count>0)
        {
            [self.promotors removeObjectAtIndex:0];
            [self.promotors addObject:tmp];
        }
        for(int x = 0; x<self.promotors.count;x++)
        {
            ((CCNode*)self.promotors[x]).position = ccp(((self.promotors.count-x)*30)+5,43);
        }
        //end of code to reuse promotors
        
        
        if (_popoverMenuLayer == nil)
        {
            
            //[NSString stringWithFormat:@"%d", intValue]
            //[_popoverMenuLayer initLevelUpScore:[NSString stringWithFormat:@"Score: %d", _gameData.GameScore]];
    
            //get time formatting-NOW for gametimestamp
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            //Optionally for time zone conversions
            [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
            //NOW
            NSString *stringFromDate = [formatter stringFromDate:[NSDate date]];
            //quick hack
            NSAssert(_gameManager!= NULL, @"gameManager is NULL");
            
            ScoreData* scoreData = [[ScoreData alloc] initWithScore:_gameData.GameScore MaxLevel:[_gameManager level] Name:[GameData userName] Date:stringFromDate   GUID:[GameData userID] Device:[GameData deviceID] Remaing:kTOTALTIMER-((LevelTimer*)self.timer).seconds];
//            //isGameOver?
//            [self showPopoverNamed:@"Popups/GameOver"];
            [self showPopoverNamed:@"Popups/LevelScore"];
            [_popoverMenuLayer initWithScoreData:scoreData];


            NSLog(@"+++++++LEVEL SCORE++++++?????: %d", _gameData.GameScore);
            
            [_gameData printLog];
        }
    }
}

-(void) backToMenu
{
    CCScene* scene = [CCBReader loadAsScene:@"MainScene"];
    CCTransition* transition = [CCTransition transitionFadeWithDuration:1.5];
    [[CCDirector sharedDirector] presentScene:scene withTransition:transition];
}

/*
 * removed the current promotor from the collection and
 * then set the state to GameSetup and restarts animations
 */
-(void) restartSetup
{
    self.bkstage_f.position = CGPointMake(645.5f, 82.0f);
    self.bkstage_b.position = CGPointMake(645.5f, 92.5f);
    
//    [((CCNode*)self.promotors[0]) removeFromParent];
//    
//    if (self.promotors.count>0)
//        [self.promotors removeObjectAtIndex:0];
    
    [self performSelector:@selector(faceHustleLeft) withObject:nil];
    //put the Ligger back at the start position
    [self setPlayerAtStart:_playerNode];

    self.playerState=NoBeers;
    [self updateHUD];
    self.levelState = GameSetup;
}


-(void) scrollToTarget:(CCNode*)target
{
    CGSize viewSize = [CCDirector sharedDirector].viewSize;
    CGPoint viewCenter = CGPointMake(viewSize.width / 2.0, viewSize.height / 2.0);
    CGPoint viewPos = ccpSub(target.positionInPoints, viewCenter);
    CGSize levelSize = _levelNode.contentSizeInPoints;
    viewPos.x = MAX(0.0, MIN(viewPos.x, levelSize.width - viewSize.width));
    viewPos.y = MAX(0.0, MIN(viewPos.y, levelSize.height - viewSize.height));
    _levelNode.positionInPoints = ccpNeg(viewPos);
}


- (void)startAnimation:(CCNode*)node forSequence:(NSString*)sequenceName
{
    // the animation manager of each node is stored in the 'animationManager' property
    CCAnimationManager* animationManager = node.animationManager;
    // timelines can be referenced and run by name
    [animationManager runAnimationsForSequenceNamed:sequenceName];
}

- (void)pauseAnimation:(CCNode*)node
{
    // the animation manager of each node is stored in the 'animationManager' property
    CCAnimationManager* animationManager = node.animationManager;
    [animationManager setPaused:YES];
}

//
- (void) particleEffect:(CCNode*)node loadCCBName:(NSString*)particleCCB
{
    // load particle effect
    CCParticleSystem *explosion = (CCParticleSystem *)[CCBReader load:particleCCB];
    NSAssert( explosion != nil, @"Particle Effect must be non-nil");
    // make the particle effect clean itself up, once it is completed
    explosion.autoRemoveOnFinish = TRUE;
    // place the particle effect on the players position
    explosion.position = node.position;
    // add the particle effect to the same node the player is on
    [node.parent addChild:explosion];
}

- (void)serve2Beers
{
    CCAnimationManager* animationManager = _bartender1.animationManager;
    [animationManager runAnimationsForSequenceNamed:@"Serve2Beers"];
    //set the player to 2Beers state
    self.playerState = TwoBeers;
}

- (void) nextCustomer
{
    CCAnimationManager* animationManager = _bartender1.animationManager;
    [animationManager runAnimationsForSequenceNamed:@"empty"];
}

- (void) StopPromotorWalk
{
    CCAnimationManager* animationManager = ((CCNode*)self.promotors[0]).animationManager;
    [animationManager runAnimationsForSequenceNamed:@"empty"];
}

- (void)startHustleRight
{
    self.playerMoveState = PlayerRight;
    self.swiped=false;
    
    //restarts the bartender animation
    if (bBartenderServing)
    {
        bBartenderServing = FALSE;
    }
    
    // the animation manager of each node is stored in the 'animationManager' property
    CCAnimationManager* animationManager = _playerNode.animationManager;
    // timelines can be referenced and run by name
    switch (self.playerState) {
        case TwoBeers:
            [animationManager runAnimationsForSequenceNamed:@"HustleRight-2Beers"];
            break;
        case OneBeer:
            [animationManager runAnimationsForSequenceNamed:@"HustleRight-1Beer"];
            break;
        default: //NoBeers
            [animationManager runAnimationsForSequenceNamed:@"HustleRight"];
            break;
    }

}

- (void)walkRight
{
    
    // the animation manager of each node is stored in the 'animationManager' property
    CCAnimationManager* animationManager = _playerNode.animationManager;
    // timelines can be referenced and run by name
    switch (self.playerState) {
        case TwoBeers:
            [animationManager runAnimationsForSequenceNamed:@"WalkRight-2Beers"];
            break;
        case OneBeer:
            [animationManager runAnimationsForSequenceNamed:@"WalkRight-1Beer"];
            break;
        case NoBeers://should never get here
            break;
    }
    
}

- (void)startHustleLeft
{
    self.playerMoveState = PlayerLeft;
    self.swiped=false;
    
    //restarts the bartender animation
    if (bBartenderServing)
    {
        bBartenderServing = FALSE;
    }
    
    // the animation manager of each node is stored in the 'animationManager' property
    CCAnimationManager* animationManager = _playerNode.animationManager;
    // timelines can be referenced and run by name
    switch (self.playerState) {
        case TwoBeers:
            [animationManager runAnimationsForSequenceNamed:@"HustleLeft-2Beers"];
            break;
        case OneBeer:
            [animationManager runAnimationsForSequenceNamed:@"HustleLeft-1Beer"];
            break;
        default: //NoBeers
            [animationManager runAnimationsForSequenceNamed:@"HustleLeft"];
            break;
    }
}

- (void)startHustleUp
{
    self.playerMoveState = PlayerUp;
    self.moveLength = 64;//kVERTICALMOVE;
    
    // the animation manager of each node is stored in the 'animationManager' property
    CCAnimationManager* animationManager = _playerNode.animationManager;
    switch (self.playerState) {
        case TwoBeers:
            [animationManager runAnimationsForSequenceNamed:@"HustleUp-2Beers"];
             self.swiped=false;
            break;
        case OneBeer:
            [animationManager runAnimationsForSequenceNamed:@"HustleUp-1Beer"];
             self.swiped=false;
            break;
        default: //NoBeers
            [animationManager runAnimationsForSequenceNamed:@"HustleUp"];
             self.swiped=true;
            break;
    }
    
}

/*
 * Face the Ligger Left with NoBeers
 */
- (void)faceHustleLeft
{
    // the animation manager of each node is stored in the 'animationManager' property
    CCAnimationManager* animationManager = _playerNode.animationManager;

   [animationManager runAnimationsForSequenceNamed:@"empty"];
}


/*
 * Face the Ligger Left with NoBeers
 */
- (void)faceHustleUp
{
    // the animation manager of each node is stored in the 'animationManager' property
    CCAnimationManager* animationManager = _playerNode.animationManager;
    
    [animationManager runAnimationsForSequenceNamed:@"FaceUp"];
}



/*
 * Face the Ligger Down(front) with TwoBeers
 */
- (void)faceHustleDown
{
    // the animation manager of each node is stored in the 'animationManager' property
    CCAnimationManager* animationManager = _playerNode.animationManager;
    
    [animationManager runAnimationsForSequenceNamed:@"FaceDown2"];
}


- (void)startHustleDown
{
    self.playerMoveState = PlayerDown;
    
    //restarts the bartender animation
    if (bBartenderServing)
    {
        bBartenderServing = FALSE;
    }
    
    // the animation manager of each node is stored in the 'animationManager' property
    CCAnimationManager* animationManager = _playerNode.animationManager;
    // timelines can be referenced and run by name
    switch (self.playerState) {
        case TwoBeers:
            [animationManager runAnimationsForSequenceNamed:@"HustleDown-2Beers"];
            self.swiped=true;
            break;
        case OneBeer:
            [animationManager runAnimationsForSequenceNamed:@"HustleDown-1Beer"];
            self.swiped=true;
            break;
        default: //NoBeers
            [animationManager runAnimationsForSequenceNamed:@"HustleDown"];
            self.swiped=false;
            break;
    }
}

//moves and animated the character
-(void)handleSwipeGesture:(UISwipeGestureRecognizer *) sender
{
    if (GameScene.halt) return;
    
    switch( sender.direction ) {
        case UISwipeGestureRecognizerDirectionUp:
            [self goUp];
            break;
        case UISwipeGestureRecognizerDirectionDown:
            [self goDown];
            break;
        case UISwipeGestureRecognizerDirectionLeft:
            [self goLeft];
            break;
        case UISwipeGestureRecognizerDirectionRight:
            [self goRight];
            break;
    }
    
}


////////these methods are called by the arrow keys and by the swipe methods- depending upon which is used
-(void) goUp
{
    NSLog(@"goUp");
    if (self.levelState==PlayGame)
    {
        if ((_playerNode.position.y) < kBOARDTOPBOUND) //keeps with top boundry
        {
            _playerNode.position = CGPointMake(_playerNode.position.x,_playerNode.position.y+kVERTICALMOVE);
            [self performSelector:@selector(startHustleUp) withObject:nil];
        }
    }
}
-(void) goDown
{
    NSLog(@"goDown");

    if (self.levelState==PlayGame)
    {
        if ((_playerNode.position.y) > kBOARDBOTTOMBOUND ) //keeps with bottom boundry
        {
            NSLog(@"Player Row: %f Column: %f",_playerNode.position.y, _playerNode.position.x);
            //dont let the Ligger enter the Promotor area
            //TODO: make constants
            if (_playerNode.position.y < 113 && (_playerNode.position.x < 229|| _playerNode.position.x > 436))
                return;
            
            _playerNode.position = CGPointMake(_playerNode.position.x,_playerNode.position.y-kVERTICALMOVE);
            [self performSelector:@selector(startHustleDown) withObject:nil];
            
            //if we move away from the bar, right, left or down, reset the bartender
            
            //if we get back to the promotors area with a beers or two, we're done
            if (_playerNode.position.y < 110 && self.playerState != NoBeers)
            {
                NSLog(@"+++++++LEVEL COMPLETED+++++++");
                self.levelState=CompleteLevel;
                
                [self performSelector:@selector(startHustleLeft) withObject:nil];
                
            } else {
                NSLog(@"NOT COMPLETED LEVEL, Y: %f PlayerState: %d",_playerNode.position.y,self.playerState != NoBeers);
            }
        }
    }

}
-(void) goLeft
{
    NSLog(@"goLeft");
    if (self.levelState==PlayGame)
    {
        if ((_playerNode.position.x) > kBOARDLEFTBOUND) //keeps with left boundry
        {
            NSLog(@"Player Row: %f Column: %f",_playerNode.position.y, _playerNode.position.x);
            //dont let the Ligger enter the Promotor area
            //TODO- CONSTANTS!!
            if (_playerNode.position.y < 49 && _playerNode.position.x < 281)
                return;
            
            _playerNode.position = CGPointMake(_playerNode.position.x-kHORIZONTALMOVE,_playerNode.position.y);
            [self performSelector:@selector(startHustleLeft) withObject:nil];
        }
    }
}
-(void) goRight
{
    NSLog(@"goRight");
    if (self.levelState==PlayGame)
    {
        
        if ((_playerNode.position.x) < kBOARDRIGHTBOUND) //keeps with right boundry
        {
            if (_playerNode.position.y < 49 && _playerNode.position.x > 384)
                return;
            
            NSLog(@"Player Row: %f Column: %f",_playerNode.position.y, _playerNode.position.x);
            _playerNode.position = CGPointMake(_playerNode.position.x+kHORIZONTALMOVE,_playerNode.position.y);
            [self performSelector:@selector(startHustleRight) withObject:nil];
        }
    }
}
/////////////////////////////////////////////////////////////////////


-(void) startGame
{
    //NSLog(@"PLAYER START POS- x:%f y:%f Numb obstabcle: %lu",_playerNode.position.x,_playerNode.position.y,(unsigned long)self.obstacles.count);
    
    GameScene.halt = false;
    
    //[_gameData reset];

    NSLog(@"ANIMATION STARTED");
    
    //_levelNode.paused=false;
    
    for (int i = 0; i < self.obstacles.count; i++)
    {
        [self performSelector:@selector(startAnimation:forSequence:) withObject:((Obstacle*)self.obstacles[i]).sprite withObject:@"default"];
    }
}


-(void) pauseGame //:(CCNode*) obstacle
{
    GameScene.halt = true;
    
    [self.timer pauseTimer];
    
    //_levelNode.paused=true;

//
//    [self performSelector:@selector(pauseAnimation:) withObject:self.bartender1];
//    
//    for (int i = 0; i < self.obstacles.count; i++)
//    {
//        [self performSelector:@selector(pauseAnimation:) withObject:(CCNode*)self.obstacles[i]];
//    }

}


//TODO: Make ResetRow as an alternative, with Obstacle or row as arg?
/*
 * Reset the obstacles to the Game Start position
 */
-(void) resetGame //:(CCNode*) obstacle
{

    NSLog(@"GameScene::resetGame");
    for (int i = 0; i < self.obstacles.count; i++)
    {
        [((Obstacle*)self.obstacles[i]) resetToStart];
        
    }
    
    GameScene.halt = false;
    isCollisionInProgress = false;
}



-(void) showPopoverNamed:(NSString*)name
{
    NSLog(@"GameScene::showPopoverNamed: %@", name);
    if (_popoverMenuLayer == nil)
    {
        //PopupLayer* newMenuLayer
        _popoverMenuLayer = (PopupLayer*)[CCBReader load:name];
        NSAssert(_popoverMenuLayer!=nil, @"PopupLayer in showPopoverNamed is Nil");
        [self addChild:_popoverMenuLayer];
        //_popoverMenuLayer = newMenuLayer;
        _popoverMenuLayer.parent = self;
        GameScene.halt=true;
        _levelNode.paused = YES;
    }
}

-(void) removePopover
{
    if (_popoverMenuLayer)
    {
        NSLog(@"GameScene::removePopover");
        _popoverMenuLayer.visible = YES;
        [_popoverMenuLayer removeFromParent];
        _popoverMenuLayer = nil;
        _levelNode.paused = NO;
        GameScene.halt = false;
        NSLog(@"Completed Popup removal");
    }
    else
    {
        NSLog(@"Unable to remove Popup");
    }
}

//-(void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
//{
//    _playerNode.position = [touch locationInNode:self];
//}

@end
