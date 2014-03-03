//
//  ProcessImage.h
//  ManageXml
//
//  Created by 張星星 sinss on 11/10/8.
//  Copyright 2011年 張星星. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProcessImage : NSObject

+ (ProcessImage*)shareInstance;

- (void)saveImage:(UIImage*)image imageName:(NSString*)imageName;
- (void)removeImage:(NSString*)fileName;
- (UIImage*)loadImage:(NSString*)imageName;
- (UIImage*)imageWithImage:(UIImage*)sourceImage scaledToSizeWithSameAspectRatio:(CGSize)targetSize;
static inline double radians (double degrees);

@end
