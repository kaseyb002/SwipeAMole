//
//  HowToPlayViewController.m
//  SwipeAMole
//
//  Created by Kasey Baughan on 4/10/14.
//  Copyright (c) 2014 Kasey Baughan. All rights reserved.
//

#import "HowToPlayViewController.h"
#import "HowToBarView.h"

@interface HowToPlayViewController (){
    
    CGRect screenRect;
    
}

@property (nonatomic) int actionSequenceNumber;

@property (strong, nonatomic) HowToBarView *tutBar;

@end

@implementation HowToPlayViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    screenRect = [[UIScreen mainScreen] bounds];
    
    [self setupNotificationCenters];
    
    //draw a right swipe bar
    self.tutBar = [[HowToBarView alloc] initWithFrame:CGRectMake(screenRect.size.width / 4, screenRect.size.height / 2, 150, 65) isRightSwipe:YES];
    
    [self.view addSubview:self.tutBar];
    
}

#pragma mark - Setup Notifications

//for the restaurant lists
- (void)setupNotificationCenters{//this is the listener
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(barSwiped)
                                                 name:@"howToBarSwiped"
                                               object:nil];
}

- (void)barSwiped{
    
    self.actionSequenceNumber++;
    
    if(self.actionSequenceNumber == 1){
        
        //change instruction text
        [self fadeAnimation:self.instructionLabel yesFadeInNoFadeOut:NO beginningAlpha:1.0 endingAlpha:0.0 animationDuration:0.5];
        
        self.instructionLabel.text = @"now left swipe the bar";
        
        [self fadeAnimation:self.instructionLabel yesFadeInNoFadeOut:YES beginningAlpha:0.0 endingAlpha:1.0 animationDuration:0.5];
        
        //fade in the left bar
        self.tutBar = [[HowToBarView alloc] initWithFrame:CGRectMake(screenRect.size.width / 4, screenRect.size.height / 2, 150, 65) isRightSwipe:NO];
        
        [self.view addSubview:self.tutBar];
        
        [self fadeAnimation:self.tutBar yesFadeInNoFadeOut:YES beginningAlpha:0.0 endingAlpha:1.0 animationDuration:0.5];
        
        
    } else if(self.actionSequenceNumber == 2){
        
        //change instruction text
        [self fadeAnimation:self.instructionLabel yesFadeInNoFadeOut:NO beginningAlpha:1.0 endingAlpha:0.0 animationDuration:0.5];
        
        self.instructionLabel.text = @"that's it! \n \n just do not to let 5 bars get on the screen at once";
        
        [self fadeAnimation:self.instructionLabel yesFadeInNoFadeOut:YES beginningAlpha:0.0 endingAlpha:1.0 animationDuration:0.5];
        
    }
    
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

- (IBAction)done:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
