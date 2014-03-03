//
//  customButtonCell.h
//  KaxaQ&A
//
//  Created by 張星星 on 12/2/1.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import <UIKit/UIKit.h>

@class customButtonCell;
@protocol customButtonDelegate <NSObject>

- (void)didSendButtonPress:(NSInteger)buttonTag;

@end

@interface customButtonCell : UITableViewCell
{
    UIButton *celButton;
    id<customButtonDelegate> delegate;
}
@property (nonatomic, retain) IBOutlet UIButton *cellButton;
@property (assign) id<customButtonDelegate> delegate;

- (IBAction)cellButtonPress:(UIButton*)sender;

@end
