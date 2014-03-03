//
//  QuestionDetailTableViewController.m
//  KaxaQ&A
//
//  Created by 張星星 on 12/2/6.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import "QuestionDetailTableViewController.h"
#import "questionDetail.h"
#import "MoreContentViewController.h"
#import "CXAlertView.h"

@interface QuestionDetailTableViewController()

@property (nonatomic, retain) CXAlertView *loadingAlert;

- (void)createBarButton;
- (BOOL)checkKaxaNetReachable;
- (void)showAlertWithMessage:(NSString*)message;
- (void)showAlertAnimation;
- (void)closeAlertAnimation;

- (void)startGetDetailPostWithAlert:(BOOL)ind;

- (void)replyQuestion;

@end

@implementation QuestionDetailTableViewController
@synthesize discussid, theme;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) 
    {
        // Custom initialization
        self.title = NSLocalizedStringFromTable(@"Detail", @"InfoPlist", nil);
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
    [theme release], theme = nil;
    [questionArray release], questionArray = nil;
    [answerTitleArray release], answerTitleArray = nil;
    [answerArray release], answerArray = nil;
    [alert release], alert = nil;
    [_loadingAlert release], _loadingAlert = nil;
    poster = nil;
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
    isLoad = NO;
    UIImageView *imageview = [[[UIImageView alloc] initWithImage:plainTableviewBg] autorelease];
    [self.tableView setBackgroundView:imageview];
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(kaxaNetNotReachable:)
                                                 name:kaxaNetNotReachName 
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(kaxaNetReachable:)
                                                 name:kaxaNetReachName 
                                               object:nil];
    [self createBarButton];
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
        [self startGetDetailPostWithAlert:YES];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [questionArray count];
}
/*
- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return @"Question";
  return [NSString stringWithFormat:@"Reply %i",section];
}
 */
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGRect rect = CGRectMake(0, 0, 320, 30);
    UIView *titleView = [[[UIView alloc] initWithFrame:rect] autorelease];
    UIImageView *imageView;
    UILabel *label = [[[UILabel alloc] initWithFrame:rect] autorelease];
    [label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
    if (section == 0)
        [label setText:@"Question"];
    else 
        [label setText:[NSString stringWithFormat:@"Answer: %i",section]];
    imageView = [[[UIImageView alloc] initWithImage:myareaHeaderBg1] autorelease];
    label.frame = rect;
    [label setTextColor:[UIColor whiteColor ]];
    [label setBackgroundColor:[UIColor clearColor]];
    imageView.frame = rect;
    [titleView addSubview:imageView];
    [titleView addSubview:label];
    return titleView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 282;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *questionCellIdentifier = @"questionCellIdentifier";
    NSInteger row = [indexPath row];
    
    questionDetail *question = [questionArray objectAtIndex:0];
    if (row == 0)
    {
        customQuestionDetailCell2 *cell = [self.tableView dequeueReusableCellWithIdentifier:questionCellIdentifier];
        if (cell == nil)
        {
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"customQuestionDetailCell2" owner:self options:nil];
            for (id currentObj in topLevelObjects)
            {
                if ([currentObj isKindOfClass:[customQuestionDetailCell2 class]])
                {
                    cell = currentObj;
                }
                break;
            }
            //[cell setDelegate:self];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            //[cell initImageViewWithUrl:[NSURL URLWithString:currentQuestionInfo.imageUrl] andImageName:currentQuestionInfo.imageName];
            [cell setImageArrayWithImageArray:question.imageArray andAskerId:question.askerid];
            [cell setDelegate:self];
        }
        isLoad = YES;
        [cell.titleLabel setText:question.title];
        [cell.degreeLabel setText:question.degree];
        [cell.subjectLabel setText:question.subject];
        [cell.askerLabel setText:question.asker];
        [cell.dateLabel setText:question.date];
        [cell setContentMessage:question.content];
        [cell setYoutubeKey:question.youtubeKey];
        [cell setAskerid:question.askerid];
        if ([question.content isEqualToString:@""])
        {
            [cell.contentButton setHidden:YES];
        }
        else
        {
            [cell.contentButton setHidden:NO];
        }
        if ([question.youtubeKey isEqualToString:@""])
        {
            [cell.youtubeButton setHidden:YES];
        }
        else
        {
            [cell.youtubeButton setHidden:NO];
        }
        return cell;
    }
    else
    {
        //回答問題
        answerDetail *info = [questionArray objectAtIndex:row];
        customQuestionDetailCell2 *cell = [self.tableView dequeueReusableCellWithIdentifier:questionCellIdentifier];
        if (cell == nil)
        {
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"customQuestionDetailCell2" owner:self options:nil];
            for (id currentObj in topLevelObjects)
            {
                if ([currentObj isKindOfClass:[customQuestionDetailCell2 class]])
                {
                    cell = currentObj;
                }
                break;
            }
            //[cell setDelegate:self];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setDelegate:self];
            [cell setImageArrayWithImageArray:info.imageArray andAskerId:info.replierid];
            //[cell initImageViewWithUrl:[NSURL URLWithString:currentQuestionInfo.imageUrl] andImageName:currentQuestionInfo.imageName];
        }
        [cell.titleLabel setText:question.title];
        [cell.subjectLabel setText:question.subject];
        [cell.degreeLabel setText:question.degree];
        [cell.askerLabel setText:info.replier];
        [cell.dateLabel setText:info.date];
        [cell setContentMessage:info.content];
        [cell setYoutubeKey:info.youtubeKey];
        [cell setAskerid:question.askerid];
        if ([info.content isEqualToString:@""])
        {
            [cell.contentButton setHidden:YES];
        }
        else
        {
            [cell.contentButton setHidden:NO];
        }
        if ([info.youtubeKey isEqualToString:@""])
        {
            [cell.youtubeButton setHidden:YES];
        }
        else
        {
            [cell.youtubeButton setHidden:NO];
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

}
#pragma mark - postDelegate
- (void)MyPostDelegate:(MyPostDelegate*)poster didFinishPost:(NSArray*)result
{
    NSLog(@"finish post! %@",result);
    //將取得的結果分開為問題與回答
    questionArray = [[NSArray alloc] initWithArray:result];
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
#pragma mark - askTableView delegate
- (void)askTableView:(AskTableViewController *)view didFinishUploadData:(BOOL)statusInd
{
    if (statusInd)
    {
        [self startGetDetailPostWithAlert:YES];
    }
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
- (void)createBarButton
{
    UIBarButtonItem *reply = [[[UIBarButtonItem alloc] initWithTitle:NSLocalizedStringFromTable(@"ReplyQuestion", @"InfoPlist", nil) style:UIBarButtonItemStylePlain target:self action:@selector(replyQuestion)] autorelease];
    self.navigationItem.rightBarButtonItem = reply;
}
- (void)startGetDetailPostWithAlert:(BOOL)ind
{
    NSLog(@"qid:%@",discussid);
    if (![self checkKaxaNetReachable])
    {
        [self showAlertWithMessage:kaxaNetNotReachableMessage];
        return;
    }
    if (ind)
        [self showAlertAnimation];
    //測試連結
    //NSString *urlString = [NSString stringWithFormat:detailUrl2 , discussid];
    //NSURL *url = [NSURL URLWithString:urlString];
    poster = [[MyPostDelegate alloc] initWithType:MyPostDelegateTypeDetail];
    [poster setDelegate:self];
    [poster startGetQuestionDetailWithUrl:[NSURL URLWithString:detailUrl2] andDiscussid:discussid];
}
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
    NSLog(@"QuestionDetail:KaxaNetNotReachable");
    [[GlobalFunctions shareInstance] saveAppInfoWithKey:kaxaNetReachableKey andValue:kaxaNetNotReachableValue];
}
- (void)kaxaNetReachable:(NSNotification*)notify
{
    NSLog(@"QuestionDetail:KaxaNetReachable");
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

- (void)replyQuestion
{
    if (questionArray == nil)
    {
        return;
    }
    if ([questionArray count] == 0)
    {
        return;
    }
    questionDetail *question = [questionArray objectAtIndex:0];
    AskTableViewController *askView = [[[AskTableViewController alloc] initWithStyle:UITableViewStylePlain AndQuestionType:askQuestionActionReply] autorelease];
    askView.discussid = discussid;
    askView.currInfo = question;
    UINavigationController *askNav = [[[UINavigationController alloc] initWithRootViewController:askView] autorelease];
    //[self.navigationController pushViewController:askView animated:YES];
    [askView setDelegate:self];
    //[self presentModalViewController:askNav animated:YES];
    [self presentViewController:askNav animated:YES completion:^
     {
         
     }];
}

#pragma mark - questionDetail delegate

- (void)questionDetailView:(customQuestionDetailCell2 *)cell viewLargeImageWithImage:(UIImage *)image
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NSUInteger row = [indexPath row];
    NSString *showTitle = nil;
    if (row == 0)
    {
        questionDetail *question = [questionArray objectAtIndex:row];
        showTitle = [NSString stringWithFormat:@"%@",question.title];
    }
    else
    {
        answerDetail *asnwer = [questionArray objectAtIndex:row];
        showTitle = [NSString stringWithFormat:@"%@",asnwer.content];
    }
    /*
    MyPhoto *photo = [[MyPhoto alloc] initWithImage:image name:showTitle];
    MyPhotoSource *source = [[MyPhotoSource alloc] initWithPhotos:[NSArray arrayWithObjects:photo, nil]];
    
    EGOPhotoViewController *photoController = [[EGOPhotoViewController alloc] initWithPhotoSource:source];
    [self.navigationController pushViewController:photoController animated:YES];
    
    [photoController release];
    [photo release];
    [source release];
     */
    ImageCropper *cropper = [[ImageCropper alloc] initWithImage:image];
	[cropper setDelegate:self];
	
    [self presentViewController:cropper animated:YES completion:nil];
	
	[cropper release];
}

- (void)questionDetailView:(customQuestionDetailCell2 *)cell viewYoutubeWithUrl:(NSURL *)url
{
    MoreContentViewController *moreContentView = [[MoreContentViewController alloc] initWithNibName:@"MoreContentViewController" bundle:nil];
    [moreContentView setCurrentUrl:url];
    [moreContentView setModalTransitionStyle:UIModalTransitionStylePartialCurl];
    [self presentViewController:moreContentView animated:YES completion:^
     {
         
     }];
}

#pragma mark - ImageCropperDelegate

- (void)imageCropper:(ImageCropper *)cropper didFinishCroppingWithImage:(UIImage *)image
{
	
	[self dismissViewControllerAnimated:YES completion:^
     {
         
     }];
	
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}

- (void)imageCropperDidCancel:(ImageCropper *)cropper
{
	[self dismissViewControllerAnimated:YES completion:^
     {
         
     }];
	
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}

- (void)refresh
{
    //[self performSelector:@selector(startGetDetailPostWithAlert) withObject:YES afterDelay:2.0];
    [self startGetDetailPostWithAlert:YES];
}


@end
