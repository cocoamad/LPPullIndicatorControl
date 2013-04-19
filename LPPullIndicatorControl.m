//
//  LPPullIndicatorControl.m
//  PullActivityControl
//
//  Created by Penny on 25/02/13.
//  Copyright (c) 2013 Penny. All rights reserved.
//

#import "LPPullIndicatorControl.h"
#define radius 100
CGFloat DegreesToRadians(CGFloat degrees) {return degrees * M_PI / 180;}

@interface LPPullIndicatorControl()
@property (nonatomic, assign) CGFloat start;
@property (nonatomic, assign) CGFloat end;
@end
@implementation LPPullIndicatorControl

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.start = 90;
        self.end = 90;
    }
    return self;
}

- (void)setProgress:(CGFloat)progress
{

    if (progress < 0) {
        if (fabs(progress) < 10)
            return;
        CGFloat value = (progress + 10) / self.maxValue;
        if (value == 1)
            return;
        self.start = 90 + value * 180;
        self.end = 90 - value * 180;
    } else {
        if (progress < 20) {
            return;
        }
        CGFloat value = (progress - 20) / self.maxValue;
        if (value == 1)
            return;
        self.start = -90 - value * 180;
        self.end =  -90 + value * 180;
    }
    [self setNeedsDisplay];
}

- (BOOL)isReadToRefresh
{
    if (self.isHidden) {
        return NO;
    }
    return (self.end - self.start) >= 360;
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(ctx);
    CGContextSetFillColorWithColor(ctx, [UIColor colorWithRed: 237. / 255 green: 237. / 255 blue: 237. / 255 alpha: 1].CGColor);
    CGContextFillEllipseInRect(ctx, self.bounds);
    CGContextRestoreGState(ctx);
    
    CGContextSaveGState(ctx);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddArc(path, nil, CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds), self.bounds.size.height / 2, DegreesToRadians(self.start), DegreesToRadians(self.end), 0);
    CGPathAddLineToPoint(path, NULL, self.bounds.size.height / 2, self.bounds.size.height / 2);
	CGPathCloseSubpath(path);
    CGContextAddPath(ctx, path);
    
    [[UIColor redColor] setFill];
    CGContextDrawPath(ctx, kCGPathFill);
    CGPathRelease(path);
    CGContextRestoreGState(ctx);
    
    CGContextSaveGState(ctx);
    CGContextSetFillColorWithColor(ctx, [UIColor whiteColor].CGColor);
    CGContextFillEllipseInRect(ctx, CGRectInset(self.bounds, self.bounds.size.height / 10, self.bounds.size.height / 10));
    CGContextRestoreGState(ctx);
}

@end
