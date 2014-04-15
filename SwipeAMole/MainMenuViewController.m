//
//  MainMenuViewController.m
//  SwipeAMole
//
//  Created by Kasey Baughan on 4/8/14.
//  Copyright (c) 2014 Kasey Baughan. All rights reserved.
//

#define ARC4RANDOM_MAX 0x100000000
#define NUMBER_OF_BARS_TO_SHOW 10
#define UPPER_BOUND_SPEED 7.0
#define LOWER_BOUND_SPEED 1.5
#define BAR_REFRESH_TIME_INTERVAL 10.0

#import "MainMenuViewController.h"
#import "MenuBarView.h"
#import "GameOverViewController.h"

@interface MainMenuViewController ()

@property (strong, nonatomic) NSTimer *timer;

@end

@implementation MainMenuViewController

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
    
    //iad stuff
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    self.bannerView = [[ADBannerView alloc]initWithFrame:
                       CGRectMake(0, screenRect.size.height - 50, 320, 50)];
    self.bannerView.delegate = self;
    // Optional to set background color to clear color
    [self.bannerView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview: self.bannerView];
    //end iad stuff
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    
    self.navigationController.navigationBar.hidden = YES;
    
    [self refreshBars:nil];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:BAR_REFRESH_TIME_INTERVAL
                                     target:self
                                   selector:@selector(refreshBars:)
                                   userInfo:nil
                                    repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];

    
}

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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)play:(UIButton *)sender {
    
    [self performSegueWithIdentifier:@"Play" sender:nil];
}



#pragma mark - Helpers

- (NSInteger)getRandomNumberBetween:(NSInteger)min maxNumber:(NSInteger)max{
    
    return min + arc4random() % (max - min + 1);
    
}

- (float)getRandomDecimalBetween:(float)min maxNumber:(float)max{
    
    return ((float)arc4random() / ARC4RANDOM_MAX) * (max-min) + min;
    
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

@end
