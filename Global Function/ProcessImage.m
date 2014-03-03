//
//  ProcessImage.m
//  ManageXml
//
//  Created by 張星星 sinss on 11/10/8.
//  Copyright 2011年 張星星. All rights reserved.
//

#import "ProcessImage.h"

static ProcessImage *_instance;

@implementation ProcessImage

+ (ProcessImage*) shareInstance
{
    @synchronized(self)
    {
        if (_instance == nil)
        {
            _instance = [[super allocWithZone:NULL] init];
        }
    }
    return _instance;
}

- (void)saveImage:(UIImage*)image imageName:(NSString*)imageName
{  
    //convert image into .png format.  
    NSData *imageData = UIImagePNGRepresentation(image);
    float imageSize = [imageData length];
    float rate = 300000 / imageSize;
    if ([imageData length] >= 300000)
        imageData = UIImageJPEGRepresentation(image, rate);
    NSLog(@"size:%d",[imageData length]);
    
    //309194   300K
    //7422822   7M
    //固定將檔案縮小為100k
    
    NSFileManager *fileManager = [NSFileManager defaultManager];  
    
    [fileManager createFileAtPath:imageName contents:imageData attributes:nil];
    NSLog(@"image saved:%@",imageName);
}
- (void)removeImage:(NSString*)fileName
{  
    
    NSFileManager *fileManager = [NSFileManager defaultManager];  
    
    [fileManager removeItemAtPath:fileName error:NULL];
    NSLog(@"%@ image removed",fileName);
    
}  
- (UIImage*)loadImage:(NSString*)imageName
{  
    NSLog(@"%@ loaded",imageName);
    
    return [UIImage imageWithContentsOfFile:imageName];  
    
} 
- (UIImage*)imageWithImage:(UIImage*)sourceImage scaledToSizeWithSameAspectRatio:(CGSize)targetSize
{
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO) {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor) {
            scaleFactor = widthFactor; // scale to fit height
        }
        else {
            scaleFactor = heightFactor; // scale to fit width
        }
        
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor) {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else if (widthFactor < heightFactor) {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    CGImageRef imageRef = [sourceImage CGImage];
    CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(imageRef);
    CGColorSpaceRef colorSpaceInfo = CGImageGetColorSpace(imageRef);
    
    if (bitmapInfo == kCGImageAlphaNone) {
        bitmapInfo = kCGImageAlphaNoneSkipLast;
    }
    
    CGContextRef bitmap;
    
    if (sourceImage.imageOrientation == UIImageOrientationUp ||sourceImage.imageOrientation == UIImageOrientationDown) {
        bitmap = CGBitmapContextCreate(NULL, targetWidth, targetHeight,CGImageGetBitsPerComponent(imageRef),CGImageGetBytesPerRow(imageRef), colorSpaceInfo, bitmapInfo);
        
    } else {
        bitmap = CGBitmapContextCreate(NULL, targetHeight, targetWidth,CGImageGetBitsPerComponent(imageRef),CGImageGetBytesPerRow(imageRef), colorSpaceInfo, bitmapInfo);
        
    }
    
    // In the right or left cases, we need to switch scaledWidth and scaledHeight,
    // and also the thumbnail point
    if (sourceImage.imageOrientation == UIImageOrientationLeft) {
        thumbnailPoint = CGPointMake(thumbnailPoint.y, thumbnailPoint.x);
        CGFloat oldScaledWidth = scaledWidth;
        scaledWidth = scaledHeight;
        scaledHeight = oldScaledWidth;
        CGContextRotateCTM (bitmap, radians(90));
        CGContextTranslateCTM (bitmap, 0, -targetHeight);
        
    } else if (sourceImage.imageOrientation ==UIImageOrientationRight) {
        thumbnailPoint = CGPointMake(thumbnailPoint.y, thumbnailPoint.x);
        CGFloat oldScaledWidth = scaledWidth;
        scaledWidth = scaledHeight;
        scaledHeight = oldScaledWidth;
        
        CGContextRotateCTM (bitmap, radians(-90));
        CGContextTranslateCTM (bitmap, -targetWidth, 0);
        
    } else if (sourceImage.imageOrientation == UIImageOrientationUp) {
        // NOTHING
    } else if (sourceImage.imageOrientation == UIImageOrientationDown){
        CGContextTranslateCTM (bitmap, targetWidth, targetHeight);
        CGContextRotateCTM (bitmap, radians(-180.));
    }
    
    CGContextDrawImage(bitmap, CGRectMake(thumbnailPoint.x,thumbnailPoint.y, scaledWidth, scaledHeight), imageRef);
    CGImageRef ref = CGBitmapContextCreateImage(bitmap);
    UIImage* newImage = [UIImage imageWithCGImage:ref];
    
    CGContextRelease(bitmap);
    CGImageRelease(ref);
    
    return newImage;
} 
static inline double radians (double degrees) 
{
    return degrees * M_PI/180;
}
@end
