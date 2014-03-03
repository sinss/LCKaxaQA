//
//  customDetailViewController.m
//  KaxaQ&A
//
//  Created by 張星星 on 12/4/12.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import "customDetailViewController.h"
#import "GlobalFunctions.h"

@interface customDetailViewController ()

- (BOOL)checkKaxaNetReachable;
- (void)kaxaNetNotReachable:(NSNotification*)notify;
- (void)kaxaNetReachable:(NSNotification*)notify;

- (void)startGetNewsDetailWithAlertInd:(BOOL)ind;
- (void)refreshContentTextView;

- (void)showAlertWithMessage:(NSString*)message;
- (void)showAlertAnimation;
- (void)closeAlertAnimation;

@end

@implementation customDetailViewController

@synthesize currentInfo;

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
    if (os_version >= 7.0)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(kaxaNetNotReachable:)
                                                 name:kaxaNetNotReachName
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(kaxaNetReachable:)
                                                 name:kaxaNetReachName
                                               object:nil];
    [self startGetNewsDetailWithAlertInd:YES];
}

- (void)dealloc
{
    [contentView release], contentView = nil;
    [alert release], alert = nil;
    [currentInfo release], currentInfo = nil;
    [newsDetailArray release], newsDetailArray = nil;
    [super dealloc];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
    alert = [[UIAlertView alloc] initWithTitle:connectToKaxaNet
                                       message:@"\n\n"
                                      delegate:self
                             cancelButtonTitle:@"Cancel"
                             otherButtonTitles:nil,nil];
    [alert setDelegate:self];
    
    [alert show];
    UIActivityIndicatorView *activityView = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge] autorelease];
    [activityView startAnimating];
    activityView.frame = CGRectMake(130,55,20,20);
    
    [alert addSubview:activityView];
    alertNeedClose = YES;
}
- (void)closeAlertAnimation
{
    if (alertNeedClose)
        [alert dismissWithClickedButtonIndex:0 animated:YES];
    alertNeedClose = NO;
    [poster release], poster = nil;
}

- (void)startGetNewsDetailWithAlertInd:(BOOL)ind
{
    if (![self checkKaxaNetReachable])
    {
        [self showAlertWithMessage:kaxaNetNotReachableMessage];
        return;
    }
    if (ind)
        [self showAlertAnimation];
    NSString *urlString = [NSString stringWithFormat:newsDetailUrl];
    poster = [[MyPostDelegate alloc] initWithType:MyPostDelegateTypeNewsDetail];
    [poster setDelegate:self];
    [poster startGetNewDetailWithUrl:[NSURL URLWithString:urlString] andNewsId:currentInfo.newsId];
}

- (void)refreshContentTextView
{
    if ([newsDetailArray count] > 0)
    {
        newsDetail *newDetail = [newsDetailArray objectAtIndex:0];
        [contentView setText:newDetail.content];
    }
    
}

#pragma mark - postDelegate
- (void)MyPostDelegate:(MyPostDelegate*)poster didFinishPost:(NSArray*)result
{
    NSLog(@"finish post! %@",result);
    newsDetailArray = [[NSArray alloc] initWithArray:result];
    [self closeAlertAnimation];
    [self refreshContentTextView];
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
@end
