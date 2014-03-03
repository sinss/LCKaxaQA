//
//  signupCell.m
//  KaxaQ&A
//
//  Created by 張星星 on 12/1/31.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import "signupCell.h"

@implementation signupCell
@synthesize delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
    {
        // Initialization code
        if (info == nil)
        {
            info = [[SignupInfo alloc] init];
        }
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)signupButtonPress:(id)sender
{
    [info setAccountID:[accountField text]];
    [info setPassword:[passwordField text]]; 
    [info setUserName:[userNameField text]];
    [info setEmail:[emailField text]];
    [delegate signupCell:self didSignup:info];
}

- (void)dealloc
{
    delegate = nil;
    [super dealloc];
}
@end
