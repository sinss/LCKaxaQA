//
//  customSystemTableViewController.h
//  KaxaQ&A
//
//  Created by 張星星 on 12/3/23.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "customContentTextCell.h"

enum
{
    aboutSystemTableViewSectionVersion = 0,
    aboutSystemTableViewSectionIntro = 1
};
typedef NSUInteger aboutSystemTableViewSection;

@interface customSystemTableViewController : UITableViewController
{
    NSArray *functionList;
}

@end
