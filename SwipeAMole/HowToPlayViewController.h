//
//  HowToPlayViewController.h
//  SwipeAMole
//
//  Created by Kasey Baughan on 4/10/14.
//  Copyright (c) 2014 Kasey Baughan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HowToPlayViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *instructionLabel;
- (IBAction)done:(UIButton *)sender;

@end
