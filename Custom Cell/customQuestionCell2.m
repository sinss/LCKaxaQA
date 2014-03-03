//
//  customQuestionCell2.m
//  KaxaQ&A
//
//  Created by sinss on 12/11/6.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import "customQuestionCell2.h"

@implementation customQuestionCell2
@synthesize themeLabel, titleLabel, subjectLabel, degreeLabel, askerLabel, dateLabel;

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
    [themeLabel release], themeLabel = nil;
    [titleLabel release], titleLabel = nil;
    [subjectLabel release], subjectLabel = nil;
    [degreeLabel release], degreeLabel = nil;
    [askerLabel release], askerLabel = nil;
    [dateLabel release], dateLabel = nil;
    [super dealloc];
}

@end
