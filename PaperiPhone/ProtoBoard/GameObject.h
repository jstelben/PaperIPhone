//
//  GameObject.h
//  ProtoBoard
//
//  Created by John Stelben on 11/9/13.
//  Copyright (c) 2013 Nathan Burgers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Vector.h"

@interface GameObject : NSObject

{
    @public
    Vector* Position;
    UIImageView* ImageView;
    int scoreMod;
    bool isSolid;
    float kickBack;
    bool enabled;

}
@property (nonatomic, retain) IBOutlet UIImageView *ImageView;
-(id) initX: (float)x initY: (float)y initW: (float)w initH:(float) h;
-(bool) isColliding: (GameObject*) other;
@end
