//
//  Vector.m
//  ProtoBoard
//
//  Created by John Stelben on 11/9/13.
//  Copyright (c) 2013 Nathan Burgers. All rights reserved.
//

#import "Vector.h"

@implementation Vector
-(id) init
{
    self = [super init];
    if(self)
    {
        X = 0.0f;
        Y = 0.0f;
    }
    return self;
}

-(id) initX:(float)x initY:(float)y
{
    if(self = [super init])
    {
        X = x;
        Y = y;
    }
    return self;
}

-(void) dealloc
{
    
}

-(float) GetMagnitude
{
    return sqrtf(powf(X, 2) + powf(Y, 2));
}

-(Vector*) Multiply:(float)f
{
    Vector* temp = [[Vector alloc] initX:(X * f) initY:(Y * f)];
    
    return temp;
}

-(void) Add:(Vector *)otherVector
{
    X = X + otherVector->X;
    Y = Y + otherVector->Y;
}

-(Vector*) GetVectorBetweenPoints:(CGPoint)p1 PointTwo:(CGPoint)p2
{
    Vector* temp = [[Vector alloc] initX:p2.x - p1.x initY:p2.y - p1.y];
    return temp;
}

-(void) Clear
{
    X = 0;
    Y = 0;
}

@end
