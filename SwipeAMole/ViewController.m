//
//  ViewController.m
//  SwipeAMole
//
//  Created by Kasey Baughan on 4/7/14.
//  Copyright (c) 2014 Kasey Baughan. All rights reserved.
//
/*
 App Description
 
 A bunch of bars will randomly appear on the screen at random intervals. Your job is to make sure too many bars dont appear on the screen at once. Each bar swiped away earns a point.
 
 This app is combining the model and the contoller. I suppose that is bad, but the app is so simple I don't really care.
 
 */

#define MAX_NUMBER_OF_BARS 5
#define NUMBER_OF_TIMES_TO_TRY_DRAWING_BAR_WITHOUT_OVERLAPPING 20

#define ARC4RANDOM_MAX 0x100000000

#define BAR_WIDTH 150
#define BAR_HEIGHT 50

#define INITIAL_LOWER_BOUND_INTERVAL 0.80
#define INITIAL_UPPER_BOUND_INTERVAL 1.0

#define MINIMUM_LOWERBOUND 0.30

//levels based on points
//#define LEVEL_1 10
//#define LEVEL_2 15
//#define LEVEL_3 25
//#define LEVEL_4 35
//#define LEVEL_5 40

//levels based on time
#define LEVEL_1 0.7
#define LEVEL_2 0.6
#define LEVEL_3 0.5
#define LEVEL_4 0.4
#define LEVEL_5 0.35

#define GOLDEN_BAR_BONUS 5
#define GOLDEN_BAR_SLOWDOWN_BONUS 0.10

#import "ViewController.h"
#import "GameOverViewController.h"
#import "MainMenuViewController.h"

@interface ViewController (){
    
    CGRect screenRect;
    
}

@property (strong, nonatomic) UIImageView *rightSwipeImage;

@property (strong, nonatomic) UIImageView *leftSwipeImage;

@property (nonatomic) float lowerBoundInterval;

@property (nonatomic) float upperBoundInterval;

@end

@implementation ViewController

#pragma mark - Getters

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.averageIncrementLabel.hidden = YES;
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    
    self.navigationController.navigationBar.hidden = YES;
    
    
    [self setupNotificationCenters];
    
    self.lowerBoundInterval = INITIAL_LOWER_BOUND_INTERVAL;
    
    self.upperBoundInterval = INITIAL_UPPER_BOUND_INTERVAL;
    
}

- (void)startTimer{//maybe the model should handle this, but we are going to let the controller do it for now
    
    
    //modify the time interval
    float logDivisor = 100;
    
    float averageInterval = (self.lowerBoundInterval + self.upperBoundInterval) / 2;
    
//    if(self.points >= LEVEL_1 && self.points < LEVEL_2){
//
//        logDivisor = 250;
//
//    } else if (self.points >= LEVEL_2 && self.points < LEVEL_3){
//
//        logDivisor = 500;
//
//    } else if (self.points >= LEVEL_3 && self.points < LEVEL_4){
//
//        logDivisor = 1000;
//
//    } else if (self.points >= LEVEL_4 && self.points < LEVEL_5){
//
//        logDivisor = 2000;
//
//    } else if(self.points >= LEVEL_5){
//
//        logDivisor = 3000;
//
//    }
    
    if(averageInterval <= LEVEL_1 && averageInterval > LEVEL_2){
        
        logDivisor = 250;
        
    } else if (averageInterval <= LEVEL_2 && averageInterval > LEVEL_3){
        
        logDivisor = 500;
        
    } else if (averageInterval <= LEVEL_3 && averageInterval > LEVEL_4){
        
        logDivisor = 1000;
        
    } else if (averageInterval <= LEVEL_4 && averageInterval > LEVEL_5){
        
        logDivisor = 2000;
        
    } else if(averageInterval <= LEVEL_5){
        
        logDivisor = 5000;
        
    }

    
    if(self.lowerBoundInterval >= MINIMUM_LOWERBOUND){
        
        //float amountToDecrement = [self getRandomDecimalBetween:0.01 maxNumber:0.03];
        
        float amountToDecrement = log(self.points + 1) / logDivisor;
        
        self.lowerBoundInterval = self.lowerBoundInterval - amountToDecrement;
        
        self.upperBoundInterval = self.upperBoundInterval - amountToDecrement;
        
        self.averageIncrementLabel.text = [NSString stringWithFormat:@"%f", ((self.lowerBoundInterval + self.upperBoundInterval) / 2)];
        
    }
    
    
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:[self getRandomDecimalBetween:self.lowerBoundInterval maxNumber:self.upperBoundInterval]
                                                  target:self
                                                selector:@selector(fireMethod:)
                                                userInfo:nil
                                                 repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}

