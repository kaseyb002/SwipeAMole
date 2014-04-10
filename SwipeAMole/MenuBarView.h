//
//  MenuBarView.h
//  SwipeAMole
//
//  Created by Kasey Baughan on 4/8/14.
//  Copyright (c) 2014 Kasey Baughan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuBarView : UIView

- (void) moveTo:(CGPoint)destination viewToAnimate:(UIView *)view duration:(float)secs option:(UIViewAnimationOptions)option;

- (void)fadeOut;

- (void)fadeIn;

@end
