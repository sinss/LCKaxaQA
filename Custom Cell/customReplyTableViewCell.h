//
//  customReplyTableViewCell.h
//  KaxaQ&A
//
//  Created by 張星星 on 12/4/7.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "customImgaeView.h"

@interface customReplyTableViewCell : UITableViewCell
{
    customImgaeView *myImageview;
    UILabel *titleField;
    UILabel *replyNameField;
    UILabel *dateTimeField;
    UILabel *educationField;
    UILabel *courseField;
}

@property (nonatomic, retain) IBOutlet UILabel *titleField;
@property (nonatomic, retain) IBOutlet UILabel *replyNameField;
@property (nonatomic, retain) IBOutlet UILabel *dateTimeField;
@property (nonatomic, retain) IBOutlet UILabel *educationField;
@property (nonatomic, retain) IBOutlet UILabel *courseField;

- (void)initImageViewWithUrl:(NSURL*)url andImageName:(NSString*)imageName;
- (void)initSmallImageViewWithUrl:(NSURL *)url andImageName:(NSString *)imageName;

@end
