//
//  MyAreaTableViewController.m
//  KaxaQ&A
//
//  Created by 張星星 on 12/1/31.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import "MyAreaTableViewController.h"
#import "customQuestionCell2.h"
#import "CXAlertView.h"

@interface MyAreaTableViewController()
{
    BOOL questionInd;
    BOOL replyInd;
    BOOL subscribeInd;
}

@property (nonatomic, retain) CXAlertView *loadingAlert;

- (void)createBarItem;
- (void)didRefreshButtonPress;
- (void)askButtonPress;
//開啟登入 or 註冊視窗
- (void)askAccountSource;
- (void)showLoginView;
- (void)showRegisterView;

- (void)startGetMyAreaPostWithAlertInd:(BOOL)ind;
- (BOOL)checkKaxaNetReachable;
- (void)kaxaNetNotReachable:(NSNotification*)notify;
- (void)kaxaNetReachable:(NSNotification*)notify;

- (void)showAlertWithMessage:(NSString*)message;
- (void)showAlertAnimation;
- (void)closeAlertAnimation;

//判斷是否已驗證過帳號
- (BOOL)checkAccountAvailable;
@end

@implementation MyAreaTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) 
    {
        self.title = NSLocalizedStringFromTable(@"MyArea", @"InfoPlist", @"我的專區");
        self.tabBarItem.image = [UIImage imageNamed:aboutmeTabImage];
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
    [[NSNotificationCenter defaultCenter] removeObserver:kaxaNetNotReachName];
    [[NSNotificationCenter defaultCenter] removeObserver:kaxaNetReachName];
    [questionArray release], questionArray = nil;
    [replyArray release], replyArray = nil;
    [subscribeArray release], subscribeArray = nil;
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
    questionInd = YES;
    replyInd = YES;
    subscribeInd = YES;
    
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    //收到網路連線不通的通知
    UIImageView *imageview = [[[UIImageView alloc] initWithImage:plainTableviewBg] autorelease];
    [self.tableView setBackgroundView:imageview];
    [self createBarItem];
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(kaxaNetNotReachable:)
                                                 name:kaxaNetNotReachName 
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(kaxaNetReachable:)
                                                 name:kaxaNetReachName 
                                               object:nil];
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
    if (questionArray == nil)
        [self startGetMyAreaPostWithAlertInd:YES];
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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        if (!questionInd)
            return 0;
        return [questionArray count];
    }
    else if (section == 1)
    {
        if (!replyInd)
            return 0;
        return [replyArray count];
    }
    else if (section == 2)
    {
        if (!subscribeInd)
            return 0;
        return [subscribeArray count];
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return customQuestionCellHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
/*
- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return @"最新回答";
    return @"歷史問題";
}
 */
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGRect rect = CGRectMake(0, 0, self.view.frame.size.width, 30);
    UIView *titleView = [[[UIView alloc] initWithFrame:rect] autorelease];
    UIImageView *imageView = nil;
    UIButton *headerButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 0 , 250, 30)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(250, 0, 60, 30)];
    if (section == 0)
    {
        [headerButton setTitle:NSLocalizedStringFromTable(@"MyQuestion", @"InfoPlist", @"我的主題") forState:UIControlStateNormal];
        [label setText:[NSString stringWithFormat:@"%i", [questionArray count]]];
        imageView = [[[UIImageView alloc] initWithImage:myareaHeaderBg1] autorelease];
    }
    else if (section == 1)
    {
        [headerButton setTitle:NSLocalizedStringFromTable(@"MyReply", @"InfoPlist", @"我的回覆") forState:UIControlStateNormal];
        [label setText:[NSString stringWithFormat:@"%i", [replyArray count]]];
        imageView = [[[UIImageView alloc] initWithImage:myareaHeaderBg2] autorelease];
    }
    else {
        [headerButton setTitle:NSLocalizedStringFromTable(@"MySubscribe", @"InfoPlist", @"我的訂閱") forState:UIControlStateNormal];
        [label setText:[NSString stringWithFormat:@"%i", [subscribeArray count]]];
        imageView = [[[UIImageView alloc] initWithImage:myareaHeaderBg3] autorelease];
    }
    [headerButton.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
    [headerButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [headerButton setTag:section];
    [headerButton addTarget:self action:@selector(headerButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    [label setTextAlignment:NSTextAlignmentRight];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:[UIColor lightGrayColor]];
    imageView.frame = rect;
    [titleView addSubview:imageView];
    [titleView addSubview:label];
    [titleView addSubview:headerButton];
    return titleView;
}

- (void)headerButtonPress:(UIButton*)sender
{
    NSInteger tag = [sender tag];
    switch (tag)
    {
        case 0:
            questionInd = !questionInd;
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case 1:
            replyInd = !replyInd;
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case 2:
            subscribeInd = !subscribeInd;
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *questionCellIdentifier = @"questionCellIdentifier";
    NSInteger row = [indexPath row];
    NSInteger sec = [indexPath section];
    questionInfo *info  = nil;
    if (sec == 0)
    {
        info = [questionArray objectAtIndex:row];
    }
    else if (sec == 1)
    {
        info = [replyArray objectAtIndex:row];
    }
    else if (sec == 2)
    {
        info = [subscribeArray objectAtIndex:row];
    }
    customQuestionCell2 *cell = [tableView dequeueReusableCellWithIdentifier:questionCellIdentifier];
    if (cell == nil)
    {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"customQuestionCell2" owner:self options:nil];
        for (id currentObj in topLevelObjects)
        {
            if ([currentObj isKindOfClass:[customQuestionCell2 class]])
            {
                cell = currentObj;
            }
            break;
        }
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        
        if (row % 2 == 1)
        {
            UIView *cellView = [[UIView alloc] init];
            [cellView setBackgroundColor:oddCellBackgroundColor];
            [cell setBackgroundView:cellView];
            [cellView release];
        }
    }
    
    [cell.themeLabel setText:info.theme];
    [cell.titleLabel setText:info.title];
    [cell.subjectLabel setText:info.subject];
    [cell.degreeLabel setText:info.degree];
    [cell.askerLabel setText:info.answerName];
    [cell.dateLabel setText:info.date];
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
    NSInteger sec = [indexPath section];
    QuestionDetailTableViewController *detailView = [[QuestionDetailTableViewController alloc] initWithStyle:UITableViewStylePlain];
    NSInteger row = [indexPath row];
    if (sec == 0)
    {
        questionInfo *reply = [questionArray objectAtIndex:row];
        detailView.discussid = reply.discussid;
        detailView.theme = reply.theme;
    }
    else if (sec == 1)
    {
        questionInfo *info = [replyArray objectAtIndex:row];
        detailView.discussid = info.discussid;
        detailView.theme = info.theme;
    }
    else if (sec == 2)
    {
        questionInfo *info = [subscribeArray objectAtIndex:row];
        detailView.discussid = info.discussid;
        detailView.theme = info.theme;
    }
    
    [self.navigationController pushViewController:detailView animated:YES];
    [detailView release];
}
#pragma mark - postDelegate
- (void)MyPostDelegate:(MyPostDelegate*)poster didFinishPost:(NSArray*)result
{
    NSLog(@"finish post! %@",result);
    //resultList = [[NSArray alloc] initWithArray:result];
    questionArray = [[NSArray alloc] initWithArray:[result objectAtIndex:0]];
    replyArray = [[NSArray alloc] initWithArray:[result objectAtIndex:1]];
    subscribeArray = [[NSArray alloc] initWithArray:[result objectAtIndex:2]];
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

#pragma mark - loginTableViewDelegate, signupTableViewDelegate
- (void)loginTableview:(loginTableViewController *)loginView didLogin:(loginInfo *)info
{
    [infoPanel showPanelInView:self.view type:infoPanelTypeInfo title:NSLocalizedStringFromTable(@"Welcome",@"InfoPlist",@"歡迎你回來") subTitle:info.accountName hideAfter:2];
}
- (void)signupTableView:(SignupTableViewController *)signupView didFinishSignup:(loginInfo *)info
{
    [infoPanel showPanelInView:self.view type:infoPanelTypeInfo title:NSLocalizedStringFromTable(@"Welcome",@"InfoPlist",@"歡迎你回來") subTitle:info.accountName hideAfter:2];
}

#pragma mark - UIAlertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        if (poster != nil)
            [poster cancelPost];
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

#pragma mark - user define function
- (void)askButtonPress
{
    if (![self checkAccountAvailable])
    {
        [infoPanel showPanelInView:self.view type:infoPanelTypeError title:@"Info" subTitle:NSLocalizedStringFromTable(@"NotCheckAccount", @"InfoPlist", @"請先驗證帳號") hideAfter:3];
        return;
    }
    AskTableViewController *askView = [[[AskTableViewController alloc] initWithStyle:UITableViewStylePlain] autorelease];
    UINavigationController *askNav = [[[UINavigationController alloc] initWithRootViewController:askView] autorelease];
    [self presentViewController:askNav animated:YES completion:^
     {
         
     }];
}
- (void)didRefreshButtonPress
{
    [self startGetMyAreaPostWithAlertInd:YES];
}
- (void)createBarItem
{
    UIBarButtonItem *askItem = [[[UIBarButtonItem alloc] initWithTitle:NSLocalizedStringFromTable(@"AskQuestion", @"InfoPlist", @"回答") style:UIBarButtonItemStyleBordered target:self action:@selector(askButtonPress)] autorelease];
    //UIBarButtonItem *refresh = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(didRefreshButtonPress)] autorelease];
    self.navigationItem.leftBarButtonItem = askItem;
    //self.navigationItem.rightBarButtonItem = refresh;
    
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
#pragma mark 註冊/登入 帳號相關
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
#pragma mark 開始與遠端取得資料
- (void)startGetMyAreaPostWithAlertInd:(BOOL)ind
{
    if (![self checkKaxaNetReachable])
    {
        [self showAlertWithMessage:kaxaNetNotReachableMessage];
        return;
    }
    if (![self checkAccountAvailable])
    {
        if (![self checkAccountAvailable])
        {
            [self askAccountSource];
        }
        return;
    }
    if (ind)
        [self showAlertAnimation];
    //測試連結
    //http://kaxa.pimy.cc/phone_questionList.php?acc=chan&pass=1234
    //NSString *urlString = [NSString stringWithFormat:myAreaUrl,accountInfo.accountID,accountInfo.password];
    NSURL *url = [NSURL URLWithString:myAreaUrl2];
    poster = [[MyPostDelegate alloc] initWithType:MyPostDelegateTypeMyArea];
    [poster setDelegate:self];
    //[poster startPostWithUrl:url];
    [poster startGetMyAreaQuestionWithUrl:url andAccound:accountInfo.accountID];
}
- (BOOL)checkKaxaNetReachable
{
    NSString *kaxaReachableString = [[GlobalFunctions shareInstance] getAppInfoWithKey:kaxaNetReachableKey];
    NSLog(@"MyArea:%@",kaxaReachableString);
    if ([kaxaReachableString isEqualToString:kaxaNetNotReachableValue])
        return NO;
    return YES;
}
- (void)kaxaNetNotReachable:(NSNotification*)notify
{
    NSLog(@"MyArea:KaxaNetNotReachable");
    [[GlobalFunctions shareInstance] saveAppInfoWithKey:kaxaNetReachableKey andValue:kaxaNetNotReachableValue];
}
- (void)kaxaNetReachable:(NSNotification*)notify
{
    NSLog(@"MyArea:KaxaNetReachable");
    [[GlobalFunctions shareInstance] saveAppInfoWithKey:kaxaNetReachableKey andValue:kaxaNetReachableValue];
}

- (void)showAlertWithMessage:(NSString*)message
{
    UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:@"Info" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
    [alertView show];
}

- (void)showAlertAnimation
{
    UIActivityIndicatorView *activityView = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray] autorelease];
    [activityView startAnimating];
    self.loadingAlert = [[[CXAlertView alloc] initWithTitle:connectToKaxaNet message:@"" cancelButtonTitle:nil] autorelease];
    [_loadingAlert addButtonWithTitle:NSLocalizedStringFromTable(@"Cancel", @"InfoPlist", @"Cancel")
                                 type:CXAlertViewButtonTypeCancel
                              handler:^(CXAlertView *alertView, CXAlertButtonItem *button) {
                                  [poster cancelPost];
                                  [alertView dismiss];
                              }];
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

- (BOOL)checkAccountAvailable
{
    AccountCheck *acctCheck = [[AccountCheck alloc] init];
    accountInfo = [acctCheck  checkAccountInfo];
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

- (void)refresh
{
    [self startGetMyAreaPostWithAlertInd:YES];
}

@end
