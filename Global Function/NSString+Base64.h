//
//  NSString+Base64.h
//  KaxaQ&A
//
//  Created by 張星星 on 12/3/29.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Base64)

+ (NSString *) base64StringFromData:(NSData *)data length:(int)length;

@end
