//
//  BarView.m
//  SwipeAMole
//
//  Created by Kasey Baughan on 4/7/14.
//  Copyright (c) 2014 Kasey Baughan. All rights reserved.
//

#import "BarView.h"

#define BAR_WIDTH 150
#define BAR_HEIGHT 65
#define BAR_CORNER_RADIUS 8

@interface BarView (){

    CGRect screenRect;
    
}

@property (nonatomic) int xDestination;

@end

@implementation BarView

+ (NSArray *)colors{
    
    return @[[UIColor colorWithRed:175.0/255.0 green:30.0/255.0 blue:45.0/255.0 alpha:1],//stop sign red
             [UIColor colorWithRed:72.0/255.0 green:165.0/255.0 blue:175.0/255.0 alpha:1],//blissed (turquoise)
             [UIColor colorWithRed:11.0/255.0 green:239.0/255.0 blue:49.0/255.0 alpha:1],//yeah green
             [UIColor colorWithRed:18.0/255.0 green:106.0/255.0 blue:178.0/255.0 alpha:1],//superblue
             [UIColor colorWithRed:175.0/255.0 green:100.0/255.0 blue:249.0/255.0 alpha:1],//purple
             [UIColor colorWithRed:152.0/255.0 green:186.0/255.0 blue:215.0/255.0 alpha:1],//rustico
             [UIColor colorWithRed:0.0/255.0 green:249.0/255.0 blue:189.0/255.0 alpha:1],//A, ocean green
             [UIColor colorWithRed:236.0/255.0 green:186.0/255.0 blue:215.0/255.0 alpha:1],
             [UIColor colorWithRed:221.0/255.0 green:232.0/255.0 blue:124.0/255.0 alpha:1],
             [UIColor colorWithRed:203.0/255.0 green:153.0/255.0 blue:139.0/255.0 alpha:1],
             [UIColor colorWithRed:27.0/255.0 green:53.0/255.0 blue:40.0/255.0 alpha:1],
             [UIColor colorWithRed:208.0/255.0 green:192.0/255.0 blue:158.0/255.0 alpha:1],
             [UIColor colorWithRed:44.0/255.0 green:50.0/255.0 blue:76.0/255.0 alpha:1],
             [UIColor colorWithRed:143.0/255.0 green:109.0/255.0 blue:82.0/255.0 alpha:1],
             [UIColor colorWithRed:165.0/255.0 green:87.0/255.0 blue:65.0/255.0 alpha:1],
             [UIColor colorWithRed:18.0/255.0 green:254.0/255.0 blue:201.0/255.0 alpha:1],
             [UIColor colorWithRed:176.0/255.0 green:248.0/255.0 blue:211.0/255.0 alpha:1],
             [UIColor colorWithRed:214.0/255.0 green:244.0/255.0 blue:231.0/255.0 alpha:1],
             [UIColor colorWithRed:230.0/255.0 green:226.0/255.0 blue:213.0/255.0 alpha:1],
             [UIColor colorWithRed:223.0/255.0 green:209.0/255.0 blue:199.0/255.0 alpha:1],
             [UIColor colorWithRed:174.0/255.0 green:50.0/255.0 blue:48.0/255.0 alpha:1],
             [UIColor colorWithRed:224.0/255.0 green:231.0/255.0 blue:213.0/255.0 alpha:1],
             [UIColor colorWithRed:187.0/255.0 green:126.0/255.0 blue:123.0/255.0 alpha:1],
             [UIColor colorWithRed:136.0/255.0 green:215.0/255.0 blue:255.0/255.0 alpha:1],
             [UIColor colorWithRed:25.0/255.0 green:138.0/255.0 blue:255.0/255.0 alpha:1],
             [UIColor colorWithRed:255.0/255.0 green:153.0/255.0 blue:53.0/255.0 alpha:1],
             [UIColor colorWithRed:183.0/255.0 green:189.0/255.0 blue:10.0/255.0 alpha:1],
             [UIColor colorWithRed:34.0/255.0 green:166.0/255.0 blue:170.0/255.0 alpha:1],
             [UIColor colorWithRed:255.0/255.0 green:107.0/255.0 blue:147.0/255.0 alpha:1],
             [UIColor colorWithRed:30.0/255.0 green:64.0/255.0 blue:109.0/255.0 alpha:1],
             [UIColor colorWithRed:243.0/255.0 green:134.0/255.0 blue:48.0/255.0 alpha:1],
             [UIColor colorWithRed:250.0/255.0 green:105.0/255.0 blue:0.0/255.0 alpha:1],
             [UIColor colorWithRed:105.0/255.0 green:210.0/255.0 blue:231.0/255.0 alpha:1],
             [UIColor colorWithRed:233.0/255.0 green:78.0/255.0 blue:119.0/255.0 alpha:1],
             [UIColor colorWithRed:214.0/255.0 green:129.0/255.0 blue:137.0/255.0 alpha:1],
             [UIColor colorWithRed:198.0/255.0 green:164.0/255.0 blue:154.0/255.0 alpha:1],
             [UIColor colorWithRed:250.0/255.0 green:42.0/255.0 blue:0.0/255.0 alpha:1],
             [UIColor colorWithRed:240.0/255.0 green:216.0/255.0 blue:168.0/255.0 alpha:1],
             [UIColor colorWithRed:192.0/255.0 green:210.0/255.0 blue:62.0/255.0 alpha:1],
             [UIColor colorWithRed:168.0/255.0 green:39.0/255.0 blue:67.0/255.0 alpha:1],
             [UIColor colorWithRed:188.0/255.0 green:189.0/255.0 blue:172.0/255.0 alpha:1],
             [UIColor colorWithRed:233.0/255.0 green:233.0/255.0 blue:233.0/255.0 alpha:1],
             [UIColor colorWithRed:50.0/255.0 green:153.0/255.0 blue:187.0/255.0 alpha:1]
             ];
    
}

