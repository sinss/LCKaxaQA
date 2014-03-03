//
//  customReplyTableViewCell.m
//  KaxaQ&A
//
//  Created by 張星星 on 12/4/7.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import "customReplyTableViewCell.h"

@implementation customReplyTableViewCell

@synthesize titleField,educationField,courseField;
@synthesize replyNameField,dateTimeField;

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

- (void)initImageViewWithUrl:(NSURL*)url andImageName:(NSString*)imageName;
{
    CGRect frame = customQuestionImageFrame;
    myImageview = [[customImgaeView alloc] initWithFrame:frame andImageName:imageName andSmallInd:NO];
    [myImageview downloadAndDisplayImageWithURL:url];
    [self addSubview:myImageview];
}
- (void)initSmallImageViewWithUrl:(NSURL *)url andImageName:(NSString *)imageName
{
    CGRect frame = customQuestionSmallImageFrame;
    myImageview = [[customImgaeView alloc] initWithFrame:frame andImageName:imageName andSmallInd:YES];
    [myImageview downloadAndDisplayImageWithURL:url];
    [self addSubview:myImageview];
}

- (void)dealloc
{
    [titleField release], titleField = nil;
    [educationField release], educationField = nil;
    [courseField release], courseField = nil;
    [replyNameField release], replyNameField = nil;
    [dateTimeField release], dateTimeField = nil;
    [super dealloc];
}
@end
