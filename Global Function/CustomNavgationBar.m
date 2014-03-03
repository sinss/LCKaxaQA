//
//  CustomNavgationBar.m
//  MercuriesLife
//
//  Created by Eric Lin on 2010/9/24.
//  Copyright 2010 EraSoft. All rights reserved.
//

#import "CustomNavgationBar.h"

@implementation UINavigationBar (UINavigationBarCategory)

/*
 	自定 Navigation bar
 */

-(void)drawRect:(CGRect)rect
{
	[super drawRect:rect];
	[self setTintColor:navigationBarButtonColor];
    //[self setBackgroundColor:navigationBarColor];
	UIImage *img = [self createImageWithColor:navigationBarColor];
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