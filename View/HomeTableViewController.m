//
//  HomeTableViewController.m
//  KaxaQ&A
//
//  Created by 張星星 on 12/1/31.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import "HomeTableViewController.h"
#import "DPUpdateChecker.h"
#import "CXAlertView.h"

@interface HomeTableViewController()

@property (nonatomic, retain) CXAlertView *loadingAlert;

- (void)askButtonPress;
- (void)didRefreshButtonPress;
//開啟登入 or 註冊視窗
- (void)askAccountSource;
- (void)showLoginView;
- (void)showRegisterView;

- (void)createBarItem;
- (void)startHomePostWithAlertInd:(BOOL)ind;
- (BOOL)checkKaxaNetReachable;
- (void)kaxaNetNotReachable:(NSNotification*)notify;
- (void)kaxaNetReachable:(NSNotification*)notify;

- (void)showAlertWithMessage:(NSString*)message;
- (void)showAlertAnimation;
- (void)closeAlertAnimation;

- (BOOL)checkAccountAvailable;
@end

@implementation HomeTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        self.title = NSLocalizedStringFromTable(@"Home", @"InfoPlist", @"首頁");
        self.tabBarItem.image = [UIImage imageNamed:homeTabImage];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:kaxaNetNotReachName];
    [[NSNotificationCenter defaultCenter] removeObserver:kaxaNetReachName];
    [newsList release], newsList = nil;
    [replyList release], replyList = nil;
    [alert release], alert = nil;
    [accountInfo release], accountInfo = nil;
    [_loadingAlert release], _loadingAlert = nil;
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
    [self createBarItem];
    //[self createTitleView];
    UIImageView *imageview = [[[UIImageView alloc] initWithImage:plainTableviewBg] autorelease];
    [self.tableView setBackgroundView:imageview];
    [self.tableView setSeparatorColor:[UIColor clearColor]];
    [self.tableView setRowHeight:customTextfieldCellHeight];
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(kaxaNetNotReachable:)
                                                 name:kaxaNetNotReachName 
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(kaxaNetReachable:)
                                                 name:kaxaNetReachName 
                                               object:nil];
    DPUpdateChecker *cont = [[DPUpdateChecker new] autorelease];
    cont.delegate = (id<DPDelegate>) self;
    [cont startGetVersion];
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
    if (newsList == nil || replyList == nil)
        [self startHomePostWithAlertInd:YES];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [newsList count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return homeTableViewCellHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *newCellIdentifier = @"newCellIdentifier";
    NSInteger row = [indexPath row];
    
    newsTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:newCellIdentifier];
    if (cell == nil)
    {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"newsTableViewCell" owner:self options:nil];
        for (id currentObj in topLevelObjects)
        {
            if ([currentObj isKindOfClass:[newsTableViewCell class]])
            {
                cell = currentObj;
            }
            break;
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        
        if (row % 2 == 1)
        {
            UIView *cellView = [[UIView alloc] init];
            [cellView setBackgroundColor:oddCellBackgroundColor];
            [cell setBackgroundView:cellView];
            [cellView release];
        }
    }
    newsInfo2 *info = [newsList objectAtIndex:row];
    [cell.titleLabel setText:info.releaseDate];
    [cell.contentTextView setText:info.title];
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
    newsInfo2 *info = [newsList objectAtIndex:[indexPath row]];
    customDetailViewController *viewController = [[customDetailViewController alloc] initWithNibName:@"customDetailViewController" bundle:nil];
    viewController.currentInfo = info;
    [self.navigationController pushViewController:viewController animated:YES];
    [viewController release];
}
#pragma mark - postDelegate
- (void)MyPostDelegate:(MyPostDelegate*)poster didFinishPost:(NSArray*)result
{
    NSLog(@"finish post! %@",result);
    newsList = [[NSArray alloc] initWithArray:[result objectAtIndex:0]];
    replyList = [[NSArray alloc] initWithArray:[result objectAtIndex:1]];
    [self.tableView reloadData];
    [super stopLoading];
    [self closeAlertAnimation];
}
- (void)MyPostDelegate:(MyPostDelegate*)poster didFailWithError:(NSError *)error
{
    NSLog(@"faild to post with error :%@",error);
    [self closeAlertAnimation];
    [self showAlertWithMessage:serviceNotAbailable];
}
- (void)MyPostDelegate:(MyPostDelegate *)poster didFailParseXmlWithError:(NSError *)error
{
    NSLog(@"faild to parse xml with error :%@",error);
    [self closeAlertAnimation];
    [self showAlertWithMessage:serviceNotAbailable];
}
#pragma mark - UIAlertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSInteger tag = [alertView tag];
    if (tag == 0)
    {
        if (buttonIndex == 0)
        {
            if (poster != nil)
                [poster cancelPost];
        }
    }
    else if (tag == 1)
    {
        if(buttonIndex==1)
        {
            NSString *linkToAppstore = [NSString stringWithFormat:@"http://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=%d",AppleID];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:linkToAppstore]];
        }
    }
}
#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [self showLoginView];
    }
    else if (buttonIndex == 1)
    {
        [self showRegisterView];
    }
}

