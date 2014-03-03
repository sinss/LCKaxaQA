//
//  newsTableViewCell.m
//  KaxaQ&A
//
//  Created by sinss on 12/9/29.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import "newsTableViewCell.h"

@implementation newsTableViewCell
@synthesize titleLabel, contentTextView;

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
    [titleLabel release], titleLabel = nil;
    [contentTextView release], contentTextView = nil;
    [super dealloc];
}
@end
