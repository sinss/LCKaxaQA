//
//  ForgotPasswordTableViewController.m
//  KaxaQ&A
//
//  Created by 張星星 on 12/2/1.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import "ForgotPasswordTableViewController.h"

@interface ForgotPasswordTableViewController()

- (void)closeKeyboard;

@end

@implementation ForgotPasswordTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) 
    {
        // Custom initialization
        self.title = NSLocalizedString(@"忘記密碼", @"忘記密碼");
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
    [forgotArray release], forgotArray = nil;
    [placeholderArray release], placeholderArray = nil;
    [accountField release], accountField = nil;
    [emailField release], emailField = nil;
    [info release], info = nil;
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
    if (info == nil)
    {
        info = [[forgotPasswordInfo alloc] init];
    }
    if (forgotArray == nil)
    {
        forgotArray = [[NSArray alloc] initWithObjects:@"帳號",@"信箱", nil];
    }
    if (placeholderArray == nil)
    {
        placeholderArray = [[NSArray alloc] initWithObjects:@"請輸入您的帳號",@"請輸入您的信箱", nil];
    }
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
        return [forgotArray count];
    return 1;
}
- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return forgotpasswordTableviewFootString;
    }
    return @"";
}
- (NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if (section == 0)
    {
        return copyrightString;
    }
    return @"";
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return customTextfieldCellHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *textFieldIdentifier = @"textFieldCellIdentifier";
    static NSString *buttonFieldIdetifier = @"buttonCellIdentifier";
    NSUInteger sec = [indexPath section];
    NSUInteger row = [indexPath row];
    if (sec == 0)
    {
        customTextfieldCell *cell = [tableView dequeueReusableCellWithIdentifier:textFieldIdentifier];
        if (cell == nil) 
        {
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"customTextfieldCell" owner:self options:nil];
            for (id currentObj in topLevelObjects)
            {
                if ([currentObj isKindOfClass:[customTextfieldCell class]])
                {
                    cell = currentObj;
                }
                break;
            }
            //create toolbar
            UIToolbar *toolbar = [[[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)] autorelease];
            
            UIBarButtonItem *item = [[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(closeKeyboard)] autorelease];
            UIBarButtonItem *flixible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
            [toolbar setItems:[NSArray arrayWithObjects:flixible, item, nil]];
            [cell.contentField setInputAccessoryView:toolbar];
            [cell.titleLabel setText:[forgotArray objectAtIndex:row]];
            [cell.contentField setPlaceholder:[placeholderArray objectAtIndex:row]];
            [cell.contentField setDelegate:self];
            [cell.contentField setTag:row];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        if (row == forgotOptionAccount)
        {
            [cell.contentField setReturnKeyType:UIReturnKeyNext];
            accountField = [cell contentField];
        }
        else if (row == forgotOptionEmail)
        {
            [cell.contentField setReturnKeyType:UIReturnKeyDone];
            emailField = [cell contentField];
        }
        return cell;
    }
    else if (sec == 1)
    {
        customButtonCell *cell = [tableView dequeueReusableCellWithIdentifier:buttonFieldIdetifier];
        if (cell == nil) 
        {
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"customButtonCell" owner:self options:nil];
            for (id currentObj in topLevelObjects)
            {
                if ([currentObj isKindOfClass:[customButtonCell class]])
                {
                    cell = currentObj;
                }
                break;
            }
            [cell.cellButton setTag:1];
            [cell.cellButton setTitle:@"送出" forState:UIControlStateNormal];
            [cell setDelegate:self];
        }
        return cell;
    }
    return nil;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}
#pragma mark - UITextField delegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    currentField = textField;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSUInteger tag = [textField tag];
    if (tag == forgotOptionAccount)
    {
        [emailField becomeFirstResponder];
    }
    else if (tag == forgotOptionEmail)
    {
        [emailField resignFirstResponder];
    }
    return YES;
}
#pragma mark - customButton delegate
- (void)didSendButtonPress:(NSInteger)buttonTag
{
    [self.navigationController popViewControllerAnimated:YES];
    //[delegate loginTableview:self didLogin:info];
}
#pragma mark - user define function
- (void)closeKeyboard
{
    [currentField resignFirstResponder];
}
@end
