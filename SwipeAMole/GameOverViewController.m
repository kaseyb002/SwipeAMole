//
//  GameOverViewController.m
//  SwipeAMole
//
//  Created by Kasey Baughan on 4/7/14.
//  Copyright (c) 2014 Kasey Baughan. All rights reserved.
//
#define ARC4RANDOM_MAX 0x100000000
#define NUMBER_OF_BARS_TO_SHOW 10
#define UPPER_BOUND_SPEED 7.0
#define LOWER_BOUND_SPEED 1.5
#define BAR_REFRESH_TIME_INTERVAL 10.0

#import "GameOverViewController.h"
#import "MenuBarView.h"


@interface GameOverViewController ()

@property (strong, nonatomic) NSTimer *timer;

@end

@implementation GameOverViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.playAgainButton.hidden = YES;
    
    self.mainMenuButton.hidden = YES;
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    
    //iad stuff
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    self.bannerView = [[ADBannerView alloc]initWithFrame:
                       CGRectMake(0, screenRect.size.height - 50, 320, 50)];
    self.bannerView.delegate = self;
    // Optional to set background color to clear color
    [self.bannerView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview: self.bannerView];
    //end iad stuff

    self.gotNewHighScoreLabel.hidden = YES;
    
    NSInteger previousBest = [[NSUserDefaults standardUserDefaults] integerForKey:@"bestScore"];
    
    if(self.points > previousBest){
        
        self.gotNewHighScoreLabel.hidden = NO;
        
        self.bestScoreLabel.text = [NSString stringWithFormat:@"Previous Best: %ld", (long)previousBest];
        
        [[NSUserDefaults standardUserDefaults] setInteger:self.points forKey:@"bestScore"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    } else {
        
        self.bestScoreLabel.text = [NSString stringWithFormat:@"Best Score: %ld", (long)previousBest];
    }
    
    self.pointsLabel.text = [NSString stringWithFormat:@"%d", self.points];
    
    [self refreshBars:nil];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:BAR_REFRESH_TIME_INTERVAL
                                                  target:self
                                                selector:@selector(refreshBars:)
                                                userInfo:nil
                                                 repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    
    
}

- (void)viewDidAppear:(BOOL)animated{
    
    [NSThread sleepForTimeInterval:2.0];
    
    self.playAgainButton.hidden = NO;
    
    self.mainMenuButton.hidden = NO;
    
}

- (IBAction)playAgain:(UIButton *)sender {
    
    [self performSegueWithIdentifier:@"playAgain" sender:nil];
    
}

- (IBAction)mainMenu:(UIButton *)sender {
    
    [self performSegueWithIdentifier:@"mainMenu" sender:nil];
    
}

#pragma mark - Background Bars

- (void)refreshBars:(NSTimer *)theTimer{
    
    [self clearBars];
    
    [self runAnimatingBars];
    
}

- (void)runAnimatingBars{
    
    for(int i = 0; i < NUMBER_OF_BARS_TO_SHOW; i++){
        
        MenuBarView *barView = [[MenuBarView alloc] init];
        
        [self.view addSubview:barView];
        
        [barView fadeIn];
        
    }
    
    //everything that is not a bar is to stay on top
    for(UIView *view in self.view.subviews){
        
        if(![view isKindOfClass:[MenuBarView class]]){
            
            [self.view bringSubviewToFront:view];
        }
        
    }
    
    for(UIView *view in self.view.subviews){
        
        if([view isKindOfClass:[MenuBarView class]]){
            
            MenuBarView *barView = (MenuBarView *)view;
            
            //run animation
            [barView moveTo:CGPointMake(0, view.frame.origin.y) viewToAnimate:view duration:[self getRandomDecimalBetween:LOWER_BOUND_SPEED maxNumber:UPPER_BOUND_SPEED] option:0];
            
        }
        
    }
    
}

- (void)clearBars{
    
    //everything that is not a bar is to stay on top
    for(UIView *view in self.view.subviews){
        
        if([view isKindOfClass:[MenuBarView class]]){
            
            MenuBarView *barView = (MenuBarView *)view;
            
            [barView fadeOut];
            
        }
        
    }
    
}

#pragma mark - AdViewDelegates

-(void)bannerView:(ADBannerView *)banner
didFailToReceiveAdWithError:(NSError *)error{
    NSLog(@"Error loading");
}

-(void)bannerViewDidLoadAd:(ADBannerView *)banner{
    NSLog(@"Ad loaded");
}
-(void)bannerViewWillLoadAd:(ADBannerView *)banner{
    NSLog(@"Ad will load");
}
-(void)bannerViewActionDidFinish:(ADBannerView *)banner{
    NSLog(@"Ad did finish");
    
}

#pragma mark - Helpers

- (NSInteger)getRandomNumberBetween:(NSInteger)min maxNumber:(NSInteger)max{
    
    return min + arc4random() % (max - min + 1);
    
}

- (float)getRandomDecimalBetween:(float)min maxNumber:(float)max{
    
    return ((float)arc4random() / ARC4RANDOM_MAX) * (max-min) + min;
    
}

@end
