//
//  PBGameGenViewController.m
//  ProtoBoard
//
//  Created by Nathan Burgers on 11/8/13.
//  Copyright (c) 2013 Nathan Burgers. All rights reserved.
//

#import "PBGameGenViewController.h"

#define FPS 60
@interface PBGameGenViewController ()

@end

@implementation PBGameGenViewController

int i, j;
bool running;
NSTimeInterval elapsed;
NSTimer* timer;
int score;
int prevScore;
int bestScore;
UILabel* lblScore;
int numBumpers = 3;



/*
-(void) refreshUI
{
    while(running)
    {


                           // use main thread to update view
                           dispatch_async(dispatch_get_main_queue(), ^()
                                          {
                                              m.ImageView.center = CGPointMake(150,50 + (i/100));
                                              
                                              [self.view setNeedsDisplay];
                                          });
                           
                           // delay
                           [NSThread sleepForTimeInterval:.5];
    i++;
    NSLog(@"I:%d\n", i);
    }
}
-(void) gameLoop
{
    while(running)
    {
        NSTimeInterval timeStart = [[NSDate date] timeIntervalSince1970];
    
        
        //[m Update:elapsed];

        NSTimeInterval timeEnd = [[NSDate date] timeIntervalSince1970];
        elapsed = timeEnd- timeStart;
        NSTimeInterval sleep = (1/FPS) - elapsed;
        
        [NSThread sleepForTimeInterval:sleep];
        j++;
        NSLog(@"J:%d\n", j);

    }
}
*/

-(void) taps
{
    NSTimeInterval timeStart = [[NSDate date] timeIntervalSince1970];
    
    lblScore.text = [NSString stringWithFormat:@"Score: %d", score];
    [m UpdateFalling:elapsed];
    
    NSTimeInterval timeEnd = [[NSDate date] timeIntervalSince1970];
    elapsed = timeEnd- timeStart;
    elapsed *= (500 + (((int)score / 100) * 100));
    NSTimeInterval sleep = (1/FPS) - elapsed;
    
    [NSThread sleepForTimeInterval:sleep];

}

-(void) pinball
{
    NSTimeInterval timeStart = [[NSDate date] timeIntervalSince1970];
    if(!ballInPlay)
    {
        [self resetBall];
    }
    lblScore.text = [NSString stringWithFormat:@"Score: %d", score];
    [m UpdateFalling:elapsed];
    
    for(int i = 0; i < numBumpers; i++)
    {
        if([bumpers[i] isColliding:m])
        {
            GameObject *object = bumpers[i];
            if(object->isSolid)
            {
                [m BounceOffPoint:object.ImageView.center kickBack:object->kickBack];
            }
            score+=object->scoreMod;
        }
    }
    if([s isColliding:m])
    {
        [m BounceOffPoint:s.ImageView.center kickBack: 1.0f];
    }
    if([m HitBottom])
    {
        ballInPlay = false;
    }
    NSTimeInterval timeEnd = [[NSDate date] timeIntervalSince1970];
    elapsed = timeEnd- timeStart;
    elapsed *= 1000;
    NSTimeInterval sleep = (1/FPS) - elapsed;
    
    [NSThread sleepForTimeInterval:sleep];
}

-(void) resetBoard
{
    ballInPlay = false;
    for(int i = 0; i < numBumpers; i++)
    {
        GameObject *object = bumpers[i];
        object->enabled = true;
        object.ImageView.hidden = false;
    }
    prevScore = score;
    score = 0;
    if(prevScore < bestScore)
    {
        bestScore = prevScore;
    }
}

-(void) breakout
{
    NSTimeInterval timeStart = [[NSDate date] timeIntervalSince1970];
    if(!ballInPlay)
    {
        [self resetBall];
    }
    lblScore.text = [NSString stringWithFormat:@"Score: %d  Previous Score: %d  Best: %d", score, prevScore, bestScore];
    [m UpdateFalling:elapsed];
    int disabledBumpers = 0;
    for(int i = 0; i < numBumpers; i++)
    {
        GameObject *object = bumpers[i];
        if(!object->enabled)
        {
            disabledBumpers++;
        }
        else if([bumpers[i] isColliding:m])
        {
                [m BounceOffPoint:object.ImageView.center kickBack:1];
                //score+=object->scoreMod;
                object->enabled = false;
                object.ImageView.hidden = true;
        }
    }
    if(disabledBumpers == numBumpers)
    {
        [self resetBoard];
    }
    if([s isColliding:m])
    {
        [m BounceOffPoint:s.ImageView.center kickBack: 1.0f];
        if(ballInPlay)
        {
            score += 1;
        }
    }
    if([m HitBottom])
    {
        ballInPlay = false;
        score += 5;
    }
    NSTimeInterval timeEnd = [[NSDate date] timeIntervalSince1970];
    elapsed = timeEnd- timeStart;
    elapsed *= 1000;
    NSTimeInterval sleep = (1/FPS) - elapsed;
    
    [NSThread sleepForTimeInterval:sleep];

}

