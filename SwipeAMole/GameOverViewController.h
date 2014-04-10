//
//  GameOverViewController.h
//  SwipeAMole
//
//  Created by Kasey Baughan on 4/7/14.
//  Copyright (c) 2014 Kasey Baughan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameOverViewController : UIViewController

- (IBAction)playAgain:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *pointsLabel;

@property (nonatomic) int points;

@end
