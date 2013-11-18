//
//  Vector.h
//  ProtoBoard
//
//  Created by John Stelben on 11/9/13.
//  Copyright (c) 2013 Nathan Burgers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Vector : NSObject
{
    @public
    float X;
    float Y;
    
}
- (float) GetMagnitude;
-(id) initX: (float)x initY: (float)y;
-(Vector*) Multiply:(float)f;
-(void) Add:(Vector*)otherVector;
-(Vector*) GetVectorBetweenPoints:(CGPoint)p1 PointTwo:(CGPoint)p2;
-(void) Clear;
-(void) dealloc;
@end
