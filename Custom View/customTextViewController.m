//
//  customTextViewController.m
//  KaxaQ&A
//
//  Created by 張星星 on 12/2/8.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import "customTextViewController.h"

@interface customTextViewController ()

- (void)createToolBar;

@end

@implementation customTextViewController

@synthesize delegate;
@synthesize currentString;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
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
- (void)dealloc
{
    [navBar release], navBar = nil;
    [contentTextView release], contentTextView = nil;
    [currentString release], currentString = nil;
    [super dealloc];
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (os_version >= 7.0)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [contentTextView setText:currentString];
    contentTextView.delegate = self;
    [self createToolBar];
    [contentTextView becomeFirstResponder];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    return YES;
}
#pragma mark - user define function
- (void)createToolBar
{
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedStringFromTable(@"Back", @"InfoPlist", nil) style:UIBarButtonItemStyleDone target:self action:@selector(didPressDone)];
    toolBar.items = [[NSArray alloc] initWithObjects:flexItem,doneItem, nil];
    contentTextView.inputAccessoryView = toolBar;
    
    [toolBar release];
    [flexItem release];
    [doneItem release];
}
- (void)didPressDone
{
    [contentTextView resignFirstResponder];
}
- (IBAction)confirmButtonPress:(id)sender
{
    NSString *contentString = [contentTextView text];
    if (contentString == nil)
        contentString = @"";
    [self dismissViewControllerAnimated:YES completion:nil];
    [delegate customTextView:self didConfirmButtonPressWithContent:contentString];
}
- (IBAction)closeButtonPress:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
