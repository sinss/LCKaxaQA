//
//  ForgotPasswordTableViewController.h
//  KaxaQ&A
//
//  Created by 張星星 on 12/2/1.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "customButtonCell.h"
#import "customTextfieldCell.h"
#import "forgotPasswordInfo.h"

enum
{
    forgotOptionAccount = 0,
    forgotOptionEmail = 1
};
typedef NSUInteger forgotOption;

@class ForgotPasswordTableViewController;
@protocol forgotPasswordTableViewDelegate <NSObject>

- (void)forgotPasswordView:(ForgotPasswordTableViewController*)view didLogin:(forgotPasswordInfo*)info;

@end

@interface ForgotPasswordTableViewController : UITableViewController
<customButtonDelegate, UITextFieldDelegate>
{
    NSArray *forgotArray;
    NSArray *placeholderArray;
    
    UITextField *accountField;
    UITextField *emailField;
    UITextField *currentField;
    
    forgotPasswordInfo *info;
    id<forgotPasswordTableViewDelegate> delegate;
}

@end
