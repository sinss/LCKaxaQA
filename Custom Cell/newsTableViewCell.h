//
//  newsTableViewCell.h
//  KaxaQ&A
//
//  Created by sinss on 12/9/29.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface newsTableViewCell : UITableViewCell
{
    UILabel *titleLabel;
    UITextView *contentTextView;
}

@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UITextView *contentTextView;

@end
