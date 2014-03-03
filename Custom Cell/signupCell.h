//
//  signupCell.h
//  KaxaQ&A
//
//  Created by 張星星 on 12/1/31.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignupInfo.h"

@class signupCell;
@protocol signupDelegate <NSObject>

- (void)signupCell:(signupCell*)cell didSignup:(SignupInfo*)info;

@end

@interface signupCell : UITableViewCell
{
    IBOutlet UITextField *accountField;
    IBOutlet UITextField *passwordField;
    IBOutlet UITextField *rePasswordField;
    IBOutlet UITextField *userNameField;
    IBOutlet UITextField *emailField;
    SignupInfo *info;
    id<signupDelegate> delegate;
}

@property (assign) id<signupDelegate> delegate;

- (IBAction)signupButtonPress:(id)sender;

@end
