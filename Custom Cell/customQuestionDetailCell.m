//
//  customQuestionDetailCell.m
//  KaxaQ&A
//
//  Created by 張星星 on 12/2/5.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import "customQuestionDetailCell.h"

@implementation customQuestionDetailCell

@synthesize delegate;

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
- (void)initImageViewWithUrl:(NSURL*)url andImageName:(NSString*)imageName
{
    CGRect frame = CGRectMake(20, 10, 280, 180);
    imageView = [[customImgaeView alloc] initWithFrame:frame andImageName:imageName andSmallInd:NO];
    [imageView downloadAndDisplayImageWithURL:url];
    [self addSubview:imageView];
}

#pragma mark - touch event
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [delegate questionDetail:self didViewLargeImage:0 withImage:[imageView getImage]];
}
- (IBAction)viewLargeButtonPress:(UIButton*)sender
{
    [delegate questionDetail:self didViewLargeImage:[sender tag] withImage:[imageView getImage]];
}
- (IBAction)saveImageButtonPress:(UIButton*)sender
{
    [delegate questionDetail:self didSaveImage:[sender tag] withImage:[imageView getImage]];
}

- (void)dealloc
{
    delegate = nil;
    [super dealloc];
}

@end
