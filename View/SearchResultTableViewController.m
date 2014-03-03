//
//  SearchResultTableViewController.m
//  KaxaQ&A
//
//  Created by 張星星 on 12/1/31.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import "SearchResultTableViewController.h"
#import "GlobalFunctions.h"
#import "customQuestionCell2.h"
#import "CXAlertView.h"

@interface SearchResultTableViewController()
{
    BOOL isLoad;
}
@property (nonatomic, retain) CXAlertView *loadingAlert;

//private method
- (void)searchButtonPress;
- (void)createBarItem;
- (void)startSearchingPostWithAlertInd:(BOOL)ind;
- (BOOL)checkKaxaNetReachable;
- (void)kaxaNetNotReachable:(NSNotification*)notify;
- (void)kaxaNetReachable:(NSNotification*)notify;

- (void)showAlertWithMessage:(NSString*)message;
- (void)showAlertAnimation;
- (void)closeAlertAnimation;


- (BOOL)checkAccountAvailable;

@end

@implementation SearchResultTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        self.title = NSLocalizedStringFromTable(@"Search", @"InfoPlist", @"搜尋");
        self.tabBarItem.image = [UIImage imageNamed:searchTabImage];
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
    [resultList release], resultList = nil;
    [alert release], alert = nil;
    [currentSearchKey release], currentSearchKey = nil;
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
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    UIImageView *imageview = [[[UIImageView alloc] initWithImage:plainTableviewBg] autorelease];
    [self.tableView setBackgroundView:imageview];
    [self createBarItem];
    currentSearchKey = @"";  //預設空白為初值
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
    [[NSNotificationCenter defaultCenter] removeObserver:kaxaNetNotReachName];
    [[NSNotificationCenter defaultCenter] removeObserver:kaxaNetReachName];
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
    if (!isLoad)
    {
        [self searchButtonPress];
    }
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
    // Return the number of rows in the section.
    return [resultList count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return customQuestionCellHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *questionCellIdentifier = @"queationCellIdentifier";
    NSInteger row = [indexPath row];
    searchInfo *info = [resultList objectAtIndex:row];
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
    [cell.askerLabel setText:info.asker];
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
    QuestionDetailTableViewController *detailView = [[QuestionDetailTableViewController alloc] initWithStyle:UITableViewStylePlain];
    NSInteger row = [indexPath row];
    searchInfo *info = [resultList objectAtIndex:row];
    detailView.discussid = info.discussID;
    detailView.theme = info.theme;
    [self.navigationController pushViewController:detailView animated:YES];
    [detailView release];
}
#pragma mark - searchViewDeleagate
- (void)searchViewController:(SearchViewController *)view didSearchWithKeyword:(NSString *)keyword andEducationIndex:(NSInteger)eduInd andCourseIndex:(NSInteger)courseInd
{
    currentEducationInd = eduInd;
    currentCourseInd = courseInd;
    currentSearchKey = keyword;
    NSLog(@"education:%i, course:%i, keyword:%@",eduInd,courseInd,keyword);
    [self startSearchingPostWithAlertInd:YES];
}
#pragma mark - postDelegate
- (void)MyPostDelegate:(MyPostDelegate*)poster didFinishPost:(NSArray*)result
{
    NSLog(@"finish post! %@",result);
    resultList = [[NSArray alloc] initWithArray:result];
    [self.tableView reloadData];
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
    if (buttonIndex == 0)
    {
        if (poster != nil)
            [poster cancelPost];
    }
}
#pragma mark - user define function
- (void)searchButtonPress
{
    isLoad = YES;
    SearchViewController *searchView = [[[SearchViewController alloc] initWithNibName:@"SearchViewController" bundle:nil] autorelease];
    searchView.delegate = self;
    [searchView setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:searchView animated:YES completion:^
     {
         
     }];
}
- (void)createBarItem
{
    UIBarButtonItem *searchItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchButtonPress)] autorelease];
    self.navigationItem.leftBarButtonItem = searchItem;
}
- (void)startSearchingPostWithAlertInd:(BOOL)ind
{
    if (![self checkKaxaNetReachable])
    {
        [self showAlertWithMessage:kaxaNetNotReachableMessage];
        return;
    }
    if (ind)
        [self showAlertAnimation];
    //NSString *urlString = [NSString stringWithFormat:searchUrl2, currentSearchKey, currentEducationInd, currentCourseInd];
    
    NSURL *url = [NSURL URLWithString:[searchUrl3 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    poster = [[MyPostDelegate alloc] initWithType:MyPostDelegateTypeSearch];
    [poster setDelegate:self];
    //[poster startPostWithUrl:url];
    [poster startSearchWithUrl:url andSearchKey:currentSearchKey andEducation:currentEducationInd andCource:currentCourseInd];
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
    NSLog(@"Search:KaxaNetNotReachable");
    [[GlobalFunctions shareInstance] saveAppInfoWithKey:kaxaNetReachableKey andValue:kaxaNetNotReachableValue];
}
- (void)kaxaNetReachable:(NSNotification*)notify
{
    NSLog(@"Search:KaxaNetReachable");
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
@end
