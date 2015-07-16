//
//  Obstacle.h
//  Ligger
//
//  Created by Gene Myers on 11/06/2015.
//  Copyright (c) 2015 Fezzee. All rights reserved.
//

#import "CCNode.h"
#import "Constants.h"

@interface Obstacle : CCNode <NSCopying>
{
    
}


@property (nonatomic,strong) CCNode* sprite;
@property (nonatomic) ObstacleDirection direction;
@property (nonatomic) CGPoint startPos;


//-(id) initWithDirection:(ObstacleDirection) direction forSprite:(CCNode*) sprite;
-(id) initWithDirection:(ObstacleDirection) direction forSprite:(CCNode*) sprite atStartPosition:(CGPoint) position;
-(void) resetToStart;

@end
