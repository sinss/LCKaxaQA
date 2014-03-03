//
//  UIImage+Resize.h
//  ClockReminder
//
//  Created by 張星星 on 12/2/9.
//  Copyright (c) 2012年 星星. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImage (Resize)

- (UIImage*)imageByScalingToSize:(CGSize)targetSize;
- (UIImage *)fixOrientation;

@end
