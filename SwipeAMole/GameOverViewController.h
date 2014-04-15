//
//  GameOverViewController.h
//  SwipeAMole
//
//  Created by Kasey Baughan on 4/7/14.
//  Copyright (c) 2014 Kasey Baughan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface GameOverViewController : UIViewController <ADBannerViewDelegate>

- (IBAction)playAgain:(UIButton *)sender;

- (IBAction)mainMenu:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *pointsLabel;
@property (weak, nonatomic) IBOutlet UILabel *bestScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *gotNewHighScoreLabel;

@property (strong, nonatomic) ADBannerView *bannerView;

@property (nonatomic) int points;

@end
