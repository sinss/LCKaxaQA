//
//  customPickEducationViewController.m
//  KaxaQ&A
//
//  Created by 張星星 on 12/3/20.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import "customPickEducationViewController.h"

@interface customPickEducationViewController ()

@end

@implementation customPickEducationViewController

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
    [educationPicker setDataSource:self];
    [educationPicker setDelegate:self];
    if (educationArray == nil)
    {
        educationArray = [[NSArray alloc] initWithObjects:
                          NSLocalizedStringFromTable(@"All", @"InfoPlist", nil),
                          NSLocalizedStringFromTable(@"Elementary", @"InfoPlist", nil),
                          NSLocalizedStringFromTable(@"Junior", @"InfoPlist", nil),
                          NSLocalizedStringFromTable(@"Senior", @"InfoPlist", nil),
                          NSLocalizedStringFromTable(@"University", @"InfoPlist", nil), nil];
    }
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}
- (void)dealloc
{
    [educationArray release], educationArray = nil;
    [educationPicker release], educationPicker = nil;
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
    return [educationArray count];
}
- (UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    [label setText:[NSString stringWithFormat:@"%@", [educationArray objectAtIndex:row]]];
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
    [delegate pickerCourseView:self didPickEducation:[educationPicker selectedRowInComponent:0]];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