- (void)viewDidAppear:(BOOL)animated{
    
    for(UIView *view in self.view.subviews){
        
        if([view isKindOfClass:[BarView class]]){
            
            [view removeFromSuperview];
            
        }
        
    }
    
    self.points = 0;
    
    self.pointsLabel.text = [NSString stringWithFormat:@"%d", self.points];
    
    self.fadeMessageLabel.text = @"Swipe Away!!!";
    
    [self fadeAnimation:self.fadeMessageLabel yesFadeInNoFadeOut:NO beginningAlpha:1.0 endingAlpha:0.0 animationDuration:2.0];
    
    [self startTimer];
    
}


- (void)fireMethod:(NSTimer *)theTimer{
    
    [self.timer invalidate];
    
    [self startTimer];
    
    [self drawButton:nil];
    
    self.numberOfBarsOnScreen++;
    
    if(self.numberOfBarsOnScreen >= MAX_NUMBER_OF_BARS){
        
        [self.timer invalidate];
        
        [self performSegueWithIdentifier:@"gameOver" sender:nil];
        
    }
    
}


- (void)drawButton:(UIButton *)sender {
    
    BarView *barView = [[BarView alloc] init];
    
    for(int i = 0; i < NUMBER_OF_TIMES_TO_TRY_DRAWING_BAR_WITHOUT_OVERLAPPING; i++){//try five times to make a bar that doesn't overlap any of the other bars
        
        if([self checkForOverlap:barView]){//if it does overlap, then draw a new bar
            
            NSLog(@"found overlap: %d", i);
            
            barView = [[BarView alloc] init];
            
        } else {//if it doesn't overlap, then quit now and draw the bar
            
            goto BAIL;
            
        }
        
    }
    
    BAIL:
    [self scaleAnimation:barView];
    
    [self.view addSubview:barView];

}

#pragma mark - Animation Dude

- (void)fadeAnimation:(UIView *)view yesFadeInNoFadeOut:(BOOL)fadeIn beginningAlpha:(float)beginningAlpha endingAlpha:(float)endingAlpha animationDuration:(float)duration{
    
    view.alpha = beginningAlpha;
    
    if(fadeIn){
        
        [UIView beginAnimations:@"fade in" context:nil];
        
    } else {
        
        [UIView beginAnimations:@"fade out" context:nil];
        
    }
    
    [UIView setAnimationDuration:duration];
    
    view.alpha = endingAlpha;
    
    [UIView commitAnimations];
    
}

- (void)scaleAnimation:(UIView *)view{
    
    // instantaneously make the image view small (scaled to 1% of its actual size)
    view.transform = CGAffineTransformMakeScale(0.01, 0.01);
    
    [UIView animateWithDuration:0.05 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        // animate it to the identity transform (100% scale)
        view.transform = CGAffineTransformMakeScale(1.10, 1.10);
        
    } completion:^(BOOL finished){
        
        // if you want to do something once the animation finishes, put it here
        [UIView animateWithDuration:0.02 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            
            // animate it to the identity transform (100% scale)
            view.transform = CGAffineTransformMakeScale(0.90, 0.90);
            
        } completion:^(BOOL finished){
            
            // if you want to do something once the animation finishes, put it here
            [UIView animateWithDuration:0.02 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                
                // animate it to the identity transform (100% scale)
                view.transform = CGAffineTransformMakeScale(1.05, 1.05);
                
            } completion:^(BOOL finished){
                
                // if you want to do something once the animation finishes, put it here
                [UIView animateWithDuration:0.02 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    
                    // animate it to the identity transform (100% scale)
                    view.transform = CGAffineTransformMakeScale(0.95, 0.95);
                    
                } completion:^(BOOL finished){
                    
                    // if you want to do something once the animation finishes, put it here
                    [UIView animateWithDuration:0.02 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                        
                        // animate it to the identity transform (100% scale)
                        view.transform = view.transform = CGAffineTransformIdentity;
                        
                    } completion:^(BOOL finished){
                        // if you want to do something once the animation finishes, put it here

                        
                    }];
                    
                }];
                
            }];
        
        }];
        
    }];
    
}


