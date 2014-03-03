//
//  textfieldCell.h
//  KaxaQ&A
//
//  Created by 張星星 on 12/1/30.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import <UIKit/UIKit.h>

@class textfieldCell;
@protocol textfieldCellDelegate <NSObject>

- (void)textfieldCell:(textfieldCell*)cell didPressLoginButtonWithAccount:(NSString*)account andPassword:(NSString*)password andKeepInd:(BOOL)keepInd;

@end

@interface textfieldCell : UITableViewCell<UITextFieldDelegate>
{
    UITextField *accountTextField;
    UITextField *passwordTextField;
    UISwitch *keepAccountSwitch;
    id<textfieldCellDelegate> delegate;
}
@property (nonatomic, retain) IBOutlet UITextField *accountTextField;
@property (nonatomic, retain) IBOutlet UITextField *passwordTextField;
@property (nonatomic, retain) IBOutlet UISwitch *keepAccountSwitch;
@property (assign) id<textfieldCellDelegate> delegate;

- (IBAction)loginButtonPress:(id)sender;
- (IBAction)resetButtonPress:(id)sender;

@end
