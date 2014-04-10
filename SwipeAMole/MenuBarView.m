//
//  MenuBarView.m
//  SwipeAMole
//
//  Created by Kasey Baughan on 4/8/14.
//  Copyright (c) 2014 Kasey Baughan. All rights reserved.
//

#import "MenuBarView.h"
#import "BarView.h"
#define MAX_WIDTH 200
#define MAX_HEIGHT 75
#define BAR_CORNER_RADIUS 8

#define MIN_HEIGHT 20
#define MIN_WIDTH 100

@interface MenuBarView () {
    
    CGRect screenRect;
    
}

@property (nonatomic) int xDestination;

@end

@implementation MenuBarView

- (id)initWithFrame:(CGRect)frame
{
    screenRect = [[UIScreen mainScreen] bounds];
    
    self = [super initWithFrame:CGRectMake([self getRandomNumberBetween:0 maxNumber:screenRect.size.width], [self getRandomNumberBetween:0 maxNumber:screenRect.size.height], [self getRandomNumberBetween:MIN_WIDTH maxNumber:MAX_WIDTH], [self getRandomNumberBetween:MIN_HEIGHT maxNumber:MAX_HEIGHT])];
    
    
    if (self) {
        // Initialization code
        
        //set random color
        self.backgroundColor = [BarView colors][[self getRandomNumberBetween:0 maxNumber:[[BarView colors] count] - 1]];
        
        //set curves
        self.layer.cornerRadius = BAR_CORNER_RADIUS;
        
    }
    
    return self;
}

#pragma mark - Just Really Awesome Animations

- (void) moveTo:(CGPoint)destination viewToAnimate:(UIView *)view duration:(float)secs option:(UIViewAnimationOptions)option{
    
    if(self.xDestination == 0){
        
        self.xDestination = screenRect.size.width - self.frame.size.width;
        
    } else {
        
        self.xDestination = 0;
        
    }
    
    [UIView animateWithDuration:secs delay:0.0 options:option
                     animations:^{
                         view.frame = CGRectMake(destination.x,destination.y, view.frame.size.width, view.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         
                         if(finished){
                             
                             [self moveTo:(CGPointMake(self.xDestination, self.frame.origin.y)) viewToAnimate:(UIView *)self duration:(float)secs option:(UIViewAnimationOptions)option];
                             
                         }
                     
                     }];
     
}

- (void)fadeIn{
    
    self.alpha = 0.0;
    
    [UIView beginAnimations:@"fade in" context:nil];
    
    [UIView setAnimationDuration:1.0];
    
    self.alpha = 1.0;
    
    [UIView commitAnimations];
}

- (void)fadeOut{
    
    [UIView beginAnimations:@"fade out" context:nil];
    
    [UIView setAnimationDuration:1.0];
    
    self.alpha = 0.0;
    
    [UIView commitAnimations];
}

#pragma mark - Helpers

- (NSInteger)getRandomNumberBetween:(NSInteger)min maxNumber:(NSInteger)max{
    
    return min + arc4random() % (max - min + 1);
    
}

@end
