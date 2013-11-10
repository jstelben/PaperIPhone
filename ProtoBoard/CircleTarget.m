//
//  CircleTarget.m
//  ProtoBoard
//
//  Created by John Stelben on 11/10/13.
//  Copyright (c) 2013 Nathan Burgers. All rights reserved.
//

#import "CircleTarget.h"

@implementation CircleTarget
-(id) initX: (float)x initY: (float)y initW: (float)w initH:(float) h
{
    self = [super initX:x initY:y initW:w initH:h];
    if(self)
    {
        Position = [[Vector alloc] initX: x initY:y];
        ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(Position->X, Position->Y, w, h)];
        ImageView.bounds = ImageView.frame;
        //ImageView.center = CGPointMake(Position.X, Position.Y);
        //ImageView.bounds = CGRectMake(Position.X, Position.Y, 50, 50);
        ImageView.image = [UIImage imageNamed:@"../GreenCircle.jpg"];
        scoreMod = 1;
        isSolid = false;
        kickBack = 1.15;
    }
    return self;
}
@end
