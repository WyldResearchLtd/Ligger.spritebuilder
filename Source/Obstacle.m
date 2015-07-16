//
//  Obstacle.m
//  Ligger
//
//  Created by Gene Myers on 11/06/2015.
//  Copyright (c) 2015 Fezzee. All rights reserved.
//

#import "Obstacle.h"

@implementation Obstacle


-(id)copyWithZone:(NSZone *)zone
{
    // We'll ignore the zone for now
    Obstacle *another = [[Obstacle alloc] init];
    another.sprite = self.sprite;
    another.direction = self.direction;
    another.startPos = self.startPos;
    
    return another;
}

//-(id) initWithDirection:(ObstacleDirection) direction forSprite:(CCNode*) sprite
//{
//    if ( self = [super init] ) {
//        
//        _direction = direction;
//        _sprite = sprite;
//    }
//    return self;
//}

-(id) initWithDirection:(ObstacleDirection) direction forSprite:(CCNode*) sprite atStartPosition:(CGPoint) position
{
    if ( self = [super init] ) {
        
        _direction = direction;
        _sprite = (Obstacle*)sprite;
        //_sprite.position = position;
        _startPos = position;
    }
    return self;
}

-(void) resetToStart
{
    _sprite.position = _startPos;
}

@end
