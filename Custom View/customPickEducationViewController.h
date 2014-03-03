//
//  customPickEducationViewController.h
//  KaxaQ&A
//
//  Created by 張星星 on 12/3/20.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import <UIKit/UIKit.h>
@class customPickEducationViewController;
@protocol pickerEducationDelegate <NSObject>

- (void) pickerCourseView:(customPickEducationViewController*)view didPickEducation:(NSInteger)educationIndex;

@end

@interface customPickEducationViewController : UIViewController
<UIPickerViewDelegate, UIPickerViewDataSource>
{
    IBOutlet UIPickerView *educationPicker;
    NSArray *educationArray;
    id<pickerEducationDelegate> delegate;
}

@property (assign) id<pickerEducationDelegate> delegate;

- (IBAction)closeButtonPress:(id)sender;
- (IBAction)confirmButtonPress:(id)sender;

@end
