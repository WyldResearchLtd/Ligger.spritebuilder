//
//  Obstacle.m
//  Ligger
//
//  Created by Gene Myers on 11/06/2015.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Obstacle.h"

@implementation Obstacle


-(id) initWithDirection:(ObstacleDirection) direction forSprite:(CCNode*) sprite
{
    if ( self = [super init] ) {
        
        _direction = direction;
        _sprite = sprite;
    }
    return self;
}

-(id) initWithDirection:(ObstacleDirection) direction forSprite:(CCNode*) sprite atPosition:(CGPoint) position
{
    if ( self = [super init] ) {
        
        _direction = direction;
        _sprite = (Obstacle*)sprite;
        _sprite.position = position;
    }
    return self;
}

@end
