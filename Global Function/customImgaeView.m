//
//  customImgaeView.m
//  MyImageAsync
//
//  Created by 張星星 sinss on 11/11/26.
//  Copyright (c) 2011年 星星工作室. All rights reserved.
//

#import "customImgaeView.h"
#import "ProcessImage.h"
#import "UIImage+Extras.h"

@interface customImgaeView()

- (void)buttonPress:(UIButton*)sender;

@end

@implementation customImgaeView

@synthesize currentImageName, delegate;

- (id)initWithFrame:(CGRect)frame andImageName:(NSString*)imageName andSmallInd:(BOOL)ind;
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        CGRect rectSubView = CGRectMake(0,
                                        0,
                                        frame.size.width,
                                        frame.size.height);
        aImageView = [[UIImageView alloc] initWithFrame:rectSubView];
        aImageView.contentMode = UIViewContentModeScaleAspectFit;
        aImageButton = [[UIButton alloc] initWithFrame:rectSubView];
        [aImageButton setContentMode:UIViewContentModeScaleAspectFit];
        //[self addSubview:aImageView];
        activityView = [[UIActivityIndicatorView alloc] initWithFrame:rectSubView];
        activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        activityView.hidesWhenStopped = YES;
        [self addSubview:activityView];
        [self addSubview:aImageButton];
        currentImageName = [[NSString alloc] initWithFormat:@"%@",imageName];
        smallInd = ind;
    }
    return self;
}

- (void)downloadAndDisplayImageWithURL:(NSURL*)imageURL;
{
    [aImageButton setTag:[self tag]];
    [aImageButton addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
    [aImageButton setImage:[[UIImage imageNamed:loadingImageName] imageByScalingProportionallyToSize:CGSizeMake(200,200)] forState:UIControlStateNormal];
    //[aImageButton setImage:[UIImage imageNamed:@"loading.png"] forState:UIControlStateNormal];
    //[aImageView setImage:[UIImage imageNamed:@"loading.png"]];
    if ([currentImageName length] > 0)
    {
        NSString *imagePath = NSTemporaryDirectory();
        imagePath = [imagePath stringByAppendingPathComponent:currentImageName];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@",imagePath]])
        {
            UIImage *imageObject;
            NSLog(@"%@ exists",imagePath);
            if (smallInd)
            {
                imageObject = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@s",imagePath]];
                //[aImageView setImage:imageObject];
                [aImageButton setImage:[imageObject imageByScalingProportionallyToSize:CGSizeMake(imageObject.size.width,imageObject.size.height)] forState:UIControlStateNormal];
                //[aImageButton setImage:imageObject forState:UIControlStateNormal];
            }
            else 
            {
                imageObject = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@",imagePath]];
                //[aImageView setImage:imageObject];
                [aImageButton setImage:[imageObject imageByScalingProportionallyToSize:CGSizeMake(imageObject.size.width,imageObject.size.height)] forState:UIControlStateNormal];
                //[aImageButton setImage:imageObject forState:UIControlStateNormal];
            }
            imagePath = nil;
            imageObject = nil;
            return;
        }
        else
        {
            NSLog(@"%@ not exist",imagePath);
        }
    }
    NSURLRequest *aRequest = [NSURLRequest requestWithURL:imageURL
                              cachePolicy:NSURLRequestReloadIgnoringCacheData
                                          timeoutInterval:120];
    NSURLConnection *aConnection = [NSURLConnection connectionWithRequest:aRequest
                                                                 delegate:self];
    if (aConnection)
    {
        responseData = [[NSMutableData alloc] init];
    }
    else
    {
        //error
    }
    [activityView startAnimating];
}
- (UIImage*)getImage
{
    return [aImageView image];
}
#pragma mark - NSURLConnection delegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData*)data
{
    [responseData appendData:data]; //  Data will be appended to here!
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError*)error
{
    [responseData release];
    responseData = nil;
    
    [activityView stopAnimating];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    UIImage *imageObject = [UIImage imageWithData:responseData];
    [aImageButton addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
    if (imageObject == nil)
    {
        //[aImageButton setImage:[UIImage imageNamed:@"noImage.jpeg"] forState:UIControlStateNormal];
        //[aImageButton setImage:[[UIImage imageNamed:noImageName] imageByScalingProportionallyToSize:CGSizeMake(imageObject.size.width,imageObject.size.height)] forState:UIControlStateNormal];
        [aImageButton setImage:[UIImage imageNamed:noImageName] forState:UIControlStateNormal];
    }
    else
    {
        //[aImageButton setImage:imageObject forState:UIControlStateNormal];
        [aImageButton setImage:[imageObject imageByScalingProportionallyToSize:CGSizeMake(imageObject.size.width,imageObject.size.height)] forState:UIControlStateNormal];
        //[aImageView setImage:imageObject];
        //儲存image至暫存資料夾
        NSString *imagePath = NSTemporaryDirectory();
        imagePath = [imagePath stringByAppendingPathComponent:currentImageName];
        //[responseData writeToFile:[NSString stringWithFormat:@"%@",imagePath] atomically:YES];
        [[ProcessImage shareInstance] saveImage:imageObject imageName:imagePath];
        NSLog(@"save %@",imagePath);
    }
    
    // Release respondData
    [responseData release];
    responseData = nil;
    imageObject = nil;
    [activityView stopAnimating];
}

- (void)dealloc
{
    [activityView removeFromSuperview];
    [aImageView release], aImageView = nil;
    [activityView release], activityView = nil;
    [responseData release], responseData = nil;
    [currentImageName release], currentImageName = nil;
    [aImageButton release], aImageButton = nil;
    [super dealloc];
}

- (void)buttonPress:(UIButton *)sender
{
    //[delegate didPressButtonWithTag:sender.tag];
    [delegate didPressButtonWithImage:[aImageButton.imageView image]];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