#pragma mark - loginTableViewDelegate, signupTableViewDelegate
- (void)loginTableview:(loginTableViewController *)loginView didLogin:(loginInfo *)info
{
    [infoPanel showPanelInView:self.view type:infoPanelTypeInfo title:NSLocalizedStringFromTable(@"Welcome",@"InfoPlist",@"歡迎你回來") subTitle:info.accountName hideAfter:2];
}
- (void)signupTableView:(SignupTableViewController *)signupView didFinishSignup:(loginInfo *)info
{
    [infoPanel showPanelInView:self.view type:infoPanelTypeInfo title:NSLocalizedStringFromTable(@"Welcome",@"InfoPlist",@"歡迎你回來") subTitle:info.accountName hideAfter:2];
}

#pragma mark - user define function
- (void)createBarItem
{
    UIBarButtonItem *askItem = [[[UIBarButtonItem alloc] initWithTitle:NSLocalizedStringFromTable(@"AskQuestion",@"InfoPlist",@"發問") style:UIBarButtonItemStyleBordered target:self action:@selector(askButtonPress)] autorelease];
    //UIBarButtonItem *refresh = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(didRefreshButtonPress)] autorelease];
    self.navigationItem.leftBarButtonItem = askItem;
    //self.navigationItem.rightBarButtonItem = refresh;
    //self.navigationItem.rightBarButtonItems = [[NSArray alloc] initWithObjects:askItem,refresh,nil];
}

