//
//  SignupTableViewController.m
//  KaxaQ&A
//
//  Created by 張星星 on 12/1/31.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import "SignupTableViewController.h"

@interface SignupTableViewController()

- (void)closeKeyboard;
- (BOOL)checkInputDialog;
- (void)startSignup;

@end

@implementation SignupTableViewController
@synthesize accountField, nickNameField, passwordField, rePasswordField, nameField, currentField;
@synthesize delegate;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) 
    {
        self.title =NSLocalizedStringFromTable(@"Signup", @"InfoPlist", nil);
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
    [signupArray release], signupArray = nil;
    [placeholderArray release], placeholderArray = nil;
    [accountField release], accountField = nil;
    [passwordField release], passwordField = nil;
    [rePasswordField release], rePasswordField = nil;
    [nameField release], nameField = nil;
    [nickNameField release], nickNameField = nil;
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
    [self.tableView setSeparatorColor:[UIColor clearColor]];
    [self.tableView setBackgroundView:imageview];
    [self.tableView setSeparatorColor:[UIColor lightGrayColor]];
    if (signupArray == nil)
    {
        signupArray = [[NSArray alloc] initWithObjects:
                       NSLocalizedStringFromTable(@"Account", @"InfoPlist", nil),
                       NSLocalizedStringFromTable(@"Password", @"InfoPlist", nil),
                       @"",
                       NSLocalizedStringFromTable(@"name", @"InfoPlist", nil),
                       NSLocalizedStringFromTable(@"Nickname", @"InfoPlist", nil), nil];
    }
    if (placeholderArray == nil)
    {
        placeholderArray = [[NSArray alloc] initWithObjects:NSLocalizedStringFromTable(@"EnterAccount", @"InfoPlist", nil),
                                                            NSLocalizedStringFromTable(@"EnterPassword", @"InfoPlist", nil),
                                                            NSLocalizedStringFromTable(@"CheckPassword", @"InfoPlist", nil),
                                                            NSLocalizedStringFromTable(@"EnterName", @"InfoPlist", nil),
                                                            NSLocalizedStringFromTable(@"EnterNickname", @"InfoPlist", nil), nil];
    }
    if (acctCheck == nil)
    {
        acctCheck = [[AccountCheck alloc] initWithType:accountCheckTypeSignup];
        [acctCheck setDelegate:self];
    }
    if (accountInfo == nil)
    {
        accountInfo = [[loginInfo alloc] init];
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
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
        return [signupArray count];
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return customTextfieldCellHeight;
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
        return signupTableviewFootString;
    return @"";
}
*/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *signupCellIdentifier = @"signupCellIdentifier";
    static NSString *buttonCellIdentifier = @"buttonCellIdentifier";
    NSInteger row = [indexPath row];
    NSInteger sec = [indexPath section];
    if (sec == 0)
    {
        customTextfieldCell *cell = [tableView dequeueReusableCellWithIdentifier:signupCellIdentifier];
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
            [cell.contentField setDelegate:self];
            [cell.contentField setTag:row];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        //設定暫存控制項之變數
        if (row == signupOptionAccount)
        {
            self.accountField = cell.contentField;
            [cell.contentField setText:accountInfo.accountID];
            [cell.contentField setReturnKeyType:UIReturnKeyNext];
        }
        else if (row == signupOptionPassword)
        {
            self.passwordField = cell.contentField;
            [cell.contentField setText:accountInfo.password];
            [cell.contentField setReturnKeyType:UIReturnKeyNext];
        }
        else if (row == signupOptionRePassword)
        {
            self.rePasswordField = cell.contentField;
            [cell.contentField setText:accountInfo.rePassword];
            [cell.contentField setReturnKeyType:UIReturnKeyNext];
        }
        else if (row == signupOptionName)
        {
            self.nameField = cell.contentField;
            [cell.contentField setText:accountInfo.accountName];
            [cell.contentField setReturnKeyType:UIReturnKeyNext];
        }
        else if (row == signupOptionNickname)
        {
            self.nickNameField = cell.contentField;
            [cell.contentField setText:accountInfo.nickname];
            [cell.contentField setReturnKeyType:UIReturnKeyDone];
        }
        [cell.titleLabel setText:[signupArray objectAtIndex:row]];
        [cell.contentField setPlaceholder:[placeholderArray objectAtIndex:row]];
        return cell;
    }
    else if (sec == 1)
    {
        customButtonCell *cell = [tableView dequeueReusableCellWithIdentifier:buttonCellIdentifier];
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
            [cell.cellButton setTitle:NSLocalizedStringFromTable(@"Signup", @"InfoPlist", nil) forState:UIControlStateNormal];
            [cell setDelegate:self];
        }
        return cell;
    }
    else
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
#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.currentField = textField;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSInteger tag = [textField tag];
    if (tag == signupOptionAccount)
    {
        accountInfo.accountID = [textField text];
    }
    else if (tag == signupOptionPassword)
    {
        accountInfo.password = [textField text];
    }
    else if (tag == signupOptionRePassword)
    {
        accountInfo.rePassword = [textField text];
    }
    else if (tag == signupOptionName)
    {
        accountInfo.accountName = [textField text];
    }
    else if (tag == signupOptionNickname)
    {
        accountInfo.nickname = [textField text];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSInteger tag = [textField tag];
    if (tag == signupOptionAccount)
    {
        [passwordField becomeFirstResponder];
    }
    else if (tag == signupOptionPassword)
    {
        [rePasswordField becomeFirstResponder];
    }
    else if (tag == signupOptionRePassword)
    {
        [nameField becomeFirstResponder];
    }
    else if (tag == signupOptionName)
    {
        [nickNameField  becomeFirstResponder];
    }
    else if (tag == signupOptionNickname)
    {
        [nickNameField resignFirstResponder];
        [self startSignup];
    }
    return YES;
}
#pragma mark - customButton delegate
- (void)didSendButtonPress:(NSInteger)buttonTag
{
    [self startSignup];
}
#pragma mark - accountCheck delegate
- (void)didSucceedWithAccountCheck
{
    [self.navigationController popViewControllerAnimated:YES];
    accountInfo = [acctCheck checkAccountInfo];
    [delegate signupTableView:self didFinishSignup:accountInfo];
}
- (void)didFaildWithAccountCheck
{
    [infoPanel showPanelInView:self.view type:infoPanelTypeError title:@"Warnning" subTitle:NSLocalizedStringFromTable(@"SignupFaild", @"InfoPlist", nil) hideAfter:2];
}
#pragma mark - user define function
- (void)closeKeyboard
{
    [currentField resignFirstResponder];
}
- (BOOL)checkInputDialog
{
    NSMutableString *errorMesage = [[NSMutableString alloc] init];
    BOOL errorInd = YES;
    if (accountInfo.accountID == nil || [accountInfo.accountID isEqualToString:@""])
    {
        [errorMesage appendFormat:@"%@\n", NSLocalizedStringFromTable(@"NotEmptyAccount", @"InfoPlist", nil)];
        errorInd = NO;
    }
    else
    {
        //判斷是否為email
        if (![[GlobalFunctions shareInstance] checkIsValidEmail:accountInfo.accountID])
        {
            [errorMesage appendFormat:@"%@\n", NSLocalizedStringFromTable(@"NotAnEmail", @"InfoPlist", nil)];
            errorInd = NO;
        }
    }
    if (accountInfo.password == nil || [accountInfo.password isEqualToString:@""])
    {
        [errorMesage appendFormat:@"%@\n", NSLocalizedStringFromTable(@"NotEmptyPassword", @"InfoPlist", nil)];
        errorInd = NO;
    }
    else
    {
        if ([accountInfo.password length] < 8)
        {
            [errorMesage appendFormat:@"%@\n", NSLocalizedStringFromTable(@"PasswordLength", @"InfoPlist", nil)];
            errorInd = NO;
        }
        if (![accountInfo.rePassword isEqualToString:accountInfo.password])
        {
            [errorMesage appendFormat:@"%@\n", NSLocalizedStringFromTable(@"NotEmptyPassword", @"InfoPlist", nil)];
            errorInd = NO;
        }
    }
    if (accountInfo.accountName == nil || [accountInfo.accountName isEqualToString:@""])
    {
        [errorMesage appendFormat:@"%@\n", NSLocalizedStringFromTable(@"NotEmptyName", @"InfoPlist", nil)];
        errorInd = NO;
    }
    if (accountInfo.nickname == nil || [accountInfo.nickname isEqualToString:@""])
    {
        [errorMesage appendFormat:@"%@\n", NSLocalizedStringFromTable(@"NotEmptyNickname", @"InfoPlist", nil)];
        errorInd = NO;
    }
    if (!errorInd)
    {
        [infoPanel showPanelInView:self.view type:infoPanelTypeError title:@"Warnning" subTitle:errorMesage hideAfter:2];
    }
    [errorMesage release];
    return errorInd;
}
- (void)startSignup
{
    if (![self checkInputDialog])
        return;
    //取得token值, 並去掉頭尾的箭頭 .
    NSString *deviceToken = [[NSUserDefaults standardUserDefaults] valueForKey:@"deviceToken"];
    deviceToken = [deviceToken stringByReplacingOccurrencesOfString:@"<" withString:@""];
    deviceToken = [deviceToken stringByReplacingOccurrencesOfString:@">" withString:@""];
    if (deviceToken == nil)
        deviceToken = [NSString stringWithFormat:@"i am iphone simulator"];
    accountInfo.token = deviceToken;
    [acctCheck startSignupWithAccount:accountInfo];
}
@end
