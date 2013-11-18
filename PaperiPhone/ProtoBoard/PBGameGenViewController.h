//
//  PBGameGenViewController.h
//  ProtoBoard
//
//  Created by Nathan Burgers on 11/8/13.
//  Copyright (c) 2013 Nathan Burgers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PBDataViewController.h"
#import "GameObject.h"
#import "MovingObject.h"
#import "Slider.h"
#import "Peg.h"
#import "CircleBumper.h"
#import "SquareTarget.h"
#include "SquarePeg.h"
#include "SquareBumper.h"
#include "CircleTarget.h"

typedef enum {
    TAPS,
    BREAKOUT,
    PINBALL
} GameType;

typedef enum {
    CIRCLEBUMPER,
    SQUAREBUMPER,
    CIRCLEPEG,
    SQUAREPEG,
    CIRCLETARGET,
    SQUARETARGET
}Parts;

@interface PBGameGenViewController : PBDataViewController
{
        GameObject* g;
        MovingObject* m;
        GameType gameType;
    NSMutableArray *bumpers;
    Slider* s;
    bool ballInPlay;
    NSDictionary *dict;
}
+ (instancetype) controllerWithJSONSerialization:(NSDictionary *)json;
- (id) initWithJSONSerialization:(NSDictionary *)json;

@end
