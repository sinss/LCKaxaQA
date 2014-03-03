//
//  customContentTextCell.h
//  KaxaQ&A
//
//  Created by 張星星 on 12/3/23.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface customContentTextCell : UITableViewCell
{
    UITextView *contentTextView;
}
@property (nonatomic, retain) IBOutlet UITextView *contentTextView;

@end
