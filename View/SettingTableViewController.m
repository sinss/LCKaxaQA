//
//  SettingTableViewController.m
//  KaxaQ&A
//
//  Created by 張星星 on 12/1/18.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import "SettingTableViewController.h"

@interface SettingTableViewController()

- (void)showMail;

@end

@implementation SettingTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        self.title = NSLocalizedStringFromTable(@"Setting", @"InfoPlist", @"設定");
        self.tabBarItem.image = [UIImage imageNamed:settingtabImge];
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
    [groupArray release], groupArray = nil;
    [accountFunctionArray release], accountFunctionArray = nil;
    [systemFunctionArray release], systemFunctionArray = nil;
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
    if (groupArray == nil)
    {
        groupArray = [[NSArray alloc] initWithObjects:
                      NSLocalizedStringFromTable(@"AccountSetting", @"InfoPlist", nil),
                      NSLocalizedStringFromTable(@"AboutMe", @"InfoPlist", nil), nil];
    }
    if (accountFunctionArray == nil)
    {
        accountFunctionArray = [[NSArray alloc] initWithObjects:
                                NSLocalizedStringFromTable(@"LoginAccount", @"InfoPlist", nil),
                                NSLocalizedStringFromTable(@"CreateAccount", @"InfoPlist", nil), nil];
    }
    if (systemFunctionArray == nil)
    {
        systemFunctionArray = [[NSArray alloc] initWithObjects:
                               NSLocalizedStringFromTable(@"AboutSystem", @"InfoPlist", nil),
                               NSLocalizedStringFromTable(@"AboutTeam", @"InfoPlist", nil),
                               NSLocalizedStringFromTable(@"ContactUs", @"InfoPlist", nil), nil];
    }
    //self.clearsSelectionOnViewWillAppear = NO;
 
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
    return [groupArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == settingTableViewSectionMyAccount)
    {
        return [accountFunctionArray count];
    }
    else if (section == settingTableViewSectionAbountUs)
    {
        return [systemFunctionArray count];
    }
    else
        return 0;
}
/*
- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [groupArray objectAtIndex:section];
}
*/
- (NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if (section == settingTableViewSectionMyAccount)
    {
        //關於帳號設定
        return @"";
    }
    else if (section == settingTableViewSectionAbountUs)
    {
        //關於系統
        return @"MountainStar Copyright";
    }
    else
        return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"settingCellIdentifier";
    NSUInteger sec = [indexPath section];
    NSUInteger row = [indexPath row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        [cell.imageView setFrame:CGRectMake(0, 0, 30, 30)];
    }
    if (sec == settingTableViewSectionMyAccount)
    {
        [cell.textLabel setText:[accountFunctionArray objectAtIndex:row]];
        if (row == 0)
            [cell.imageView setImage:loginIcon];
        else if (row == 1)
            [cell.imageView setImage:signupIcon];
    }
    else if (sec == settingTableViewSectionAbountUs)
    {
        [cell.textLabel setText:[systemFunctionArray objectAtIndex:row]];
        if (row == 0)
            [cell.imageView setImage:systemIcon];
        else if (row == 1)
            [cell.imageView setImage:systemIcon];
        else if (row == 2)
            [cell.imageView setImage:mailIcon];
    }
    [cell.imageView sizeToFit];
    return cell;
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
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
    if (section == settingTableViewSectionMyAccount)
    {
        if (row == accountOptionMyAccount)
        {
            loginTableViewController *loginView = [[loginTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
            [loginView setDelegate:self];
            [self.navigationController pushViewController:loginView animated:YES];
            [loginView release];
        }
        else if (row == accountOptionCreateAccount)
        {
            SignupTableViewController *signupView = [[SignupTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
            [signupView setDelegate:self];
            [self.navigationController pushViewController:signupView animated:YES];
            [signupView release];
        }
        else if (row == accountOptionForgotPassword)
        {
            ForgotPasswordTableViewController *forgotView = [[ForgotPasswordTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
            [self.navigationController pushViewController:forgotView animated:YES];
            [forgotView release];
        }
    }
    else if (section == settingTableViewSectionAbountUs)
    {
        if (row == aboutusOptionAboutSystem)
        {
            aboutSystemViewController *systemView = [[aboutSystemViewController alloc] initWithNibName:@"aboutSystemViewController" bundle:nil];
            [self.navigationController pushViewController:systemView animated:YES];
            [systemView release];
        }
        else if (row == aboutusOptionAboutTeam)
        {
            aboutTeamViewController *aboutTeamView = [[aboutTeamViewController alloc] initWithNibName:@"aboutTeamViewController" bundle:nil];
            [self.navigationController pushViewController:aboutTeamView animated:YES];
            [aboutTeamView release];
        }
        else if (row == aboutusOptionContactUs)
        {
            [self showMail];
        }
    }
    // Navigation logic may go here. Create and push another view controller.
    /*
       *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}
#pragma mark - loginTableViewDelegate, signupTableViewDelegate
- (void)loginTableview:(loginTableViewController *)loginView didLogin:(loginInfo *)info
{
    [infoPanel showPanelInView:self.view type:infoPanelTypeInfo title:NSLocalizedStringFromTable(@"Welcome", @"InfoPlist", nil) subTitle:info.accountName hideAfter:2];
}
- (void)signupTableView:(SignupTableViewController *)signupView didFinishSignup:(loginInfo *)info
{
    [infoPanel showPanelInView:self.view type:infoPanelTypeInfo title:NSLocalizedStringFromTable(@"Welcome", @"InfoPlist", nil) subTitle:info.accountName hideAfter:2];
}
#pragma mark - send mail delegate
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    NSString *message;
    switch (result) 
    {
        case MFMailComposeResultCancelled:
            message = @"Result: cancel send";
            break;
        case MFMailComposeResultSaved:
            message = @"Result: Mail Saved";
            break;
        case MFMailComposeResultFailed:
            message = @"Result: Mail Send Faild";
            break;
        case MFMailComposeResultSent:
            message = @"Result: Mail send";
            break;
        default:
            message = @"Result : Mail no Send";
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - user define function
- (void)showMail
{
    //iOS 3.0就支援了
    if ([MFMailComposeViewController canSendMail] == YES)
    {
        MFMailComposeViewController *compose = [[MFMailComposeViewController alloc] init];
        compose.mailComposeDelegate = self;
        [compose setSubject:@"KaxaNote Iphone App"];
        
        //NSArray *toRecipients = [NSArray arrayWithObjects:@"kaxanote@gmail.com",nil];
        //[compose setToRecipients:toRecipients];
        //附加檔案
        
        NSString *emailBody = @"Dear KaxaNote";
        
        [compose setMessageBody:emailBody isHTML:NO];
        [self presentViewController:compose animated:YES completion:^
         {
             
         }];
        UIImage *image = [UIImage imageNamed:@""];
        [[[[compose navigationBar] items] objectAtIndex:0] setTitleView:[[UIImageView alloc] initWithImage:image]];
    }
    else
    {
        [infoPanel showPanelInView:self.view type:infoPanelTypeInfo title:@"" subTitle:@"Mail doesn't support." hideAfter:2];
    }
}
@end