- (void)didRefreshButtonPress
{
    [self startHomePostWithAlertInd:YES];
}
- (void)askButtonPress
{
    if (![self checkAccountAvailable])
    {
        //[infoPanel showPanelInView:self.view type:infoPanelTypeError title:@"注意" subTitle:@"請先驗證你的帳號。" hideAfter:3];
        //return;
        [self askAccountSource];
        
    }
    else
    {
        AskTableViewController *askView = [[[AskTableViewController alloc] initWithStyle:UITableViewStylePlain AndQuestionType:askQuestionActionCreate] autorelease];
        UINavigationController *askNav = [[[UINavigationController alloc] initWithRootViewController:askView] autorelease];
        [self presentViewController:askNav animated:YES completion:^
         {
             
         }];
    }
}
#pragma mark 帳號相關
- (BOOL)checkAccountAvailable
{
    AccountCheck *acctCheck = [[AccountCheck alloc] init];
    accountInfo = [acctCheck checkAccountInfo];
    if (accountInfo == nil)
    {
        accountInfo = [[loginInfo alloc] initWithFaild];
        return NO;
    }
    else if (accountInfo.status == 1)
    {
        return NO;
    }
    [acctCheck release];
    return YES;
}
- (void)askAccountSource
{
    UIActionSheet *actionsheet = [[[UIActionSheet alloc] 
                                   initWithTitle:NSLocalizedStringFromTable(@"NotCheckAccount",@"InfoPlist",@"尚未驗證您的帳號")
                                   delegate:self                  
                                   cancelButtonTitle:NSLocalizedStringFromTable(@"Giveup",@"InfoPlist",@"放棄")
                                   destructiveButtonTitle:nil
                                   otherButtonTitles:NSLocalizedStringFromTable(@"LoginAccount",@"InfoPlist",@"Login"),
                                                     NSLocalizedStringFromTable(@"CreateAccount",@"InfoPlist",@"Create"), nil] autorelease];
    [actionsheet showInView:self.tabBarController.tabBar];
}
- (void)showLoginView
{
    loginTableViewController *loginView = [[loginTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [loginView setDelegate:self];
    [self.navigationController pushViewController:loginView animated:YES];
    [loginView release];
}
- (void)showRegisterView
{
    SignupTableViewController *signupView = [[SignupTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [signupView setDelegate:self];
    [self.navigationController pushViewController:signupView animated:YES];
    [signupView release];
}
- (void)startHomePostWithAlertInd:(BOOL)ind
{
    if (![self checkKaxaNetReachable])
    {
        [self showAlertWithMessage:kaxaNetNotReachableMessage];
        return;
    }
    if (ind)
        [self showAlertAnimation];
    NSString *urlString = [NSString stringWithFormat:homeUrl2];
    NSURL *url = [NSURL URLWithString:urlString];
    poster = [[MyPostDelegate alloc] initWithType:MyPostDelegateTypeHome];
    [poster setDelegate:self];
    [poster startPostWithUrl:url];
}
#pragma mark 檢查網路連線
- (BOOL)checkKaxaNetReachable
{
    NSString *kaxaReachableString = [[GlobalFunctions shareInstance] getAppInfoWithKey:kaxaNetReachableKey];
    NSLog(@"QuestionDetail:%@",kaxaReachableString);
    if ([kaxaReachableString isEqualToString:kaxaNetNotReachableValue])
        return NO;
    return YES;
}
- (void)kaxaNetNotReachable:(NSNotification*)notify
{
    NSLog(@"Home:KaxaNetNotReachable");
    [[GlobalFunctions shareInstance] saveAppInfoWithKey:kaxaNetReachableKey andValue:kaxaNetNotReachableValue];
}
- (void)kaxaNetReachable:(NSNotification*)notify
{
    NSLog(@"Home:KaxaNetReachable");
    [[GlobalFunctions shareInstance] saveAppInfoWithKey:kaxaNetReachableKey andValue:kaxaNetReachableValue];
}
#pragma mark 開始與webservice連結時的顯示動畫
- (void)showAlertWithMessage:(NSString*)message
{
    UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
    [alertView show];
}

- (void)showAlertAnimation
{
    UIActivityIndicatorView *activityView = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray] autorelease];
    [activityView startAnimating];
    self.loadingAlert = [[[CXAlertView alloc] initWithTitle:connectToKaxaNet message:@"" cancelButtonTitle:nil] autorelease];
    /*
    [_loadingAlert addButtonWithTitle:NSLocalizedStringFromTable(@"Cancel", @"InfoPlist", @"Cancel")
                                 type:CXAlertViewButtonTypeCancel
                              handler:^(CXAlertView *alertView, CXAlertButtonItem *button) {
                                  [poster cancelPost];
                                  [alertView dismiss];
                              }];
     */
    _loadingAlert.contentView = activityView;
    
    [_loadingAlert show];
    
    alertNeedClose = YES;
}

- (void)closeAlertAnimation
{
    if (alertNeedClose)
        [_loadingAlert dismiss];
    alertNeedClose = NO;
    [poster release], poster = nil;
}

- (void)refresh
{
    [self startHomePostWithAlertInd:YES];
}

#pragma mark - DBUpdateChecker

- (void)didFinishRequest: (id)value{
    NSString *myAppVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    NSString *appstoreVersion = [[NSString alloc] initWithString:value];
    if(appstoreVersion==nil)
    {
        NSLog(@"failed");
    }
    else if([myAppVersion compare: appstoreVersion]==NSOrderedAscending)
    {
        if ([[GlobalFunctions shareInstance] currentLanguageInd] == 0)
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"注意" message:[NSString stringWithFormat:@"您的版本為: %@. 更新至 %@?", myAppVersion, appstoreVersion] delegate:self cancelButtonTitle:@"放棄" otherButtonTitles:@"更新", nil];
            [alertView setTag:1];
            [alertView show];
            [alertView release];
        }
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Notice" message:[NSString stringWithFormat:@"Your app version: %@. Update to %@?", myAppVersion, appstoreVersion] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Update", nil];
            [alertView setTag:1];
            [alertView show];
            [alertView release];
        }
    }
}
- (void)didFinishRequestWithFail: (NSError*)error
{
    NSLog(@"%@", [error localizedDescription]);
}

@end
