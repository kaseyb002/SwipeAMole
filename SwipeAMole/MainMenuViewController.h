//
//  MainMenuViewController.h
//  SwipeAMole
//
//  Created by Kasey Baughan on 4/8/14.
//  Copyright (c) 2014 Kasey Baughan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface MainMenuViewController : UIViewController <ADBannerViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *play;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
- (IBAction)play:(UIButton *)sender;

@property (strong, nonatomic) ADBannerView *bannerView;

@end
