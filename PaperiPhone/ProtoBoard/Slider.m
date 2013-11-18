//
//  Slider.m
//  ProtoBoard
//
//  Created by John Stelben on 11/9/13.
//  Copyright (c) 2013 Nathan Burgers. All rights reserved.
//

#import "Slider.h"

@implementation Slider


-(id) initX:(float)x initY:(float)y
{
    self = [super initX:x initY:y initW:50 initH:50];
    if(self)
    {
        ImageView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 40, [UIScreen mainScreen].bounds.size.width / 4, 40);
        ImageView.image = [UIImage imageNamed:@"../BlueRectangle.jpg"];
    }
    return self;
}

-(void) update:(float) newX
{
    Position->X = newX;
    ImageView.frame = CGRectMake(newX -20, ImageView.frame.origin.y
                                 , ImageView.frame.size.width, ImageView.frame.size.height);
    
}
@end
