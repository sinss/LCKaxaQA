//
//  customQuestionCell2.h
//  KaxaQ&A
//
//  Created by sinss on 12/11/6.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface customQuestionCell2 : UITableViewCell
{
    UILabel *themeLabel;
    UILabel *titleLabel;
    UILabel *subjectLabel;
    UILabel *degreeLabel;
    UILabel *dateLabel;
    UILabel *askerLabel;
}
@property (nonatomic, retain) IBOutlet UILabel *themeLabel;
@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UILabel *subjectLabel;
@property (nonatomic, retain) IBOutlet UILabel *degreeLabel;
@property (nonatomic, retain) IBOutlet UILabel *dateLabel;
@property (nonatomic, retain) IBOutlet UILabel *askerLabel;

@end
