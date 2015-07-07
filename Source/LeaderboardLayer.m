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

-(void) onEnter
{
    [super onEnter];
    NSLog(@"Leaderboard onEnter");
    __ScoresDatum = [NSArray arrayWithObjects:  [[ScoreData alloc]initWithScore:10020 MaxLevel:11 Name:@"Test Name"  Date:@"23 Jun 2015 13:23" GUID:@"KJ67GFD"],
                                                [[ScoreData alloc]initWithScore: 6090 MaxLevel:10 Name:@"Test Name2" Date:@"24 Jun 2015 11:53" GUID:@"YJ67GFD"],
                                                [[ScoreData alloc]initWithScore:10320 MaxLevel:11 Name:@"Test Name3" Date:@"24 Jun 2015 13:23" GUID:@"HJ67GFD"],
                                                [[ScoreData alloc]initWithScore: 9090 MaxLevel:10 Name:@"Test Name4" Date:@"24 Jun 2015 16:53" GUID:@"6J67GFD"],
                                                [[ScoreData alloc]initWithScore:10720 MaxLevel:11 Name:@"Test Name5" Date:@"25 Jun 2015 13:23" GUID:@"KJ67GFD"],
                                                [[ScoreData alloc]initWithScore: 7390 MaxLevel:10 Name:@"Test Name6" Date:@"26 Jun 2015 11:53" GUID:@"0J67GFD"],
                                                nil];
    NSLog(@"Demo data init: num objects: %lul", (unsigned long)__ScoresDatum.count);
    [self refreshBoard];
}


-(void) refreshBoard
{

    @try {
   
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
    
    __row4name.string = ((ScoreData*)__ScoresDatum[3]).scoreName;
    __row4date.string = ((ScoreData*)__ScoresDatum[3]).scoreDate;
    __row4score.string = [((ScoreData*)__ScoresDatum[3]).scoreValue stringValue];
    __row4levels.string = [((ScoreData*)__ScoresDatum[3]).scoreLevel stringValue];
    
    __row5name.string = ((ScoreData*)__ScoresDatum[4]).scoreName;
    __row5date.string = ((ScoreData*)__ScoresDatum[4]).scoreDate;
    __row5score.string = [((ScoreData*)__ScoresDatum[4]).scoreValue stringValue];
    __row5levels.string = [((ScoreData*)__ScoresDatum[4]).scoreLevel stringValue];
    
    __row6name.string = ((ScoreData*)__ScoresDatum[5]).scoreName;
    __row6date.string = ((ScoreData*)__ScoresDatum[5]).scoreDate;
    __row6score.string = [((ScoreData*)__ScoresDatum[5]).scoreValue stringValue];
    __row6levels.string = [((ScoreData*)__ScoresDatum[5]).scoreLevel stringValue];
   

        
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        NSLog(@"%@",[NSThread callStackSymbols]);
    }

}

@end
