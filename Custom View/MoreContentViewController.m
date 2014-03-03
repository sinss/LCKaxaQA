//
//  MoreContentViewController.m
//  SlyCool001Project
//
//  Created by sinss on 12/8/12.
//
//

#import "MoreContentViewController.h"
#import "infoPanel.h"

@interface MoreContentViewController ()

@end

@implementation MoreContentViewController
@synthesize currentUrl;

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
    [webView setDelegate:self];
    [webView loadRequest:[NSURLRequest requestWithURL:currentUrl]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void) dealloc
{
    [currentUrl release], currentUrl = nil;
    [webView release], webView = nil;
    [activityView release], activityView = nil;
    [super dealloc];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - UIWebView delegate

- (void)webViewDidStartLoad:(UIWebView *)web
{
    [activityView startAnimating];
}
- (void)webViewDidFinishLoad:(UIWebView *)web
{
    [activityView stopAnimating];
    [infoPanel showPanelInView:webView type:infoPanelTypeInfo title:@"提示訊息" subTitle:@"網頁載入完成" hideAfter:3];
}
- (void)webView:(UIWebView *)web didFailLoadWithError:(NSError *)error
{
    [activityView stopAnimating];
    [infoPanel showPanelInView:webView type:infoPanelTypeError title:@"提示訊息" subTitle:@"網頁載入失敗" hideAfter:3];
}

- (IBAction)backItemPress:(id)sender
{
    [webView goBack];
}
- (IBAction)nextItemPress:(id)sender
{
    [webView goForward];
}
- (IBAction)closeItemPress:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
