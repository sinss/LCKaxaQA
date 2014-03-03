//
//  loginTableViewController.m
//  KaxaQ&A
//
//  Created by 張星星 on 12/1/30.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import "loginTableViewController.h"

@interface loginTableViewController()

- (void)closeKeyboard;
- (BOOL)checkInputDialog;
- (void)startLogin;
- (void)clearAccountXml;

@end

@implementation loginTableViewController

@synthesize delegate;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) 
    {
        // Custom initialization
        self.title = NSLocalizedStringFromTable(@"LoginAccount", @"InfoPlist", nil);
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void) dealloc
{
    [loginArray release], loginArray =  nil;
    [placeholderArray release], placeholderArray = nil;
    [accountField release], accountField = nil;
    [passwordField release], passwordField = nil;
    [accountInfo release], accountInfo = nil;
    [acctCheck release], acctCheck = nil;
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
    UIImageView *imageview = [[[UIImageView alloc] initWithImage:groupTableViewBg] autorelease];
    [self.tableView setBackgroundView:imageview];
    [self.tableView setSeparatorColor:[UIColor lightGrayColor]];
    if (loginArray == nil)
    {
        loginArray = [[NSArray alloc] initWithObjects:
                      NSLocalizedStringFromTable(@"Account", @"InfoPlist", nil),
                      NSLocalizedStringFromTable(@"Password", @"InfoPlist", nil), nil];
    }
    if (placeholderArray == nil)
    {
        placeholderArray = [[NSArray alloc] initWithObjects:
                            NSLocalizedStringFromTable(@"EnterAccount", @"InfoPlist", nil),
                            NSLocalizedStringFromTable(@"EnterPassword", @"InfoPlist", nil), nil];
    }
    if (acctCheck == nil)
    {
        acctCheck = [[AccountCheck alloc] init];
        [acctCheck setDelegate:self];
    }
    accountInfo = [acctCheck checkAccountInfo];
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return customTextfieldCellHeight;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
        return [loginArray count];
    return 1;
}
/*
- (NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if (section == 0)
        return copyrightString;
    return @"";
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return loginTableViewFootString;
    return @"";
}
*/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *textFieldIdentifier = @"textFieldCellIdentifier";
    static NSString *buttonFieldIdetifier = @"buttonCellIdentifier";
    static NSString *clearButtonIdentifier = @"clearButtonIdentifier";
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
            
            UIBarButtonItem *item = [[[UIBarButtonItem alloc] initWithTitle:NSLocalizedStringFromTable(@"Back", @"InfoPlist", nil) style:UIBarButtonItemStyleDone target:self action:@selector(closeKeyboard)] autorelease];
            UIBarButtonItem *flixible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
            [toolbar setItems:[NSArray arrayWithObjects:flixible, item, nil]];
            [cell.contentField setInputAccessoryView:toolbar];
            [cell.titleLabel setText:[loginArray objectAtIndex:row]];
            [cell.contentField setPlaceholder:[placeholderArray objectAtIndex:row]];
            [cell.contentField setDelegate:self];
            [cell.contentField setTag:row];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        if (row == loginFieldOptionAccount)
        {
            [cell.contentField setReturnKeyType:UIReturnKeyNext];
            accountField = [cell contentField];
            [accountField retain];
            if (accountInfo != nil)
            {
                [cell.contentField setText:[NSString stringWithFormat:@"%@",accountInfo.email==nil?@"":accountInfo.email]];
            }
        }
        else if (row == loginFieldOptionPassword)
        {
            [cell.contentField setReturnKeyType:UIReturnKeyDone];
            [cell.contentField setSecureTextEntry:YES];
            passwordField = [cell contentField];
            [passwordField retain];
        }
        return cell;
    }
    else if (sec == 1)
    {
        customButtonCell *cell = [tableView dequeueReusableCellWithIdentifier:clearButtonIdentifier];
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
            [cell.cellButton setTitle:NSLocalizedStringFromTable(@"Login", @"InfoPlist", nil) forState:UIControlStateNormal];
            [cell setDelegate:self];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        return cell;
    }
    else if (sec == 2)
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
            [cell.cellButton setTag:2];
            [cell.cellButton setTitle:NSLocalizedStringFromTable(@"ClearAccount", @"InfoPlist", nil) forState:UIControlStateNormal];
            cell.backgroundView = nil;
            [cell setDelegate:self];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
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
    if (tag == loginFieldOptionAccount)
    {
        [passwordField becomeFirstResponder];
    }
    else if (tag == loginFieldOptionPassword)
    {
        [passwordField resignFirstResponder];
        //同時送出驗證
        [self didSendButtonPress:1];
    }
    return YES;
}
#pragma mark - customButton delegate
- (void)didSendButtonPress:(NSInteger)buttonTag
{
    /*
     buttonTag:
     0-->表示送出驗證密碼
     1-->表示清除密碼
     */
    NSLog(@"buttonTab:%i", buttonTag);
    if (buttonTag == loginButtonOptionLogin)
        [self startLogin];
    else
        [self clearAccountXml];
    
}
#pragma mark - AccountCheck delegate
- (void)didSucceedWithAccountCheck
{
    [self.navigationController popViewControllerAnimated:YES];
    accountInfo = [acctCheck checkAccountInfo];
    [delegate loginTableview:self didLogin:accountInfo];
}
- (void)didFaildWithAccountCheck
{
    [infoPanel showPanelInView:self.view type:infoPanelTypeError title:@"Warnning" subTitle:NSLocalizedStringFromTable(@"LoginFaild", @"InfoPlist", nil) hideAfter:2];
}
#pragma mark - user define function
- (void)clearAccountXml
{
    [acctCheck clearAccountXml];
    [self.navigationController popViewControllerAnimated:YES];
}
- (BOOL)checkInputDialog
{   
    NSString *accountID = [accountField text];
    NSString *password = [passwordField text];
    NSMutableString *errorMesage = [[NSMutableString alloc] init];
    BOOL errorInd = YES;
    if (accountID == nil || [accountID isEqualToString:@""])
    {
        [errorMesage appendFormat:NSLocalizedStringFromTable(@"NotEmptyAccount", @"InfoPlist", nil)];
        errorInd = NO;
    }
    if (password == nil || [password isEqualToString:@""])
    {
        [errorMesage appendFormat:NSLocalizedStringFromTable(@"NotEmptyPassword", @"InfoPlist", nil)];
        errorInd = NO;
    }
    if (!errorInd)
    {
        [infoPanel showPanelInView:self.view type:infoPanelTypeError title:@"Warnning" subTitle:errorMesage hideAfter:2];
    }
    [errorMesage release];
    return errorInd;
}
- (void)startLogin
{
    if (![self checkInputDialog])
        return;
    //取得token值, 並去掉頭尾的箭頭 .
    NSString *deviceToken = [[NSUserDefaults standardUserDefaults] valueForKey:@"deviceToken"];
    deviceToken = [deviceToken stringByReplacingOccurrencesOfString:@"<" withString:@""];
    deviceToken = [deviceToken stringByReplacingOccurrencesOfString:@">" withString:@""];
    deviceToken = [deviceToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (deviceToken == nil)
        deviceToken = [NSString stringWithFormat:@"i am iphone simulator"];
    NSString *accountID = [accountField text];
    NSString *password = [passwordField text];
    [acctCheck startCheckWithAccount:accountID andPassword:password andDeviceToken:deviceToken];
}
- (void)closeKeyboard
{
    [currentField resignFirstResponder];
}
@end
