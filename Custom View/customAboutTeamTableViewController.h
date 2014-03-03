//
//  customAboutTeamTableViewController.h
//  KaxaQ&A
//
//  Created by 張星星 on 12/3/23.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "customContentTextCell.h"
#import "customSingleLabelCell.h"
enum
{
    aboutTeamTableViewSectionCompany = 0,
    aboutTeamTableViewSectionIntro = 1,
    aboutTeamTableViewSectionPurpose = 2
};
typedef NSUInteger aboutTeamTableViewSection;

@interface customAboutTeamTableViewController : UITableViewController

@end