+ (instancetype)controllerWithJSONSerialization:(NSDictionary *)json
{
    return [[self alloc] initWithJSONSerialization:json];
}

- (id)initWithJSONSerialization:(NSDictionary *)json
{
    if (self = [super initWithNibName:nil bundle:nil]) {
        dict = json;
    }
    return self;
}


-(void)loadTapsGame
{
    lblScore = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 350, 50)];
    [lblScore setBackgroundColor:[UIColor clearColor]];
    [lblScore setTextColor:[UIColor blackColor]];
    lblScore.text = @"Score: 0";
    [self.view addSubview:lblScore];
}

-(void)resetBall
{
    m->Position->X = s.ImageView.center.x;
    m->Position->Y = s.ImageView.center.y - (s.ImageView.frame.size.height/2) - (m.ImageView.frame.size.height/2);
    m->Velocity->X = 0;
    m->Acceleration->Y = 0;
    m->Velocity->Y = 0;
                                                                                 
}

-(void) createObjectX: (float)x Y:(float)y Width:(float)w Height:(float)h Type:(Parts)p
{
    x = x * [UIScreen mainScreen].bounds.size.width;
    y = (y * ([UIScreen mainScreen].bounds.size.height - 70)) + 20;
    w = w * [UIScreen mainScreen].bounds.size.width / 2;
    h = h * [UIScreen mainScreen].bounds.size.height / 2;
    if(p == CIRCLEBUMPER)
    {
        [bumpers addObject:[[CircleBumper alloc] initX:x initY:y initW:w initH:h]];
    }
    if(p == CIRCLETARGET)
    {
        [bumpers addObject:[[CircleTarget alloc] initX:x initY:y initW:w initH:h]];
    }
    if(p == SQUAREBUMPER)
    {
        [bumpers addObject:[[SquareBumper alloc] initX:x initY:y initW:w initH:h]];
    }
    if(p == CIRCLEPEG)
    {
        [bumpers addObject:[[Peg alloc] initX:x initY:y initW:w initH:h]];
    }
    if(p == SQUAREPEG)
    {
        [bumpers addObject:[[SquarePeg alloc] initX:x initY:y initW:w initH:h]];
    }
    if(p == SQUARETARGET)
    {
        [bumpers addObject:[[SquareTarget alloc] initX:x initY:y initW:w initH:h]];
    }
    
}

//Square = Circle Bumper (blue)
//Circle = Circle Peg (purple)
//Square Circle = Square Bumper (blue)
//Square X = Square Target (green)
//Circle Square = Square Peg(purple)
//Circle X = Circle Target(green) - not working, become circle bumper

