//
//  MyPictureTableViewCell.m
//  ClockReminder
//
//  Created by 張星星 on 11/12/15.
//  Copyright (c) 2011年 星星. All rights reserved.
//

#import "MyPictureTableViewCell.h"

@implementation MyPictureTableViewCell
@synthesize delegate;
@synthesize reminderImage;
@synthesize reminderImageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
    {
        // Initialization code
    }
    return self;
}
- (void)setButtonImage
{
    [takePictureButton setBackgroundImage:pictureCellTakcPictureButton forState:UIControlStateNormal];
    [viewLargeButton setBackgroundImage:pictureCellViewLargePictureButton forState:UIControlStateNormal];
    [reminderImageView setImage:[UIImage imageNamed:noImageName]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
}
- (IBAction)pressTakeNewPictureButton:(id)sender
{
    [delegate MyPictureTableViewCell:self didPressButton:MyPictureTableViewCellButtonTypeTakeNewPicture];
}
- (IBAction)pressViewOriginPictureButton:(id)sender
{
    [delegate MyPictureTableViewCell:self didPressButton:MyPictureTableviewCellButtonTypeViewOriginalPciture];
}
#pragma mark - touch event
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [delegate MyPictureTableViewCell:self didPressButton:MyPictureTableviewCellButtonTypeViewOriginalPciture];
}

- (void)dealloc
{
    delegate = nil;
    [reminderImage release], reminderImage = nil;
    [reminderImageView release], reminderImageView = nil;
    [super dealloc];
}

@end
