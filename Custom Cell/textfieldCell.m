//
//  textfieldCell.m
//  KaxaQ&A
//
//  Created by 張星星 on 12/1/30.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import "textfieldCell.h"

@implementation textfieldCell

@synthesize accountTextField;
@synthesize passwordTextField;
@synthesize keepAccountSwitch;
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
#pragma mark - UITextField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    switch (textField.tag)
    {
        case 0:
            [passwordTextField becomeFirstResponder];
            break;
        case 1:
            [textField resignFirstResponder];
            break;
    }
    return YES;
}
#pragma mark - user define functions
- (IBAction)loginButtonPress:(id)sender
{
    NSString *account = [accountTextField text];
    NSString *password = [passwordTextField text];
    BOOL keepInd = keepAccountSwitch.on;
    [delegate textfieldCell:self didPressLoginButtonWithAccount:account andPassword:password andKeepInd:keepInd];
}
- (IBAction)resetButtonPress:(id)sender
{
    [accountTextField setText:@""];
    [passwordTextField setText:@""];
}

- (void)dealloc
{
    [accountTextField release], accountTextField = nil;
    [passwordTextField release], passwordTextField = nil;
    [keepAccountSwitch release], keepAccountSwitch = nil;
    delegate = nil;
    [super dealloc];
}

@end
