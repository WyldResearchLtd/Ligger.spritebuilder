//
//  Obstacle.h
//  Ligger
//
//  Created by Gene Myers on 11/06/2015.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "CCNode.h"
#import "Constants.h"

@interface Obstacle : CCNode
{
    
}

@property (nonatomic) ObstacleDirection direction;
@property (nonatomic) CCNode* sprite;

@end
