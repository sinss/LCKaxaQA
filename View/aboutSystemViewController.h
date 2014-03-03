//
//  aboutSystemViewController.h
//  KaxaQ&A
//
//  Created by 張星星 on 12/4/23.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import <UIKit/UIKit.h>

enum
{
    aboutSystemTableViewSectionVersion = 0,
    aboutSystemTableViewSectionIntro = 1
};
typedef NSUInteger aboutSystemTableViewSection;

@interface aboutSystemViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UITableView *systemTableView;
    NSArray *functionList;
}

@end
