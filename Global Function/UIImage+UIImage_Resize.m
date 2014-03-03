//
//  UIImage+UIImage_Resize.m
//  KaxaQ&A
//
//  Created by 張星星 on 12/4/2.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import "UIImage+UIImage_Resize.h"

@implementation UIImage (UIImage_Resize)

- (UIImage*)transformWidth:(CGFloat)width height:(CGFloat)height 
{
    
    CGFloat destW = width;
    CGFloat destH = height;
    CGFloat sourceW = width;
    CGFloat sourceH = height;
    
    CGImageRef imageRef = self.CGImage;
    CGContextRef bitmap = CGBitmapContextCreate(NULL, 
                                                destW, 
                                                destH,
                                                CGImageGetBitsPerComponent(imageRef), 
                                                4*destW, 
                                                CGImageGetColorSpace(imageRef),
                                                (kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst));
    
    CGContextDrawImage(bitmap, CGRectMake(0, 0, sourceW, sourceH), imageRef);
    
    CGImageRef ref = CGBitmapContextCreateImage(bitmap);
    UIImage *result = [UIImage imageWithCGImage:ref];
    CGContextRelease(bitmap);
    CGImageRelease(ref);
    
    return result;
}
-(UIImage*)scaleToSize:(CGSize)size 
{ 
    // 创建一个bitmap的context 
    // 并把它设置成为当前正在使用的context 
    UIGraphicsBeginImageContext(size); 
    // 绘制改变大小的图片 
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)]; 
    // 从当前context中创建一个改变大小后的图片 
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext(); 
    // 使当前的context出堆栈 
    UIGraphicsEndImageContext(); 
    // 返回新的改变大小后的图片 
    return scaledImage; 
} 
- (UIImage*)compressImageDownToPhoneScreenSize:(UIImage*)theImage
{
    
    UIImage * bigImage = theImage;
    
    float actualHeight = bigImage.size.height;
    float actualWidth = bigImage.size.width;
    
    float imgRatio = actualWidth / actualHeight;
    float maxRatio = 480.0 / 640;
    
    if( imgRatio != maxRatio )
    {
        if(imgRatio < maxRatio)
        {
            imgRatio = 480.0 / actualHeight;
            actualWidth = imgRatio * actualWidth;
            actualHeight = 480.0;
        }
        else 
        {
            imgRatio = 320.0 / actualWidth;
            actualHeight = imgRatio * actualHeight; 
            actualWidth = 320.0;
        }
        
    }
    
    CGRect rect = CGRectMake(0.0, 0.0, actualWidth, actualHeight);
    UIGraphicsBeginImageContext(rect.size);
    [bigImage drawInRect:rect]; // scales image to rect
    theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //RETURN
    return theImage;
    
}

@end
