//
//  GameObject.m
//  ProtoBoard
//
//  Created by John Stelben on 11/9/13.
//  Copyright (c) 2013 Nathan Burgers. All rights reserved.
//

#import "GameObject.h"

@implementation GameObject
@synthesize ImageView;
-(id) init
{
    self = [super init];
    if(self)
    {
        Position = [[Vector alloc] init];
        ImageView = [[UIImageView alloc] init];
    }
    return self;
}

-(id) initX: (float)x initY: (float)y initW: (float)w initH:(float) h
{
    self = [super init];
    if(self)
    {
        Position = [[Vector alloc] initX: x initY:y];
        ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(Position->X, Position->Y, w, h)];
        ImageView.bounds = ImageView.frame;
        //ImageView.center = CGPointMake(Position.X, Position.Y);
        //ImageView.bounds = CGRectMake(Position.X, Position.Y, 50, 50);
        ImageView.image = [UIImage imageNamed:@"../PurpleSquare.jpg"];
        enabled = true;
        
    }
    return self;
}
-(bool) isColliding:(GameObject *)other
{
    if(CGRectIntersectsRect(ImageView.frame, other.ImageView.frame))
    {
        return true;
    }
    return false;
}
@end
