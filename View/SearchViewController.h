//
//  SearchViewController.h
//  KaxaQ&A
//
//  Created by 張星星 on 12/1/30.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomSearchBar.h"

#import "NVUIGradientButton.h"

#define kComponentNumber 1

enum 
{
    searchComponentOptionEducation = 0,
    searchComponentOptionCourse = 1
};
typedef NSUInteger searchComponentOption;

@class SearchViewController;
@protocol SearchViewDelegate <NSObject>

- (void)searchViewController:(SearchViewController*)view didSearchWithKeyword:(NSString*)keyword andEducationIndex:(NSInteger)eduInd andCourseIndex:(NSInteger)courseInd;

@end

@interface SearchViewController : UIViewController 
<UIPickerViewDataSource, UIPickerViewDelegate, UISearchBarDelegate>
{
    IBOutlet NVUIGradientButton *searchButton;
    IBOutlet UISearchBar *searchBar;
    IBOutlet UIPickerView *searchPicker;
    id<SearchViewDelegate> delegate;
    
    NSArray *educationArray;
    NSArray *courseArray;
    
    NSUInteger degInd;
    NSUInteger subInd;
}

@property (assign) id<SearchViewDelegate> delegate;

- (IBAction)closeButtonPress:(id)sender;
- (IBAction)searchButtonPress:(id)sender;

- (IBAction)TopicPickerValueChange:(id)sender;

@end
