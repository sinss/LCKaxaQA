//
//  SettingTableViewController.h
//  KaxaQ&A
//
//  Created by 張星星 on 12/1/18.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "loginTableViewController.h"
#import "SignupTableViewController.h"
#import "ForgotPasswordTableViewController.h"
#import "aboutSystemViewController.h"
#import "aboutTeamViewController.h"
#import "infoPanel.h"

enum 
{
    settingTableViewSectionMyAccount = 0,
    settingTableViewSectionAbountUs = 1
};
typedef NSUInteger settingTableViewSection;
enum
{
    accountOptionMyAccount = 0,
    accountOptionCreateAccount = 1,
    accountOptionForgotPassword = 2
};
typedef NSUInteger accountOption;

enum
{
    aboutusOptionAboutSystem = 0,
    aboutusOptionAboutTeam = 1,
    aboutusOptionContactUs = 2
};
typedef NSUInteger aboutusOption;

@interface SettingTableViewController : UITableViewController 
<loginTableViewDelegate ,signupTableViewDelegate ,MFMailComposeViewControllerDelegate>
{
    NSArray *groupArray;
    NSArray *accountFunctionArray;
    NSArray *systemFunctionArray;
}

@end
