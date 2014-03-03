//
//  topicSelectViewController.h
//  KaxaQ&A
//
//  Created by sinss on 12/12/28.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol topicSelectAction <NSObject>

- (void)didSelectWithTopic:(NSInteger)topicInd;

@end

@interface topicSelectViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    id <topicSelectAction> delegate;
    NSInteger topicIndex;
    IBOutlet UITableView *aTableView;
}
@property (assign) id<topicSelectAction> delegate;
@property (assign) NSInteger topicIndex;


@end
