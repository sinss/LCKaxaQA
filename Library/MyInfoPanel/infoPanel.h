//
//  infoPanel.h
//  infoPanel
//
//  Created by 張星星 on 12/3/27.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

typedef enum
{
    infoPanelTypeInfo,
    infoPanelTypeError
} infoPanelType;
@interface infoPanel : UIView
{
    UILabel *titleLabel;
    UILabel *detailLabel;
    
    UIImageView *thumbImage;
    UIImageView *backgroundGradient;
    
    SEL onTouched;
    
    id delegate;
    SEL onFinished;
    
    infoPanelType _type;
}
@property (nonatomic, assign) IBOutlet UILabel *titleLabel;
@property (nonatomic, assign) IBOutlet UILabel *detailLabel;
@property (nonatomic, assign) IBOutlet UIImageView *thumbImage;
@property (nonatomic, assign) IBOutlet UIImageView *backgroundGradient;
@property (nonatomic, assign) SEL onTouched;
@property (nonatomic, assign) id delegate;
@property (nonatomic, assign) SEL onFinished;

+(infoPanel*)showPanelInView:(UIView*)view type:(infoPanelType)type title:(NSString*)title subTitle:(NSString*)subTitle;
+(infoPanel*)showPanelInView:(UIView *)view type:(infoPanelType)type title:(NSString *)title subTitle:(NSString *)subTitle hideAfter:(NSTimeInterval)interval;
+(infoPanel*)showPanelInWindow:(UIWindow*)window type:(infoPanelType)type title:(NSString*)title subTitle:(NSString*)subTitle;
+(infoPanel*)showPanelInWindow:(UIWindow *)window type:(infoPanelType)type title:(NSString *)title subTitle:(NSString *)subTitle hideAfter:(NSTimeInterval)interval;

- (void)hidePanel;

@end
