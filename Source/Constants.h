//
//  Constants.h
//  Ligger
//
//  Created by Gene Myers on 19/04/2015.
//  Copyright (c) 2015 Fezzee Limited. All rights reserved.
//

#ifndef Ligger_Constants_h
#define Ligger_Constants_h


typedef enum PlayerState {NoBeers, TwoBeers, OneBeer} PlayerState;
typedef enum LevelState {GameSetup, PlayGame, LevelUp} LevelState;


const int kBOARDTOPBOUND = 800;
const int kBOARDBOTTOMBOUND = 50;
const int kBOARDLEFTBOUND = 100;
const int kBOARDRIGHTBOUND = 450;
const int kHORIZONTALMOVE = 52;
const int kVERTICALMOVE = 64;
const int kMedianStripRow = 432;

const int kStartOffset = 4;
const int kStopOffset = 3;

#endif
