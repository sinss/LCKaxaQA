//
//  SignupTableViewController.h
//  KaxaQ&A
//
//  Created by 張星星 on 12/1/31.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "customTextfieldCell.h"
#import "customButtonCell.h"
#import "infoPanel.h"
#import "AccountCheck.h"
#import "loginInfo.h"

#define ksignupCount 5

enum
{
    signupOptionAccount = 0,
    signupOptionPassword = 1,
    signupOptionRePassword = 2,
    signupOptionName = 3,
    signupOptionNickname = 4
};
typedef NSUInteger signupOption;

@class SignupTableViewController;
@protocol signupTableViewDelegate <NSObject>

- (void)signupTableView:(SignupTableViewController*)signupView didFinishSignup:(loginInfo*)info;

@end

@interface SignupTableViewController : UITableViewController
<UITextFieldDelegate, customButtonDelegate, AccountCheckDelegate>
{
    id<signupTableViewDelegate> delegate;
    NSArray *signupArray;
    NSArray *placeholderArray;
    
    //用來紀錄目前的控制項
    UITextField *accountField;
    UITextField *passwordField;
    UITextField *rePasswordField;
    UITextField *nameField;
    UITextField *nickNameField;
    UITextField *currentField;
    
    AccountCheck *acctCheck;
    loginInfo *accountInfo;
}
@property (assign) id<signupTableViewDelegate> delegate;
@property (nonatomic, retain) UITextField *accountField;
@property (nonatomic, retain) UITextField *passwordField;
@property (nonatomic, retain) UITextField *rePasswordField;
@property (nonatomic, retain) UITextField *nameField;
@property (nonatomic, retain) UITextField *nickNameField;
@property (nonatomic, retain) UITextField *currentField;
@end