#pragma mark - Setup Notifications

//for the restaurant lists
- (void)setupNotificationCenters{//this is the listener
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(barSwiped)
                                                 name:@"barSwiped"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(goldenBarSwiped)
                                                 name:@"goldenBarSwiped"
                                               object:nil];
    
}

- (void)barSwiped{
    
    self.numberOfBarsOnScreen--;
    
    self.points++;
    
    self.pointsLabel.text = [NSString stringWithFormat:@"%d", self.points];
    
}

- (void)goldenBarSwiped{
    
    self.points = self.points + GOLDEN_BAR_BONUS;
    
    float amountToIncrement = GOLDEN_BAR_SLOWDOWN_BONUS;
    
    self.lowerBoundInterval = self.lowerBoundInterval + amountToIncrement;
    
    self.upperBoundInterval = self.upperBoundInterval + amountToIncrement;
    
    self.fadeMessageLabel.text = [NSString stringWithFormat:@"Golden Bar! \n Slowing Down! \n And +%d points!", GOLDEN_BAR_BONUS];
    
    [self fadeAnimation:self.fadeMessageLabel yesFadeInNoFadeOut:YES beginningAlpha:1.0 endingAlpha:0.0 animationDuration:2.5];
    
}

#pragma mark - Segue Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.destinationViewController isKindOfClass:[GameOverViewController class]]){
        
        GameOverViewController *vc = (GameOverViewController *)segue.destinationViewController;
        
        vc.points = self.points;
        
    } else if ([segue.destinationViewController isKindOfClass:[MainMenuViewController class]]){
        
        //I don't think we need to do anything do we??
        
    }
    
    //stop the the timer and kill the game
    self.lowerBoundInterval = INITIAL_LOWER_BOUND_INTERVAL;
    
    self.upperBoundInterval = INITIAL_UPPER_BOUND_INTERVAL;
    
    for(UIView *view in self.view.subviews){
        
        if([view isKindOfClass:[BarView class]]){
            
            [view removeFromSuperview];
            
        }
        
    }
    
    self.points = 0;
    
    self.pointsLabel.text = [NSString stringWithFormat:@"%d", self.points];
    
    self.fadeMessageLabel.text = @"Swipe Away!!!";
    
    [self.timer invalidate];
    
}

#pragma mark - Helpers

- (BOOL)checkForOverlap:(BarView *)barToDraw{
    
    for(UIView *view in self.view.subviews){
        
        if([view isKindOfClass:[BarView class]]){
            
            BarView *barView = (BarView *)view;
            
            if(CGRectIntersectsRect(barToDraw.frame, barView.frame)){
                
                return YES;
                
            }
            
        }
        
    }
    
    return NO;
    
}

- (float)getRandomDecimalBetween:(float)min maxNumber:(float)max{
    
    return ((float)arc4random() / ARC4RANDOM_MAX) * (max-min) + min;
    
}

- (NSInteger)getRandomNumberBetween:(NSInteger)min maxNumber:(NSInteger)max{
    
    NSInteger number = min + arc4random() % (max - min + 1);
    
    return number;
    
    //return min + arc4random() % (max - min + 1);
    
}

- (IBAction)startOver:(UIButton *)sender {
    
    [self performSegueWithIdentifier:@"startOver" sender:nil];
    
}

@end
