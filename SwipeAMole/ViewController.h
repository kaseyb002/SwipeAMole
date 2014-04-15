//
//  ViewController.h
//  SwipeAMole
//
//  Created by Kasey Baughan on 4/7/14.
//  Copyright (c) 2014 Kasey Baughan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BarView.h"

@interface ViewController : UIViewController
- (IBAction)startOver:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *pointsLabel;

@property (strong, nonatomic) NSTimer *timer;

@property (nonatomic) int points;

@property (nonatomic) NSTimeInterval *timeInterval;

@property (nonatomic) int numberOfBarsOnScreen;

@property (weak, nonatomic) IBOutlet UILabel *fadeMessageLabel;

@property (weak, nonatomic) IBOutlet UILabel *averageIncrementLabel;

@end
