//
//  Slider.h
//  ProtoBoard
//
//  Created by John Stelben on 11/9/13.
//  Copyright (c) 2013 Nathan Burgers. All rights reserved.
//

#import "GameObject.h"

@interface Slider : GameObject

-(id) initX: (float)x initY: (float)y;
-(void) update:(float)newX;
@end