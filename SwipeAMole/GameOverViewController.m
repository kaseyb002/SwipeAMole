//
//  GameOverViewController.m
//  SwipeAMole
//
//  Created by Kasey Baughan on 4/7/14.
//  Copyright (c) 2014 Kasey Baughan. All rights reserved.
//

#import "GameOverViewController.h"

@interface GameOverViewController ()

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
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)playAgain:(UIButton *)sender {
    
    [self performSegueWithIdentifier:@"playAgain" sender:nil];
    
}

- (IBAction)mainMenu:(UIButton *)sender {
    
    [self performSegueWithIdentifier:@"mainMenu" sender:nil];
    
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
