//
//  loginTableViewController.h
//  KaxaQ&A
//
//  Created by 張星星 on 12/1/30.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "textfieldCell.h"
#import "customTextfieldCell.h"
#import "customButtonCell.h"
#import "loginInfo.h"
#import "AccountCheck.h"
#import "infoPanel.h"

enum
{
    loginFieldOptionAccount = 0,
    loginFieldOptionPassword = 1
};
typedef NSUInteger loginFieldOption;

enum
{
    loginButtonOptionLogin = 1,
    loginButtonOptionClear = 2
};
typedef NSUInteger loginButtonOption;

@class loginTableViewController;
@protocol loginTableViewDelegate <NSObject>

- (void)loginTableview:(loginTableViewController*)loginView didLogin:(loginInfo*)info;

@end

@interface loginTableViewController : UITableViewController
<UITextFieldDelegate, customButtonDelegate, AccountCheckDelegate>
{
    NSArray *loginArray;
    NSArray *placeholderArray;
    
    UITextField *accountField;
    UITextField *passwordField;
    UITextField *currentField;
    
    AccountCheck *acctCheck;
    loginInfo *accountInfo;
    id<loginTableViewDelegate> delegate;
}

@property (assign) id<loginTableViewDelegate> delegate;
@end
