//
//  customQuestionCell.h
//  KaxaQ&A
//
//  Created by 張星星 on 12/2/3.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "customImgaeView.h"

@interface customQuestionCell : UITableViewCell
{
    customImgaeView *myImageview;
    UILabel *titleField;
    UILabel *statusField;
    UILabel *packageField;
    UILabel *educationField;
    UILabel *courseField;
    UILabel *answerField;
}

@property (nonatomic, retain) IBOutlet UILabel *titleField;
@property (nonatomic, retain) IBOutlet UILabel *statusField;
@property (nonatomic, retain) IBOutlet UILabel *packageField;
@property (nonatomic, retain) IBOutlet UILabel *educationField;
@property (nonatomic, retain) IBOutlet UILabel *courseField;
@property (nonatomic, retain) IBOutlet UILabel *answerField;

- (void)initImageViewWithUrl:(NSURL*)url andImageName:(NSString*)imageName;
- (void)initSmallImageViewWithUrl:(NSURL*)url andImageName:(NSString*)imageName;


@end
