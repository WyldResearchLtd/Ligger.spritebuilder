//
//  LeaderboardLayer.m
//  Ligger
//
//  Created by Gene Myers on 01/07/2015.
//  Copyright (c) 2015 Fezzee. All rights reserved.
//

#import "LeaderboardLayer.h"
#import "MainScene.h"
#import "ScoreData.h"
#import "GameData.h"

@implementation LeaderboardLayer

-(void) btnBack
{
    NSLog(@"Back(btn) Choosen");
    [((MainScene*)self.parent) removePopover];
}

-(id) setPersonalBest:(NSDictionary*) best
{
    NSLog(@">>>>>> LeaderboardLayer::initWithPersonalBest: %lu >>>>>>",(unsigned long)best.count);
    self.bestPersonal=best;
    [self fetchLeaders];
    return self;
}

-(void) didLoadFromCCB
{
    NSLog(@"±±±±±±±±± Leaderboard didLoadFromCCB");
}

-(void) onEnter
{
    [super onEnter];
    NSLog(@"§§§§§§§§§ Leaderboard onEnter");
    
    
    //[self fetchLeaders];
    
}

- (void)fetchLeaders;
{
    @try {

  
        //First fetch new values
        NSURL *url = [NSURL URLWithString:@"http://ligger-api.fezzee.net"];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
        
//        NSURLResponse * response = nil;
//        NSError * connectionError = nil;
//        NSData * data = [NSURLConnection sendSynchronousRequest:request
//                                              returningResponse:&response
//                                                          error:&connectionError];
        {
             if (data.length > 0 && connectionError == nil)
             {
                 NSArray *leaders = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:0
                                                                            error:NULL];
                  NSLog(@"Polulate plist here!");
                 NSMutableDictionary* _settings = [GameData getGameSettings];
                 //write to plist if
                 for (int i = 0; i < 3; i++) //hardcoded 3 because each of the three state behaviors are hardcoded
                 {
                     
                     NSDictionary* dict = leaders.count>i?leaders[i]:[[NSDictionary alloc]init];
                     switch(i)
                     {
                         case 0:
                             [_settings setObject:dict forKey:@"LeaderA"];
                             break;
                         case 1:
                             [_settings setObject:dict forKey:@"LeaderB"];
                             break;
                         case 2:
                             [_settings setObject:dict forKey:@"LeaderC"];
                             break;
                         default:
                             break;
                     }
                 }
                 [GameData saveGameSettings:_settings];
                 NSLog(@"LeaderBoard::fetchLeaders updated Plist with Leaders");
                 
                 //Last, populate with newly saved values
                 [self refreshBoard];
                 self._lblStatus.string = @"Update Complete";
             }
            else
            {
                 NSLog(@"CONNECTION == nil OR Data empty");
                 self._lblStatus.string = @"Unable to Update";
            }
         }
        ];//comment this out for SynchronousRequest
    }
    @catch (NSException * e) {
            self._lblStatus.string = @"Update Error";
            NSLog(@"Exception: %@", e);
            NSLog(@"%@",[NSThread callStackSymbols]);
    }
    @finally {
          //[self refreshBoard];
    }
    
}




