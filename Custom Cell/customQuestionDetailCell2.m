//
//  customQuestionDetailCell2.m
//  KaxaQ&A
//
//  Created by sinss on 12/11/7.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import "customQuestionDetailCell2.h"
#import "questionDetail.h"

#define kImageUrl @"http://kaxa.org/images/upload/%@/%@"
#define kYoutubeUrl @"http://www.youtube.com/watch?v=%@"

@implementation customQuestionDetailCell2
@synthesize titleLabel, aScrollView, subjectLabel, degreeLabel, contentButton;
@synthesize askerLabel , dateLabel;
@synthesize delegate, contentMessage, youtubeKey, askerid, youtubeButton;

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
    [aScrollView release], aScrollView = nil;
    [subjectLabel release], subjectLabel = nil;
    [degreeLabel release], degreeLabel = nil;
    [contentButton release], contentButton = nil;
    [askerLabel release], askerLabel = nil;
    [dateLabel release], dateLabel = nil;
    [contentMessage release], contentMessage = nil;
    [youtubeKey release], youtubeKey = nil;
    [askerid release], askerid = nil;
    [super dealloc];
}

- (IBAction)contentButtonPress:(id)sender
{
    NSString *actionSheetString = [[NSString alloc] initWithFormat:@"%@",contentMessage];
    UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:actionSheetString delegate:nil cancelButtonTitle:NSLocalizedStringFromTable(@"Done", @"InfoPlist", nil) destructiveButtonTitle:nil otherButtonTitles:nil];
    popupQuery.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [popupQuery showInView:self];
    [popupQuery release];
    [actionSheetString release];
}

- (IBAction)youtubeButtonPress:(id)sender
{
    NSString *urlString = [NSString stringWithFormat:kYoutubeUrl, youtubeKey];
    
    [delegate questionDetailView:self viewYoutubeWithUrl:[NSURL URLWithString:urlString]];
}

- (void)setImageArrayWithImageArray:(NSArray*)imageArray andAskerId:(NSString*)uid
{
    [aScrollView setContentSize:CGSizeMake(320 * [imageArray count], aScrollView.bounds.size.height)];
    NSInteger counter = 0;
    for (NSString *name in imageArray)
    {
        NSString *urlString = [NSString stringWithFormat:kImageUrl, uid, name];
        CGRect frame = CGRectMake(0 + 320 * counter, 0, 320, aScrollView.bounds.size.height);
        customImgaeView *imageView = [[customImgaeView alloc] initWithFrame:frame andImageName:name andSmallInd:NO];
        [imageView setDelegate:self];
        [imageView setContentMode:UIViewContentModeScaleAspectFit];
        [imageView downloadAndDisplayImageWithURL:[NSURL URLWithString:urlString]];
        [aScrollView addSubview:imageView];
        [imageView release];
        
        counter ++;
    }
}

- (void)didPressButtonWithImage:(UIImage *)image
{
    [delegate questionDetailView:self viewLargeImageWithImage:image];
}

- (void)didPressButtonWithTag:(NSInteger)imageTag
{
    
}

@end