-(void) loadBumpers
{
    numBumpers = 0;
    //NSLog(@"count:%d", dict.count);
    s= [[Slider alloc] initX:0 initY:0];
    [self.view addSubview:s.ImageView];
    bumpers = [[NSMutableArray alloc] init];
    /*[bumpers addObject:[[Peg alloc] initX:250 initY:70]];
    [bumpers addObject:[[CircleBumper alloc] initX:150 initY:170]];
    [bumpers addObject:[[SquareTarget alloc] initX:50 initY:270]];*/
    NSLog(@"KEy: %@", dict.allKeys[0]);
    NSDictionary* more = dict[@"entities"];
    
    int counter = 0;
    float x, y, width, height;
    NSArray* list = [more objectForKey:@"class5"];
    for(NSArray *thing in list)
    {
        NSLog(@"CIRCLEBUMPER");
        NSLog(@"%@\n", thing);
        for(NSString *num in thing)
        {
            
            switch(counter)
            {
                case 0:
                    x = [num floatValue];
                    counter++;
                    break;
                case 1:
                    y = [num floatValue];
                    counter++;
                    break;
                case 2:
                    width = [num floatValue];
                    counter++;
                    break;
                case 3:
                    height = [num floatValue];
                    [self createObjectX:x Y:y Width:width Height:height Type:CIRCLEBUMPER];
                    counter = 0;
                    numBumpers++;
                    break;
            }
        }
        
    }
    list = [more objectForKey:@"class4"];
    for(NSArray *thing in list)
    {
        NSLog(@"CIRCLEPEG");
        NSLog(@"%@\n", thing);
        for(NSString *num in thing)
        {
            
            switch(counter)
            {
                case 0:
                    x = [num floatValue];
                    counter++;
                    break;
                case 1:
                    y = [num floatValue];
                    counter++;
                    break;
                case 2:
                    width = [num floatValue];
                    counter++;
                    break;
                case 3:
                    height = [num floatValue];
                    [self createObjectX:x Y:y Width:width Height:height Type:CIRCLEPEG];
                    counter = 0;
                    numBumpers++;
                    break;
            }
        }
        
    }
    list = [more objectForKey:@"class3"];
    for(NSArray *thing in list)
    {
        NSLog(@"CIRCLETARGET");
        NSLog(@"%@\n", thing);
        for(NSString *num in thing)
        {
            
            switch(counter)
            {
                case 0:
                    x = [num floatValue];
                    counter++;
                    break;
                case 1:
                    y = [num floatValue];
                    counter++;
                    break;
                case 2:
                    width = [num floatValue];
                    counter++;
                    break;
                case 3:
                    height = [num floatValue];
                    [self createObjectX:x Y:y Width:width Height:height Type:CIRCLETARGET];
                    counter = 0;
                    numBumpers++;
                    break;
            }
        }
        
    }
    list = [more objectForKey:@"class2"];
    for(NSArray *thing in list)
    {
        NSLog(@"SQUAREBUMPER");
        NSLog(@"%@\n", thing);
        for(NSString *num in thing)
        {
            
            switch(counter)
            {
                case 0:
                    x = [num floatValue];
                    counter++;
                    break;
                case 1:
                    y = [num floatValue];
                    counter++;
                    break;
                case 2:
                    width = [num floatValue];
                    counter++;
                    break;
                case 3:
                    height = [num floatValue];
                    [self createObjectX:x Y:y Width:width Height:height Type:SQUAREBUMPER];
                    counter = 0;
                    numBumpers++;
                    break;
            }
        }
        
    }

    list = [more objectForKey:@"class1"];
    for(NSArray *thing in list)
    {
        NSLog(@"SQUAREPEGS");
        NSLog(@"%@\n", thing);
        for(NSString *num in thing)
        {
            
            switch(counter)
            {
                case 0:
                    x = [num floatValue];
                    counter++;
                    break;
                case 1:
                    y = [num floatValue];
                    counter++;
                    break;
                case 2:
                    width = [num floatValue];
                    counter++;
                    break;
                case 3:
                    height = [num floatValue];
                    [self createObjectX:x Y:y Width:width Height:height Type:SQUAREPEG];
                    counter = 0;
                    numBumpers++;
                    break;
            }
        }
        
    }
    list = [more objectForKey:@"class0"];
    for(NSArray *thing in list)
    {
        NSLog(@"SQUARETARGET");
        NSLog(@"%@\n", thing);
        for(NSString *num in thing)
        {
            
            switch(counter)
            {
                case 0:
                    x = [num floatValue];
                    counter++;
                    break;
                case 1:
                    y = [num floatValue];
                    counter++;
                    break;
                case 2:
                    width = [num floatValue];
                    counter++;
                    break;
                case 3:
                    height = [num floatValue];
                    [self createObjectX:x Y:y Width:width Height:height Type:SQUARETARGET];
                    counter = 0;
                    numBumpers++;
                    break;
            }
        }
        
    }
    for(int i = 0; i < numBumpers; i++)
    {
        GameObject * g = bumpers[i];
        [self.view addSubview:g.ImageView];
    }
    [self.view addSubview: m.ImageView];
    ballInPlay = false;
    [self resetBall];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    score = 0;
    running = YES;
    elapsed = 0;
    //g = [[GameObject alloc] initX:50.0f initY:50.5f initW:50 initH:50];
    m = [[MovingObject alloc] initX: 52.5f initY: 73.5f];
    
    
    
    gameType = BREAKOUT;
    if(gameType == TAPS)
    {
        [self loadTapsGame];
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0f/FPS target:self selector:@selector(taps) userInfo:nil repeats:YES];
        [self.view addSubview: m.ImageView];
    }
    else if(gameType == PINBALL)
    {
        [self loadBumpers];
        [self loadTapsGame];
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0f/FPS target:self selector:@selector(pinball) userInfo:nil repeats:YES];
    }
    else if(gameType == BREAKOUT)
    {
        bestScore = 99;
        prevScore = 99;
        [self loadBumpers];
        [self loadTapsGame];
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0f/FPS target:self selector:@selector(breakout) userInfo:nil repeats:YES];
    }
    
	// Do any additional setup after loading the view.
/*
    [NSThread detachNewThreadSelector:@selector(gameLoop)
                             toTarget:self withObject:nil];
    [NSThread detachNewThreadSelector:@selector(refreshUI) toTarget:self withObject:nil];
     */
}

-(bool)pointInRect:(CGPoint) p rect:(CGRect) r
{
    if(p.x > r.origin.x && p.x < r.origin.x + r.size.width)
    {
        if(p.y > r.origin.y && p.y < r.origin.y + r.size.height)
        {
            return true;
        }
    }
    return false;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches]anyObject];
    CGPoint location = [touch locationInView:self.view];
    if(gameType == TAPS)
    {
        if([self pointInRect: location rect: m.ImageView.frame])
        {
            [m BounceOffPoint:location kickBack:1.0f];
            score += 15;
            
        }
    }
    else if(gameType == PINBALL)
    {
        //[s update:location.x];
        
    }
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches]anyObject];
    CGPoint location = [touch locationInView:self.view];
    if(gameType == TAPS)
    {

    }
    else if(gameType == PINBALL || gameType == BREAKOUT)
    {
        [s update:location.x];
    }
}
-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(gameType == TAPS)
    {
        
    }
    else if(gameType == PINBALL || gameType == BREAKOUT)
    {
        if(!ballInPlay)
        {
            ballInPlay = true;
            m->Velocity->Y = 15;
        }
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
