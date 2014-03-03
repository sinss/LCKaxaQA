//
//  CustomToolBar.m
//  ClockReminder
//
//  Created by 張星星 on 11/12/21.
//  Copyright (c) 2011年 星星. All rights reserved.
//

#import "CustomToolBar.h"

@implementation UIToolbar (UIToolBarCategory)

-(void)drawRect:(CGRect)rect
{
	[super drawRect:rect];
	[self setTintColor:toolBarColor];
    [self setBackgroundColor:toolBarColor];
	UIImage *img = [self createImageWithColor:toolBarColor];
    [img drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}

- (UIImage*)createImageWithColor:(UIColor*)color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
