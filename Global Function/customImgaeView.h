//
//  customImgaeView.h
//  MyImageAsync
//
//  Created by 張星星 sinss on 11/11/26.
//  Copyright (c) 2011年 星星工作室. All rights reserved.
//

#import <UIKit/UIKit.h>

@class customImgaeViewDelegate;
@protocol customImageViewButtonDelegate <NSObject>

- (void)didPressButtonWithTag:(NSInteger)imageTag;
- (void)didPressButtonWithImage:(UIImage*)image;

@end

@interface customImgaeView : UIView
{
    id <customImageViewButtonDelegate> delegate;
    UIImageView *aImageView;
    UIButton *aImageButton;
    UIActivityIndicatorView *activityView;
    NSMutableData *responseData;
    NSString* currentImageName;
    BOOL smallInd;
}

@property (assign) id <customImageViewButtonDelegate> delegate;
@property (nonatomic, retain) NSString *currentImageName;

- (id)initWithFrame:(CGRect)frame andImageName:(NSString*)imageName andSmallInd:(BOOL)ind;
- (void)downloadAndDisplayImageWithURL:(NSURL*)imageURL;
- (UIImage*)getImage;

@end
