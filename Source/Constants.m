//
//  Constants.m
//  Ligger
//
//  Created by Gene Myers on 18/06/2015.
//  Copyright (c) 2015 Fezzee Ltd. All rights reserved.
//

//#import <Foundation/Foundation.h>

const bool EASYPASS = false; //used to make it easy to level up
const bool TESTUTILS = false; //used to make it test options available- delete plist- it will automatically turn on in simulator- not as useful as it was.
const bool VERBOSE_CONSOLE = false; //turns printLog and logging settings, on and off

const int kPROMOTORS = 4; //number of promotors
const int kTOTALTIMER = 122; //Total Timer Seconds

const int kBOARDTOPBOUND = 800;
const int kBOARDBOTTOMBOUND = 50;
const int kBOARDLEFTBOUND = 100;
const int kBOARDRIGHTBOUND = 450;

const int kHORIZONTALMOVE = 52;
const int kVERTICALMOVE = 64;

const int kStartOffset = 4;
const int kStopOffset = 3;

const int kMAXUSERNAMELENGTH = 10;

//const float kSPEED = 1.5 ;//3.5;3.0;2.5;
//const int kMedianStripRow = 432;

NSString *const WEBSERVURL = @"http://ligger-api.fezzee.net";  //@"http://127.0.0.1:5433"; //
NSString *const SHAREDSECRET = @"608169da637a58ac0bff23895b58f8de5ef982a5a30f5477e2fdea27c5bdef8d5b0b13bfc8c2c77c";