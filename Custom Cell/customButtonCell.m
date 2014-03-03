//
//  customButtonCell.m
//  KaxaQ&A
//
//  Created by 張星星 on 12/2/1.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import "customButtonCell.h"

@implementation customButtonCell
@synthesize cellButton, delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)cellButtonPress:(UIButton*)sender
{
    [delegate didSendButtonPress:sender.tag];
}

- (void)dealloc
{
    [cellButton release], cellButton = nil;
    delegate = nil;
    [super dealloc];
}

@end
