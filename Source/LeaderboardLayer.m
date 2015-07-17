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

@implementation LeaderboardLayer

-(void) btnBack
{
    NSLog(@"Back(btn) Choosen");
    [((MainScene*)self.parent) removePopover];
}

#warning In Progress
-(id) setPersonalBest:(NSDictionary*) best
{
//    if((self=[super init]))
//    {
        NSLog(@">>>>>> LeaderboardLayer::initWithPersonalBest: %lu >>>>>>",(unsigned long)best.count);
        self.bestPersonal=best;
//    }
    return self;
}

-(void) onEnter
{
    [super onEnter];
    NSLog(@"Leaderboard onEnter");
    __ScoresDatum = [NSArray arrayWithObjects:  [[ScoreData alloc]initWithScore:10320 MaxLevel:[NSNumber numberWithInt:6] Name:@"MajesticPotato"  Date:@"23 Jun 2015 13:23" GUID:@"KJ67GFD" Device:@"ABC"
                                                    Remaing:5],
                                                [[ScoreData alloc]initWithScore: 10070 MaxLevel:[NSNumber numberWithInt:4] Name:@"SarahN" Date:@"24 Jun 2015 11:53" GUID:@"YJ67GFD" Device:@"ABC" Remaing:5],
                                                [[ScoreData alloc]initWithScore: 9910 MaxLevel:[NSNumber numberWithInt:5] Name:@"GinjaNinga" Date:@"24 Jun 2015 13:23" GUID:@"HJ67GFD" Device:@"ABC" Remaing:5],
//                                                [[ScoreData alloc]initWithScore: 9090 MaxLevel:[NSNumber numberWithInt:10] Name:@"Test Name4" Date:@"24 Jun 2015 16:53" GUID:@"6J67GFD" Device:@"ABC" Remaing:5],
//                                                [[ScoreData alloc]initWithScore:10720 MaxLevel:[NSNumber numberWithInt:11] Name:@"Test Name5" Date:@"25 Jun 2015 13:23" GUID:@"KJ67GFD" Device:@"ABC" Remaing:5],
//                                                [[ScoreData alloc]initWithScore: 7390 MaxLevel:[NSNumber numberWithInt:10] Name:@"Test Name6" Date:@"26 Jun 2015 11:53" GUID:@"0J67GFD" Device:@"ABC" Remaing:5],
                                                nil];
    NSLog(@"Demo data init: num objects: %lu", (unsigned long)__ScoresDatum.count);
    
}


-(void) refreshBoard
{

    @try {
        
        NSLog(@"refreshBoard");
   
    __row1name.string = ((ScoreData*)__ScoresDatum[0]).scoreName;
    __row1date.string = ((ScoreData*)__ScoresDatum[0]).scoreDate;
    __row1score.string = [((ScoreData*)__ScoresDatum[0]).scoreValue stringValue];
    __row1levels.string = [((ScoreData*)__ScoresDatum[0]).scoreLevel stringValue];
    
    __row2name.string = ((ScoreData*)__ScoresDatum[1]).scoreName;
    __row2date.string = ((ScoreData*)__ScoresDatum[1]).scoreDate;
    __row2score.string = [((ScoreData*)__ScoresDatum[1]).scoreValue stringValue];
    __row2levels.string = [((ScoreData*)__ScoresDatum[1]).scoreLevel stringValue];
    
    __row3name.string = ((ScoreData*)__ScoresDatum[2]).scoreName;
    __row3date.string = ((ScoreData*)__ScoresDatum[2]).scoreDate;
    __row3score.string = [((ScoreData*)__ScoresDatum[2]).scoreValue stringValue];
    __row3levels.string = [((ScoreData*)__ScoresDatum[2]).scoreLevel stringValue];
    
    ///////////////////////////////////////////////////////////////////////////////
        NSDictionary* best1 = [self.bestPersonal objectForKey:@"Best-1"];
        NSDictionary* best2 = [self.bestPersonal objectForKey:@"Best-2"];
        NSDictionary* best3 = [self.bestPersonal objectForKey:@"Best-3"];
        
    __row4name.string =  [((NSDictionary*)best1) objectForKey:@"scoreName"]==nil?@"":[[((NSDictionary*)best1) objectForKey:@"scoreName"] stringValue];
    __row4date.string =  [((NSDictionary*)best1) objectForKey:@"scoreDate"]==nil?@"":[[((NSDictionary*)best1) objectForKey:@"scoreDate"] stringValue];
    __row4score.string = [((NSDictionary*)best1) objectForKey:@"scoreValue"]==nil?@"":[[((NSDictionary*)best1) objectForKey:@"scoreValue"] stringValue];
    __row4levels.string =[((NSDictionary*)best1) objectForKey:@"scoreLevel"]==nil?@"":[[((NSDictionary*)best1) objectForKey:@"scoreLevel"] stringValue];
        
    __row5name.string =  [((NSDictionary*)best2) objectForKey:@"scoreName"]==nil?@"":[[((NSDictionary*)best2) objectForKey:@"scoreName"] stringValue];
    __row5date.string =  [((NSDictionary*)best2) objectForKey:@"scoreDate"]==nil?@"":[[((NSDictionary*)best2) objectForKey:@"scoreDate"] stringValue];
    __row5score.string = [((NSDictionary*)best2) objectForKey:@"scoreValue"]==nil?@"":[[((NSDictionary*)best2) objectForKey:@"scoreValue"] stringValue];
    __row5levels.string =[((NSDictionary*)best2) objectForKey:@"scoreLevel"]==nil?@"":[[((NSDictionary*)best2) objectForKey:@"scoreLevel"] stringValue];
    
    __row6name.string =  [((NSDictionary*)best3) objectForKey:@"scoreName"]==nil?@"":[[((NSDictionary*)best3) objectForKey:@"scoreName"] stringValue];
    __row6date.string =  [((NSDictionary*)best3) objectForKey:@"scoreDate"]==nil?@"":[[((NSDictionary*)best3) objectForKey:@"scoreDate"] stringValue];
    __row6score.string = [((NSDictionary*)best3) objectForKey:@"scoreValue"]==nil?@"":[[((NSDictionary*)best3) objectForKey:@"scoreValue"] stringValue];
    __row6levels.string =[((NSDictionary*)best3) objectForKey:@"scoreLevel"]==nil?@"":[[((NSDictionary*)best3) objectForKey:@"scoreLevel"] stringValue];
   

        
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        NSLog(@"%@",[NSThread callStackSymbols]);
    }

}

@end
