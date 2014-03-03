//
//  customSingleTextFieldCell.h
//  KaxaQ&A
//
//  Created by 張星星 on 12/3/26.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface customSingleTextFieldCell : UITableViewCell
{
    UITextField *contentTextField;
}
@property (nonatomic, retain) IBOutlet UITextField *contentTextField;

@end
