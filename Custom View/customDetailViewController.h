//
//  customDetailViewController.h
//  KaxaQ&A
//
//  Created by 張星星 on 12/4/12.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "newsInfo2.h"
#import "MyPostDelegate.h"

@interface customDetailViewController : UIViewController <postDelegate>
{
    IBOutlet UITextView *contentView;
    newsInfo2 *currentInfo;
    NSArray *newsDetailArray;
    UIAlertView *alert;
    BOOL alertNeedClose;
    MyPostDelegate *poster;
    
}
@property (nonatomic, retain) newsInfo2 *currentInfo;

@end
