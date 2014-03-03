//
//  customQuestionDetailCell2.h
//  KaxaQ&A
//
//  Created by sinss on 12/11/7.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "customImgaeView.h"

@class questionDetail, customQuestionDetailCell2;
@protocol questionDetailDelegate <NSObject>

- (void)questionDetailView:(customQuestionDetailCell2*)cell viewLargeImageWithImage:(UIImage*)image;
- (void)questionDetailView:(customQuestionDetailCell2*)cell viewYoutubeWithUrl:(NSURL*)url;

@end


@interface customQuestionDetailCell2 : UITableViewCell <customImageViewButtonDelegate>
{
    id <questionDetailDelegate> delegate;
    UILabel *titleLabel;
    UIScrollView *aScrollView;
    UILabel *subjectLabel;
    UILabel *degreeLabel;
    UIButton *contentButton;
    UIButton *youtubeButton;
    UILabel *askerLabel;
    UILabel *dateLabel;
    NSString *contentMessage;
    NSString *youtubeKey;
    NSString *askerid;
}
@property (assign) id <questionDetailDelegate> delegate;
@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UIScrollView *aScrollView;
@property (nonatomic, retain) IBOutlet UILabel *subjectLabel;
@property (nonatomic, retain) IBOutlet UILabel *degreeLabel;
@property (nonatomic, retain) IBOutlet UIButton *contentButton;
@property (nonatomic, retain) IBOutlet UIButton *youtubeButton;
@property (nonatomic, retain) IBOutlet UILabel *askerLabel;
@property (nonatomic, retain) IBOutlet UILabel *dateLabel;
@property (nonatomic, retain) NSString *contentMessage;
@property (nonatomic, retain) NSString *youtubeKey;
@property (nonatomic, retain) NSString *askerid;

- (IBAction)contentButtonPress:(id)sender;
- (IBAction)youtubeButtonPress:(id)sender;

- (void)setImageArrayWithImageArray:(NSArray*)imageArray andAskerId:(NSString*)uid;

@end
