//
//  customQuestionCell.m
//  KaxaQ&A
//
//  Created by 張星星 on 12/2/3.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import "customQuestionCell.h"

@implementation customQuestionCell
@synthesize titleField,educationField,courseField;
@synthesize statusField,packageField, answerField;

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

- (void)initImageViewWithUrl:(NSURL*)url andImageName:(NSString*)imageName;
{
    CGRect frame = customQuestionImageFrame;
    myImageview = [[customImgaeView alloc] initWithFrame:frame andImageName:imageName andSmallInd:NO];
    [myImageview downloadAndDisplayImageWithURL:url];
    [self addSubview:myImageview];
}
- (void)initSmallImageViewWithUrl:(NSURL*)url andImageName:(NSString*)imageName
{
    CGRect frame = customQuestionSmallImageFrame
    myImageview = [[customImgaeView alloc] initWithFrame:frame andImageName:imageName andSmallInd:YES];
    [myImageview downloadAndDisplayImageWithURL:url];
    [self addSubview:myImageview];
}

- (void)dealloc
{
    [titleField release], titleField = nil;
    [educationField release], educationField = nil;
    [statusField release], statusField = nil;
    [packageField release], packageField = nil;
    [courseField release], courseField = nil;
    [answerField release], answerField = nil;
    [super dealloc];
}

@end