+ (UIColor *)goldenColor{
    
    return [UIColor colorWithRed:255.0/255.0 green:229.0/255.0 blue:69.0/255.0 alpha:1];
    
}

- (id)initWithFrame:(CGRect)frame
{
    
    screenRect = [[UIScreen mainScreen] bounds];
    
    self = [super initWithFrame:CGRectMake([self getRandomNumberBetween:0 maxNumber:screenRect.size.width - BAR_WIDTH], [self getRandomNumberBetween:BAR_HEIGHT maxNumber:screenRect.size.height - BAR_HEIGHT], BAR_WIDTH, BAR_HEIGHT)];
    
    if (self) {
        
        //set random color
        self.backgroundColor = [BarView colors][[self getRandomNumberBetween:0 maxNumber:[[BarView colors] count] - 1]];
        
        //set curves
        self.layer.cornerRadius = BAR_CORNER_RADIUS;
        
        //random for left and right swipe
        if([self getRandomNumberBetween:0 maxNumber:1]){
            
            self.isRightSwipe = YES;

        }
        
        //1% of the time get a golden bar
        if([self getRandomNumberBetween:0 maxNumber:1000] == 1){
            
            self.isGolden = YES;
            
            self.backgroundColor = [BarView goldenColor];
            
        }
        
        //add left swipe text
        UILabel *yourLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, BAR_WIDTH, BAR_HEIGHT)];
        
        [yourLabel setTextColor:[UIColor blackColor]];
        
        [yourLabel setBackgroundColor:[UIColor clearColor]];
        
        [yourLabel setFont:[UIFont fontWithName: @"Trebuchet MS" size: 14.0f]];
        
        yourLabel.textAlignment = NSTextAlignmentCenter;
        
        UISwipeGestureRecognizer *gestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandler)];
        
        if(self.isRightSwipe){
            
            //add rightswipe arrow image
            yourLabel.text = @"▶︎  ▶︎  ▶︎";
            
            //add rightswipe gesture
            [gestureRecognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
            
            
        } else {
        
            yourLabel.text = @"◀︎  ◀︎  ◀︎";
            
            //add left swipe gesture
            [gestureRecognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
            
        }
        
        [self addSubview:yourLabel];
        
        [self addGestureRecognizer:gestureRecognizer];
        
    }
    
    return self;
    
}

- (void)swipeHandler{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"barSwiped" object:self];
    
    [UIView beginAnimations:@"fade out" context:nil];
    
    [UIView setAnimationDuration:0.15];
    
    self.alpha = 0.0;
    
    if(self.isGolden){
        
        //send post notification about bonus time
        [[NSNotificationCenter defaultCenter] postNotificationName:@"goldenBarSwiped" object:self];
    }
    
    [UIView commitAnimations];
    
}

#pragma mark - Helpers

- (NSInteger)getRandomNumberBetween:(NSInteger)min maxNumber:(NSInteger)max{
    
    return min + arc4random() % (max - min + 1);
    
}

@end
