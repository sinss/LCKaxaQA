//
//  CustomSearchBar.m
//  KaxaQ&A
//
//  Created by 張星星 on 12/1/31.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import "CustomSearchBar.h"

@implementation CustomSearchBar

@synthesize inputAccessoryView;

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    [self setTintColor:searchBarBackgroundColor];
}

@end
