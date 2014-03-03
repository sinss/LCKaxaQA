//
//  infoPanel.m
//  infoPanel
//
//  Created by 張星星 on 12/3/27.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import "infoPanel.h"
#import <QuartzCore/QuartzCore.h>

@interface infoPanel ()

@property (nonatomic, assign) infoPanelType type;

+ (infoPanel*)infoPanel;
- (void)setup;

@end

@implementation infoPanel

@synthesize titleLabel;
@synthesize detailLabel;
@synthesize thumbImage;
@synthesize backgroundGradient;
@synthesize onTouched;
@synthesize delegate;
@synthesize onFinished;
@synthesize type = _type;

#pragma mark - Lifecycle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setup];
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self setup];
    }
    return self;
}

- (void)dealloc
{
    [delegate performSelector:onFinished];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Setter/Getter

- (void)setType:(infoPanelType)type
{
    if (type == infoPanelTypeError)
    {
        //self.backgroundGradient.image = [[UIImage imageNamed:@"infoPanel_bg"] stretchableImageWithLeftCapWidth:1 topCapHeight:5];
        //self.backgroundGradient.image = [UIImage imageNamed:@"infoPanel_bg.png"];
        self.backgroundColor = [UIColor whiteColor];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        self.titleLabel.textColor = [UIColor blackColor];
        self.detailLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
        self.thumbImage.image = [UIImage imageNamed:@"icon.png"];
        self.detailLabel.textColor = [UIColor darkGrayColor];
        self.detailLabel.shadowColor = [UIColor lightTextColor];
    }
    else if (type == infoPanelTypeInfo)
    {
        //self.backgroundGradient.image = [[UIImage imageNamed:@"infoPanel_bg"] stretchableImageWithLeftCapWidth:1 topCapHeight:5];
        //self.backgroundGradient.image = [UIImage imageNamed:@"infoPanel_bg.png"];
        self.backgroundColor = [UIColor whiteColor];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        self.titleLabel.textColor = [UIColor blackColor];
        self.detailLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
        self.thumbImage.image = [UIImage imageNamed:@"icon.png"];
        self.detailLabel.textColor = [UIColor darkGrayColor];
        self.detailLabel.shadowColor = [UIColor lightTextColor];
    }
    //shadow view
    UIImageView *shadowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shadow.png"]];
    shadowView.contentMode = UIViewContentModeScaleToFill;
    shadowView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    shadowView.frame = self.bounds;
    //CGRect frame = self.frame;
    //shadowView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 0);
    [self addSubview:shadowView];
    [shadowView release];
    
    self.layer.shadowColor = [[UIColor darkGrayColor] CGColor];
    self.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    self.layer.shadowRadius = 3.0f;
    self.layer.shadowOpacity = 1.0f;
}

#pragma mark - Show/Hide

+(infoPanel*)showPanelInView:(UIView*)view type:(infoPanelType)type title:(NSString*)title subTitle:(NSString*)subTitle
{
    return [self showPanelInView:view type:type title:title subTitle:subTitle hideAfter:-1];
}
+(infoPanel*)showPanelInView:(UIView *)view type:(infoPanelType)type title:(NSString *)title subTitle:(NSString *)subTitle hideAfter:(NSTimeInterval)interval
{
    infoPanel *panel = [infoPanel infoPanel];
    CGFloat panelHeight = 50;
    
    panel.type = type;
    panel.titleLabel.text = title;
    
    if (subTitle)
    {
        panel.detailLabel.text = subTitle;
        [panel.detailLabel sizeToFit];
        
        panelHeight = MAX(CGRectGetMaxY(panel.thumbImage.frame), CGRectGetMaxY(panel.detailLabel.frame));
        panelHeight += 10.f;
    }
    else 
    {
        panel.detailLabel.hidden = YES;
        panel.thumbImage.frame = CGRectMake(15, 5, 35, 35);
        panel.titleLabel.frame = CGRectMake(57, 12, 240, 21);
    }
    panel.frame = CGRectMake(0, 0, view.bounds.size.width, panelHeight);
    [view addSubview:panel];
    
    if (interval > 0) 
    {
        [panel performSelector:@selector(hidePanel) withObject:view afterDelay:interval]; 
    }
    
    return panel;
}
+(infoPanel*)showPanelInWindow:(UIWindow*)window type:(infoPanelType)type title:(NSString*)title subTitle:(NSString*)subTitle
{
    return [self showPanelInWindow:window type:type title:title subTitle:subTitle hideAfter:-1];
}

+(infoPanel*)showPanelInWindow:(UIWindow *)window type:(infoPanelType)type title:(NSString *)title subTitle:(NSString *)subTitle hideAfter:(NSTimeInterval)interval 
{
    infoPanel *panel = [self showPanelInView:window type:type title:title subTitle:subTitle hideAfter:-1];
    
    if (![UIApplication sharedApplication].statusBarHidden)
    {
        CGRect frame = panel.frame;
        frame.origin.y += [UIApplication sharedApplication].statusBarFrame.size.height;
        panel.frame = frame;
    }
    
    return panel;
}

-(void)hidePanel 
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    CATransition *transition = [CATransition animation];
	transition.duration = 0.25;
	transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	transition.type = kCATransitionPush;	
	transition.subtype = kCATransitionFromTop;
	[self.layer addAnimation:transition forKey:nil];
    self.frame = CGRectMake(0, -self.frame.size.height, self.frame.size.width, self.frame.size.height); 
    [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.25];
}

#pragma mark - Touch Recognition

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self performSelector:onTouched];
}

#pragma mark - Private

+ (infoPanel*)infoPanel
{
    infoPanel *panel =  (infoPanel*)[[[UINib nibWithNibName:@"infoPanel" bundle:nil] 
                                           instantiateWithOwner:self options:nil] objectAtIndex:0];
    
    CATransition *transition = [CATransition animation];
	transition.duration = 0.25;
	transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	transition.type = kCATransitionPush;	
	transition.subtype = kCATransitionFromBottom;
	[panel.layer addAnimation:transition forKey:nil];
    
    return panel;
}
- (void)setup
{
    self.onTouched = @selector(hidePanel);
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
}
@end
