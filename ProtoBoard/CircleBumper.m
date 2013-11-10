//
//  CircleBumper.m
//  ProtoBoard
//
//  Created by John Stelben on 11/9/13.
//  Copyright (c) 2013 Nathan Burgers. All rights reserved.
//

#import "CircleBumper.h"

@implementation CircleBumper
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
        ImageView.image = [UIImage imageNamed:@"../BlueCircle.jpg"];
        scoreMod = 15;
        isSolid = true;
        kickBack = 1.15;
    }
    return self;
}
@end
