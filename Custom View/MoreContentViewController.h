//
//  MoreContentViewController.h
//  SlyCool001Project
//
//  Created by sinss on 12/8/12.
//
//

#import <UIKit/UIKit.h>

@class slyCoolC;
@interface MoreContentViewController : UIViewController
<UIWebViewDelegate>
{
    NSURL *currentUrl;
    IBOutlet UIWebView *webView;
    IBOutlet UIActivityIndicatorView *activityView;
}

@property (nonatomic, retain) NSURL *currentUrl;

- (IBAction)backItemPress:(id)sender;
- (IBAction)nextItemPress:(id)sender;
- (IBAction)closeItemPress:(id)sender;
@end
