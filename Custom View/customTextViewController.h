//
//  customTextViewController.h
//  KaxaQ&A
//
//  Created by 張星星 on 12/2/8.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "infoPanel.h"

@class customTextViewController;
@protocol customTextViewDelegate <NSObject>

- (void)customTextView:(customTextViewController*)view didConfirmButtonPressWithContent:(NSString*)contentText;

@end

@interface customTextViewController : UIViewController <UITextViewDelegate>
{
    IBOutlet UINavigationBar *navBar;
    IBOutlet UITextView *contentTextView;
    id<customTextViewDelegate> delegate;
    NSString *currentString;
}
@property (nonatomic, retain) NSString *currentString;
@property (assign) id<customTextViewDelegate> delegate;

- (IBAction)confirmButtonPress:(id)sender;
- (IBAction)closeButtonPress:(id)sender;

@end
