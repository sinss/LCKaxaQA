//
//  sytemTableViewController.h
//  KaxaQ&A
//
//  Created by 張星星 on 12/4/9.
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


@interface sytemTableViewController : UITableViewController
{
    NSArray *functionList;
}
@end
