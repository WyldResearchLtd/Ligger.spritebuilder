//
//  Obstacle.h
//  Ligger
//
//  Created by Gene Myers on 11/06/2015.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "CCSprite.h"
#import "Constants.h"

@interface Obstacle : CCSprite
{
    int _direction;
}
@property int direction;  //0 left, 1 right
@end
