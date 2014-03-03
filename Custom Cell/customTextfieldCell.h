//
//  customTextfieldCell.h
//  KaxaQ&A
//
//  Created by 張星星 on 12/1/31.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface customTextfieldCell : UITableViewCell
{
    UILabel *titleLabel;
    UITextField *contentField;
}
@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UITextField *contentField;

@end
