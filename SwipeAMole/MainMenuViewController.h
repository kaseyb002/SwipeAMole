//
//  MainMenuViewController.h
//  SwipeAMole
//
//  Created by Kasey Baughan on 4/8/14.
//  Copyright (c) 2014 Kasey Baughan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainMenuViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *play;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
- (IBAction)play:(UIButton *)sender;

@end
