//
//  LPPullIndicatorControl.h
//  PullActivityControl
//
//  Created by Penny on 25/02/13.
//  Copyright (c) 2013 Penny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LPPullIndicatorControl : UIView
@property (nonatomic, assign) CGFloat maxValue;
@property (nonatomic, assign) CGFloat progress;

- (BOOL)isReadToRefresh;
@end
