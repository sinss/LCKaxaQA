//
//  customPickCourseViewController.m
//  KaxaQ&A
//
//  Created by 張星星 on 12/3/20.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import "customPickCourseViewController.h"

@interface customPickCourseViewController ()


@end

@implementation customPickCourseViewController

@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [coursePicker setDelegate:self];
    [coursePicker setDataSource:self];
    if (courseArray == nil)
    {
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
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (void)dealloc
{
    [coursePicker release], coursePicker = nil;
    [courseArray release], courseArray = nil;
    [super dealloc];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark pickerView Delegate , DataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [courseArray count];
}
- (UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    [label setText:[NSString stringWithFormat:@"%@", [courseArray objectAtIndex:row]]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setTextColor:[UIColor darkGrayColor]];
    
    return label;
}
#pragma mark - user define function

- (IBAction)closeButtonPress:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)confirmButtonPress:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        [delegate pickerCourseView:self didPickCourse:[coursePicker selectedRowInComponent:0]];
    }];
}
@end
