//
//  MovingObject.m
//  ProtoBoard
//
//  Created by John Stelben on 11/9/13.
//  Copyright (c) 2013 Nathan Burgers. All rights reserved.
//

#import "MovingObject.h"

@implementation MovingObject
-(id)init
{
    self = [super init];
    if(self)
    {
        Velocity = [[Vector alloc] init];
        Acceleration = [[Vector alloc] init];
    }
    return self;
}
-(id) initX:(float)x initY:(float)y
{
    self = [super initX:x initY:y initW:20 initH:20];
    if(self)
    {
        Velocity = [[Vector alloc] init];
        Acceleration = [[Vector alloc] init];
        ImageView.image = [UIImage imageNamed:@"../RedCircle.jpg"];
    }
    return self;
}
-(void) UpdateFalling:(NSTimeInterval)elapsed
{
    Acceleration->Y += (elapsed/20);
    Vector* tempAccel = [Acceleration Multiply:elapsed];
    [Velocity Add:tempAccel];
    Vector* tempVel = [Velocity Multiply:elapsed];
    [Position Add:tempVel];
    //NSLog(@"X:%f  Y:%f", Position.X, ImageView.frame.origin.y);
    [self BounceOffWalls];
    [self HitCeiling];
    ImageView.center = CGPointMake(Position->X, Position->Y);
    //[self HitBottom];
}

-(void) BounceOffWalls
{
    if(ImageView.frame.origin.x < 0)
    {
        Velocity->X = -Velocity->X;
        Acceleration->X = 0;
        Position->X = ( ImageView.frame.size.width / 2 )+ 1;
        if(Velocity->X < 10)
        {
            Velocity->X = -10;
        }
        
    }
    if((ImageView.frame.origin.x + ImageView.frame.size.width) > [UIScreen mainScreen].bounds.size.width)
    {
        Velocity->X = -Velocity->X;
        Acceleration->X = 0;
        Position->X = [UIScreen mainScreen].bounds.size.width - (ImageView.frame.size.width / 2) - 1;
        if(Velocity->X > -10)
        {
            Velocity->X = -10;
        }
    }
}

-(void) HitCeiling
{
    if(ImageView.center.y < 50)
    {
        //NSLog(@"HELPME %f", Position->Y);
        Position->Y = 50;
        ImageView.center = CGPointMake(Position->X, Position->Y);
        //NSLog(@"Now %f", Position->Y);
        Velocity->Y = (-Velocity->Y);
        if(Velocity->Y < 1)
        {
            Velocity->Y = 1;
        }
    }
}

-(bool) HitBottom
{
    if(ImageView.frame.origin.y + ImageView.frame.size.height > [UIScreen mainScreen].bounds.size.height)
    {
        //Velocity->Y = (-Velocity->Y) * .9;
        return true;
    }
    return false;
}

-(void) BounceOffPoint:(CGPoint)point kickBack:(float)kick
{
    Vector* dist = [[Vector alloc] GetVectorBetweenPoints:point PointTwo:ImageView.center];
    [Velocity Clear];
    [Acceleration Clear];
    dist = [dist Multiply:kick];
    [Velocity Add:dist];
}


@end
