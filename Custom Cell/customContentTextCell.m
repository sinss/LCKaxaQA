//
//  customContentTextCell.m
//  KaxaQ&A
//
//  Created by 張星星 on 12/3/23.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import "customContentTextCell.h"

@implementation customContentTextCell

@synthesize contentTextView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc
{
    [contentTextView release], contentTextView = nil;
    [super dealloc];
}

@end
