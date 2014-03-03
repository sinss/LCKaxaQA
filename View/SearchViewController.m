//
//  SearchViewController.m
//  KaxaQ&A
//
//  Created by 張星星 on 12/1/30.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import "SearchViewController.h"
#import "GlobalFunctions.h"

@interface SearchViewController()

- (void)didSearch;
- (void)createToolBarItem;
- (void)closeKeyBoard;

@end

@implementation SearchViewController
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (os_version >= 7.0)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    searchButton.text = NSLocalizedStringFromTable(@"Search", @"InfoPlist", nil);
	searchButton.textColor = [UIColor whiteColor];
	searchButton.textShadowColor = [UIColor darkGrayColor];
	searchButton.tintColor = navigationBarColor;
	searchButton.highlightedTintColor = navigationBarButtonColor;
    if (educationArray == nil)
    {
        educationArray = [[NSArray alloc] initWithObjects:
                          NSLocalizedStringFromTable(@"All", @"InfoPlist", nil),
                          NSLocalizedStringFromTable(@"Elementary", @"InfoPlist", nil),
                          NSLocalizedStringFromTable(@"Junior", @"InfoPlist", nil),
                          NSLocalizedStringFromTable(@"Senior", @"InfoPlist", nil),
                          NSLocalizedStringFromTable(@"University", @"InfoPlist", nil), nil];
    }
    if (courseArray == nil)
    {
        /*
         全部
         國文
         英文
         數學
         物理
         化學
         理化
         地科&生物
         */
        courseArray = [[NSArray alloc] initWithObjects:
                       NSLocalizedStringFromTable(@"All", @"InfoPlist", @"我的專區"),
                       NSLocalizedStringFromTable(@"Chinese", @"InfoPlist", nil),
                       NSLocalizedStringFromTable(@"English", @"InfoPlist", nil),
                       NSLocalizedStringFromTable(@"Math", @"InfoPlist", nil),
                       NSLocalizedStringFromTable(@"Physical", @"InfoPlist", nil),
                       NSLocalizedStringFromTable(@"Chemistry", @"InfoPlist", nil),
                       NSLocalizedStringFromTable(@"PandC", @"InfoPlist", nil),
                       NSLocalizedStringFromTable(@"Other", @"InfoPlist", nil),
                       nil];
    }
    searchPicker.dataSource = self;
    searchPicker.delegate = self;
    searchBar.delegate = self;
    [self createToolBarItem];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (void)dealloc
{
    [searchBar release], searchBar = nil;
    [searchPicker release], searchPicker = nil;
    [searchButton release], searchButton = nil;
    [educationArray release], educationArray = nil;
    [courseArray release], courseArray = nil;
    [super dealloc];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark - picker  view datasource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return kComponentNumber;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 6;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label;
    label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    [label setText:[NSString stringWithFormat:@"%@",[[GlobalFunctions shareInstance] getTopicNameWithIndex:row]]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setTextColor:[UIColor darkGrayColor]];

    return label;
}
#pragma mark - searchBar delegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self didSearch];
}
#pragma mark - user define fuction
- (void)didSearch
{
    NSString *searchKeyword = [searchBar text];
    NSUInteger themeInd = [searchPicker selectedRowInComponent:0];
    switch (themeInd)
    {
        case 0:
            subInd = 0;
            degInd = 1;
            break;
        case 1:
            subInd = 3;
            degInd = 1;
            break;
        case 2:
            subInd = 4;
            degInd = 4;
            break;
        case 3:
            subInd = 5;
            degInd = 4;
            break;
        case 4:
            subInd = 6;
            degInd = 3;
            break;
        case 5:
            subInd = 7;
            degInd = 1;
            break;
    }
    //NSInteger eduInd = [searchPicker selectedRowInComponent:searchComponentOptionEducation] + 1;
    //NSInteger courseInd = [searchPicker selectedRowInComponent:searchComponentOptionCourse];
    if (searchKeyword== nil)
        searchKeyword = [NSString stringWithFormat:@""];
    [self dismissViewControllerAnimated:YES completion:nil];
    [searchKeyword retain];
    [delegate searchViewController:self didSearchWithKeyword:searchKeyword andEducationIndex:degInd andCourseIndex:subInd];
}
- (IBAction)closeButtonPress:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)searchButtonPress:(id)sender
{
    [self didSearch];
}

- (IBAction)TopicPickerValueChange:(id)sender
{
    
}

- (void)createToolBarItem
{
    UIToolbar *toolbar = [[[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)] autorelease];
    
    UIBarButtonItem *item = [[[UIBarButtonItem alloc] initWithTitle:NSLocalizedStringFromTable(@"Back", @"InfoPlist", nil) style:UIBarButtonItemStyleDone target:self action:@selector(closeKeyBoard)] autorelease];
    UIBarButtonItem *flixible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [toolbar setItems:[NSArray arrayWithObjects:flixible, item, nil]];
    searchBar.inputAccessoryView = toolbar;
}
- (void)closeKeyBoard
{
    [searchBar resignFirstResponder];
}
@end