-(void) refreshBoard
{

    @try
    {
        //[self fetchLeaders];
        
        NSLog(@"refreshBoard");
        
        NSDictionary* best1 = [self.bestPersonal objectForKey:@"Best-1"];
        NSDictionary* best2 = [self.bestPersonal objectForKey:@"Best-2"];
        NSDictionary* best3 = [self.bestPersonal objectForKey:@"Best-3"];
        
        __row4name.string =  [((NSDictionary*)best1) objectForKey:@"scoreName"]==nil?@"":[((NSDictionary*)best1) objectForKey:@"scoreName"];
        __row4date.string =  [((NSDictionary*)best1) objectForKey:@"scoreDate"]==nil?@"":[((NSDictionary*)best1) objectForKey:@"scoreDate"];
        __row4score.string = [((NSDictionary*)best1) objectForKey:@"scoreValue"]==nil?@"":[[((NSDictionary*)best1) objectForKey:@"scoreValue"] stringValue];
        __row4levels.string =[((NSDictionary*)best1) objectForKey:@"scoreLevel"]==nil?@"":[[((NSDictionary*)best1) objectForKey:@"scoreLevel"] stringValue];
        
        __row5name.string =  [((NSDictionary*)best2) objectForKey:@"scoreName"]==nil?@"":[((NSDictionary*)best2) objectForKey:@"scoreName"];
        __row5date.string =  [((NSDictionary*)best2) objectForKey:@"scoreDate"]==nil?@"":[((NSDictionary*)best2) objectForKey:@"scoreDate"];
        __row5score.string = [((NSDictionary*)best2) objectForKey:@"scoreValue"]==nil?@"":[[((NSDictionary*)best2) objectForKey:@"scoreValue"] stringValue];
        __row5levels.string =[((NSDictionary*)best2) objectForKey:@"scoreLevel"]==nil?@"":[[((NSDictionary*)best2) objectForKey:@"scoreLevel"] stringValue];
        
        __row6name.string =  [((NSDictionary*)best3) objectForKey:@"scoreName"]==nil?@"":[((NSDictionary*)best3) objectForKey:@"scoreName"];
        __row6date.string =  [((NSDictionary*)best3) objectForKey:@"scoreDate"]==nil?@"":[((NSDictionary*)best3) objectForKey:@"scoreDate"];
        __row6score.string = [((NSDictionary*)best3) objectForKey:@"scoreValue"]==nil?@"":[[((NSDictionary*)best3) objectForKey:@"scoreValue"] stringValue];
        __row6levels.string =[((NSDictionary*)best3) objectForKey:@"scoreLevel"]==nil?@"":[[((NSDictionary*)best3) objectForKey:@"scoreLevel"] stringValue];
        
        
        /////////////////////////////////////////////////////////////////////////////
        
        NSMutableDictionary* _settings = [GameData getGameSettings];
        NSDictionary* leaderA = [_settings objectForKey:@"LeaderA"];
        NSDictionary* leaderB = [_settings objectForKey:@"LeaderB"];
        NSDictionary* leaderC = [_settings objectForKey:@"LeaderC"];
       
        if (leaderA.count>0)
        {
        __row1name.string = [((NSDictionary*)leaderA) objectForKey:@"name"]==nil?@"":[((NSDictionary*)leaderA) objectForKey:@"name"];
        __row1date.string = [((NSDictionary*)leaderA) objectForKey:@"datetime"]==nil?@"":[((NSDictionary*)leaderA) objectForKey:@"datetime"];
        __row1score.string = [[((NSDictionary*)leaderA) objectForKey:@"score"]==nil?@"":[((NSDictionary*)leaderA) objectForKey:@"score"] stringValue];
        __row1levels.string = [[((NSDictionary*)leaderA) objectForKey:@"level"]==nil?@"":[((NSDictionary*)leaderA) objectForKey:@"level"] stringValue];
        }
        
        if (leaderB.count>0)
        {
        __row2name.string = [((NSDictionary*)leaderB) objectForKey:@"name"]==nil?@"":[((NSDictionary*)leaderB) objectForKey:@"name"];
        __row2date.string = [((NSDictionary*)leaderB) objectForKey:@"datetime"]==nil?@"":[((NSDictionary*)leaderB) objectForKey:@"datetime"];
        __row2score.string = [[((NSDictionary*)leaderB) objectForKey:@"score"]==nil?@"":[((NSDictionary*)leaderB) objectForKey:@"score"] stringValue];
        __row2levels.string = [[((NSDictionary*)leaderB) objectForKey:@"level"]==nil?@"":[((NSDictionary*)leaderB) objectForKey:@"level"] stringValue];
        }
        
        if (leaderC.count>0)
        {
        __row3name.string = [((NSDictionary*)leaderC) objectForKey:@"name"]==nil?@"":[((NSDictionary*)leaderC) objectForKey:@"name"];
        __row3date.string = [((NSDictionary*)leaderC) objectForKey:@"datetime"]==nil?@"":[((NSDictionary*)leaderC) objectForKey:@"datetime"];
        __row3score.string = [[((NSDictionary*)leaderC) objectForKey:@"score"]==nil?@"":[((NSDictionary*)leaderC) objectForKey:@"score"] stringValue];
        __row3levels.string = [[((NSDictionary*)leaderC) objectForKey:@"level"]==nil?@"":[((NSDictionary*)leaderC) objectForKey:@"level"] stringValue];
        }
        
        ///////////////////////////////////////////////////////////////////////////////

  
    }
    @catch (NSException * e) {
        NSLog(@">> Exception: %@", e);
        NSLog(@"%@",[NSThread callStackSymbols]);
    }
}

@end
