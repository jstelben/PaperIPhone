//
//  MovingObject.h
//  ProtoBoard
//
//  Created by John Stelben on 11/9/13.
//  Copyright (c) 2013 Nathan Burgers. All rights reserved.
//

#import "GameObject.h"

@interface MovingObject : GameObject
{
    @public
    Vector* Velocity;
    Vector* Acceleration;
}
-(id) initX: (float)x initY: (float)y;
-(void) UpdateFalling:(NSTimeInterval)elapsed;
-(void) BounceOffWalls;
-(void) HitCeiling;
-(bool) HitBottom;
-(void) BounceOffPoint: (CGPoint)point kickBack:(float)kick;
@end
