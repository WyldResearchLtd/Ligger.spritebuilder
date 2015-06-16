//
//  Constants.h
//  Ligger
//
//  Created by Gene Myers on 19/04/2015.
//  Copyright (c) 2015 Fezzee Limited. All rights reserved.
//

#ifndef Ligger_Constants_h
#define Ligger_Constants_h


typedef enum PlayerMoveState {PlayerUp, PlayerDown, PlayerLeft, PlayerRight} PlayerMoveState;
typedef enum PlayerState {NoBeers, TwoBeers, OneBeer} PlayerState;
typedef enum LevelState {GameSetup, PlayGame, CompleteLevel, LevelUp} LevelState;
typedef enum ObstacleDirection {MoveLeft,MoveRight} ObstacleDirection;

const bool EASYPASS = true; //used to make it easy to level up

const int kPROMOTORS = 4; //number of promotors
const int kTOTALTIMER = 59; //Total Timer Seconds

const int kBOARDTOPBOUND = 800;
const int kBOARDBOTTOMBOUND = 50;
const int kBOARDLEFTBOUND = 100;
const int kBOARDRIGHTBOUND = 450;

const int kHORIZONTALMOVE = 52;
const int kVERTICALMOVE = 64;

//const int kMedianStripRow = 432;

const int kStartOffset = 4;
const int kStopOffset = 3;

const float kSPEED = 2.5;//3.5;3.0;2.5;

#endif
