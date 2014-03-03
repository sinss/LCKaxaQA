//
//  customPickCourseViewController.h
//  KaxaQ&A
//
//  Created by 張星星 on 12/3/20.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import <UIKit/UIKit.h>

@class customPickCourseViewController;
@protocol pickerCourseDelegate <NSObject>

- (void) pickerCourseView:(customPickCourseViewController*)view didPickCourse:(NSInteger)courseIndex;

@end

@interface customPickCourseViewController : UIViewController
<UIPickerViewDelegate, UIPickerViewDataSource>
{
    IBOutlet UIPickerView *coursePicker;
    NSArray *courseArray;
    id<pickerCourseDelegate> delegate;
}
@property (assign) id<pickerCourseDelegate> delegate;
- (IBAction)closeButtonPress:(id)sender;
- (IBAction)confirmButtonPress:(id)sender;

@end
