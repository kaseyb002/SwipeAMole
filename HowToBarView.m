//
//  HowToBarView.m
//  SwipeAMole
//
//  Created by Kasey Baughan on 4/10/14.
//  Copyright (c) 2014 Kasey Baughan. All rights reserved.
//

#define BAR_WIDTH 150
#define BAR_HEIGHT 65
#define BAR_CORNER_RADIUS 8

#import "HowToBarView.h"

@implementation HowToBarView

- (id)initWithFrame:(CGRect)frame isRightSwipe:(BOOL)rightSwipe
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        //set random color
        self.backgroundColor = [BarView colors][[self getRandomNumberBetween:0 maxNumber:[[BarView colors] count] - 1]];
        
        //set curves
        self.layer.cornerRadius = BAR_CORNER_RADIUS;
        
        //add left swipe text
        //UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(BAR_WIDTH / 4, BAR_HEIGHT / 4, BAR_WIDTH / 2, BAR_HEIGHT / 2)];
        
        //add left swipe text
        UILabel *yourLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, BAR_WIDTH, BAR_HEIGHT)];
        
        [yourLabel setTextColor:[UIColor blackColor]];
        
        [yourLabel setBackgroundColor:[UIColor clearColor]];
        
        [yourLabel setFont:[UIFont fontWithName: @"Trebuchet MS" size: 40.0f]];
        
        yourLabel.textAlignment = NSTextAlignmentCenter;
        
        UISwipeGestureRecognizer *gestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandler)];
        
        if(rightSwipe){
            
            //add rightswipe arrow image
            //arrowImageView.image = [UIImage imageNamed:@"right_arrow_thick.png"];
            yourLabel.text = @"▶︎";
            
            //add rightswipe gesture
            [gestureRecognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
            
            
        } else {
            
            //arrowImageView.image = [UIImage imageNamed:@"left_arrow_thick.png"];
            yourLabel.text = @"◀︎";
            
            //add left swipe gesture
            [gestureRecognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
            
        }
        
        //[self addSubview:arrowImageView];
        [self addSubview:yourLabel];
        
        [self addGestureRecognizer:gestureRecognizer];
        
    }
    
    
    return self;
}

- (void)swipeHandler{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"howToBarSwiped" object:self];
    
    [UIView beginAnimations:@"fade out" context:nil];
    
    [UIView setAnimationDuration:0.5];
    
    self.alpha = 0.0;
    
    [UIView commitAnimations];
    
}

#pragma mark - Helpers

- (NSInteger)getRandomNumberBetween:(NSInteger)min maxNumber:(NSInteger)max{
    
    return min + arc4random() % (max - min + 1);
    
}


@end
