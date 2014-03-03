//
//  UIImage+UIImage_Resize.h
//  KaxaQ&A
//
//  Created by 張星星 on 12/4/2.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (UIImage_Resize)

- (UIImage*)transformWidth:(CGFloat)width height:(CGFloat)height;
-(UIImage*)scaleToSize:(CGSize)size;

@end
