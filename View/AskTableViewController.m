//
//  AskTableViewController.m
//  KaxaQ&A
//
//  Created by 張星星 on 12/2/2.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import "AskTableViewController.h"
#import "CXAlertView.h"

@interface AskTableViewController()

@property (nonatomic, retain) CXAlertView *loadingAlert;

- (void)askPicutreSource;
- (void)takePictureWithButtonIndex:(NSInteger)buttonIndex;
- (void)createBarItem;
- (void)startUploadQuestionWithalertInd:(BOOL)ind;

- (BOOL)checkKaxaNetReachable;
- (void)kaxaNetNotReachable:(NSNotification*)notify;
- (void)kaxaNetReachable:(NSNotification*)notify;

- (void)showAlertWithMessage:(NSString*)message;
- (void)showAlertAnimation;
- (void)closeAlertAnimation;
@end

@implementation AskTableViewController

@synthesize delegate;
@synthesize discussid, currInfo, theme;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        // Custom initialization
    }
    return self;
}
- (id)initWithStyle:(UITableViewStyle)style AndQuestionType:(askQuestionAction)type
{
    self = [super initWithStyle:style];
    if (self)
    {
        questionType = type;
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
    [introList release], introList = nil;
    [currentIndexPath release], currentIndexPath = nil;
    [alert release], alert = nil;
    [postProgessBar release], postProgessBar = nil;
    [accountInfo release], accountInfo = nil;
    [newInfo release], newInfo = nil;
    [theme release], theme = nil;
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
    UIImageView *imageview = [[[UIImageView alloc] initWithImage:plainTableviewBg] autorelease];
    [self.tableView setBackgroundView:imageview];
    [self.tableView setSeparatorColor:[UIColor lightGrayColor]];
    if (introList == nil)
    {
        if (questionType == askQuestionActionCreate)
        {
            introList = [[NSArray alloc] initWithObjects:
                         NSLocalizedStringFromTable(@"PickPicture", @"InfoPlist", nil),
                         NSLocalizedStringFromTable(@"Subject", @"InfoPlist", nil),
                         NSLocalizedStringFromTable(@"Title", @"InfoPlist", nil),
                         NSLocalizedStringFromTable(@"Content", @"InfoPlist", nil),nil];
            /*
            introList = [[NSArray alloc] initWithObjects:
                         NSLocalizedStringFromTable(@"PickPicture", @"InfoPlist", nil),
                         NSLocalizedStringFromTable(@"Subject", @"InfoPlist", nil),
                         NSLocalizedStringFromTable(@"School", @"InfoPlist", nil),
                         NSLocalizedStringFromTable(@"Title", @"InfoPlist", nil),
                         NSLocalizedStringFromTable(@"Content", @"InfoPlist", nil),nil];
             */
        }
        else if (questionType == askQuestionActionReply)
        {
            //回答問題少一個欄位
            introList = [[NSArray alloc] initWithObjects:
                         NSLocalizedStringFromTable(@"PickPicture", @"InfoPlist", nil),
                         NSLocalizedStringFromTable(@"Subject", @"InfoPlist", nil),
                         NSLocalizedStringFromTable(@"Content", @"InfoPlist", nil)
                         ,nil];
        }
    }
    if (newInfo == nil)
    {
        newInfo = [[questionDetail alloc] init];
    }
    newInfo.discussid = discussid;
    [self createBarItem];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return [introList count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
/*
- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [introList objectAtIndex:section];
}
 */
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGRect rect = CGRectMake(0, 0, 320, 30);
    UIView *titleView = [[[UIView alloc] initWithFrame:rect] autorelease];
    UIImageView *imageView;
    UILabel *label = [[[UILabel alloc] initWithFrame:rect] autorelease];
    [label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
    [label setText:[introList objectAtIndex:section]];
    imageView = [[[UIImageView alloc] initWithImage:myareaHeaderBg1] autorelease];
    label.frame = rect;
    [label setTextColor:[UIColor whiteColor]];
    [label setBackgroundColor:[UIColor clearColor]];
    imageView.frame = rect;
    [titleView addSubview:imageView];
    [titleView addSubview:label];
    return titleView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger sec = [indexPath section];
    if (sec == askTableViewOptionPicture)
    {
        return MyPictureTableViewCellHeight;
    }
    return askTableViewCellHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *otherWithNoneSelectCellIdentifier = @"otherWithNoneSelectCellIdentifier";
    static NSString *pictureCellIdentifier = @"pictureCellIdentifier";
    static NSString *titleCellIdentifier = @"titleCellIdentifier";
    static NSString *singleLabelCellIdentifier = @"singleLabelCellIdentifier";
    NSInteger sec = [indexPath section];
    if (sec == askTableViewOptionPicture)
    {
        MyPictureTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:pictureCellIdentifier];
        if (cell == nil)
        {
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"MyPictureTableViewCell" owner:self options:nil];
            for (id currentObj in topLevelObjects)
            {
                if ([currentObj isKindOfClass:[MyPictureTableViewCell class]])
                {
                    cell = currentObj;
                }
                break;
            }
            [cell setDelegate:self];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            [cell setAccessoryType:UITableViewCellAccessoryNone];
        }
        //if (questionType == askQuestionActionCreate)
        [cell.reminderImageView setImage:[UIImage imageWithContentsOfFile:newInfo.imageFilePath]];
        return cell;
    }
    else if (sec == askTableViewOptionTitle)
    {
        customSingleTextFieldCell *cell = [self.tableView dequeueReusableCellWithIdentifier:titleCellIdentifier];
        if (cell == nil)
        {
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"customSingleTextFieldCell" owner:self options:nil];
            for (id currentObj in topLevelObjects)
            {
                if ([currentObj isKindOfClass:[customSingleTextFieldCell class]])
                {
                    cell = currentObj;
                }
                break;
            }
            [cell setAccessoryType:UITableViewCellAccessoryNone];
            if (questionType == askQuestionActionCreate)
                [cell.contentTextField setPlaceholder:NSLocalizedStringFromTable(@"PleaseEnterTitle", @"InfoPlist", nil)];
            else if (questionType == askQuestionActionReply)
                [cell.contentTextField setPlaceholder:NSLocalizedStringFromTable(@"PleaseEnterContent", @"InfoPlist", nil)];
            [cell.contentTextField setDelegate:self];
        }
        if (questionType == askQuestionActionCreate)
            [cell.contentTextField setText:newInfo.title];
        return cell;

    }
    else if (sec == askTableViewOptionContent)
    {
        customSingleLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:singleLabelCellIdentifier];
        if (cell == nil) 
        {
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"customSingleLabelCell" owner:self options:nil];
            for (id currentObj in topLevelObjects)
            {
                if ([currentObj isKindOfClass:[customSingleLabelCell class]])
                {
                    cell = currentObj;
                }
                break;
            }
            [cell setAccessoryType:UITableViewCellAccessoryNone];
        }
        if (questionType == askQuestionActionCreate)
            [cell.contentLabel setText:newInfo.content];
        return cell;
    }
    else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:otherWithNoneSelectCellIdentifier];
        if (cell == nil) 
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:otherWithNoneSelectCellIdentifier] autorelease];
        }
        if (questionType == askQuestionActionCreate)
        {
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            [cell.detailTextLabel setText:[[GlobalFunctions shareInstance] getTopicNameWithIndex:[newInfo.topic integerValue]]];
        }
        else if(questionType == askQuestionActionReply)
        {
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            [cell.detailTextLabel setText:[[GlobalFunctions shareInstance] getTopicNameWithIndex:[newInfo.topic integerValue]]];
        }
        [cell.textLabel setText:NSLocalizedStringFromTable(@"Select", @"InfoPlist", nil)];
        //[cell.detailTextLabel setText:NSLocalizedStringFromTable(@"All", @"InfoPlist", nil)];
        return cell;

    }
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
    NSInteger sec = [indexPath section];
    currentIndexPath = indexPath;
    [currentIndexPath retain];
    if (sec == askTableViewOptionContent)
    {
        customTextViewController *contentView = [[customTextViewController alloc] initWithNibName:@"customTextViewController" bundle:nil];
        [contentView setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        NSLog(@"newInfo.content:%@",newInfo.content);
        [contentView setCurrentString:newInfo.content];
        [contentView setDelegate:self];
        
        [self presentViewController:contentView animated:YES completion:^
         {
             
         }];
        [contentView release];
    }
    else if (sec == askTableViewOptionTopic && questionType == askQuestionActionCreate)
    {
        topicSelectViewController *topicView = [[topicSelectViewController alloc] initWithNibName:@"topicSelectViewController" bundle:nil];
        [topicView setModalTransitionStyle:UIModalTransitionStylePartialCurl];
        [topicView setModalPresentationStyle:UIModalPresentationFormSheet];
        [topicView setDelegate:self];
        [topicView setTopicIndex:[newInfo.topic integerValue]];
        [self presentViewController:topicView animated:YES completion:^
         {
             
         }];
        [topicView release];
    }
    else if (sec == askTableViewOptionTopic &&  questionType == askQuestionActionReply)
    {
        topicSelectViewController *topicView = [[topicSelectViewController alloc] initWithNibName:@"topicSelectViewController" bundle:nil];
        [topicView setModalTransitionStyle:UIModalTransitionStylePartialCurl];
        [topicView setModalPresentationStyle:UIModalPresentationFormSheet];
        [topicView setDelegate:self];
        [topicView setTopicIndex:[newInfo.topic integerValue]];
        [self presentViewController:topicView animated:YES completion:^
         {
             
         }];
        [topicView release];
    }
    /*
     
     科目與年級改成討論區形式
     
    else if (sec == askTableViewOptionCourse && questionType == askQuestionActionCreate)
    {
        customPickCourseViewController *pickerCourseView = [[[customPickCourseViewController alloc] initWithNibName:@"customPickCourseViewController" bundle:nil] autorelease];
        [pickerCourseView setModalTransitionStyle:UIModalTransitionStylePartialCurl];
        [pickerCourseView setModalPresentationStyle:UIModalPresentationFormSheet];
        [pickerCourseView setDelegate:self];
        [self presentViewController:pickerCourseView animated:YES completion:^
         {
             
         }];
    }
    else if (sec == askTableViewOptionEducation && questionType == askQuestionActionCreate)
    {
        customPickEducationViewController *pickerCourseView = [[[customPickEducationViewController alloc] initWithNibName:@"customPickEducationViewController" bundle:nil] autorelease];
        [pickerCourseView setModalTransitionStyle:UIModalTransitionStylePartialCurl];
        [pickerCourseView setModalPresentationStyle:UIModalPresentationFormSheet];
        [pickerCourseView setDelegate:self];
        [self presentViewController:pickerCourseView animated:YES completion:^
         {
             
         }];
    }
     */
}

#pragma mark - MyPictureCellDelegate
- (void)MyPictureTableViewCell:(MyPictureTableViewCell *)cell didPressButton:(MyPictureTableViewCellButtonType)pressButtonIndex
{
    if (pressButtonIndex == 0)
        [self askPicutreSource];
    else
    {
        //MyPhoto *photo = [[MyPhoto alloc] initWithImageURL:[NSURL URLWithString:@"https://s3.amazonaws.com/twitter_production/profile_images/425948730/DF-Star-Logo.png"]];
        MyPhoto *photo = [[MyPhoto alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:newInfo.imageFilePath] name:newInfo.content];
		MyPhotoSource *source = [[MyPhotoSource alloc] initWithPhotos:[NSArray arrayWithObjects:photo, nil]];
		
		EGOPhotoViewController *photoController = [[EGOPhotoViewController alloc] initWithPhotoSource:source];
		[self.navigationController pushViewController:photoController animated:YES];
		
        [photo release];
        [source release];
		[photoController release];
    }
}
#pragma mark - customTextViewController delegate
- (void)customTextView:(customTextViewController *)view didConfirmButtonPressWithContent:(NSString *)contentText
{
    NSLog(@"contentText:%@",contentText);
    newInfo.content = contentText;
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:currentIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}
#pragma mark - navitagionController delegate
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [navigationController.navigationItem setTitle:@""];
}
#pragma mark - actionsheet deelgate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self takePictureWithButtonIndex:buttonIndex];
}
#pragma mark - UIImagePickerControllerDelegate
//新的方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    if ([mediaType isEqualToString:@"public.image"])
    {
        UIImage *resultImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        resultImage = [resultImage fixOrientation];
        //將照片儲存至圖庫
        //UIImageWriteToSavedPhotosAlbum(resultImage,self,@selector(image:didFinishSavingWithError:contextInfo:), nil);
        
        [self performSelectorOnMainThread:@selector(image:didFinishSavingWithError:contextInfo:) withObject:resultImage waitUntilDone:YES];
    }
    else if ([mediaType isEqualToString:@"public.movie"])
    {
        NSString *movieFilePath = [[info objectForKey:UIImagePickerControllerOriginalImage]
                                   path];
        [infoPanel showPanelInView:self.view type:infoPanelTypeError title:@"Info" subTitle:movieFilePath hideAfter:2];
    }
}
- (void)image:(UIImage*)image didFinishSavingWithError:(NSError*)error contextInfo:(NSDictionary*)info
{
    //同時將照片儲存至document資料夾中，同時更新pictureCell
    NSString *imageFilePath = [[GlobalFunctions shareInstance] getDocumentFullPath:[NSString stringWithFormat:@"%@.png",@"askquestion"]];
    [[ProcessImage shareInstance] saveImage:image imageName:imageFilePath];
    
    newInfo.imageFilePath = [NSString stringWithFormat:@"%@",imageFilePath];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]]
                          withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [infoPanel showPanelInView:self.view type:infoPanelTypeInfo title:@"Info" subTitle:@"Succeed!" hideAfter:2];

}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *tmp = [NSString stringWithFormat:@"%@", [textField text]];
    newInfo.title = [tmp stringByReplacingCharactersInRange:range withString:string];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    newInfo.title = [NSString stringWithFormat:@"%@", [textField text]];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark - education & course delegate
//選擇了哪個科目: 0 表示全部
/*
- (void)pickerCourseView:(customPickCourseViewController *)view didPickCourse:(NSInteger)courseIndex
{
    newInfo.subjectInd = courseIndex;
    newInfo.subject = [[GlobalFunctions shareInstance] getCourseString:courseIndex];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:askTableViewOptionCourse]]
                          withRowAnimation:UITableViewRowAnimationNone];
}
//選擇了哪個教育類別: 0 表示全部 
- (void)pickerCourseView:(customPickEducationViewController *)view didPickEducation:(NSInteger)educationIndex
{
    newInfo.degreeInd = educationIndex;
    newInfo.degree = [[GlobalFunctions shareInstance] getEducationString:educationIndex];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:askTableViewOptionEducation]]
                          withRowAnimation:UITableViewRowAnimationNone];
}
 */
#pragma mark - topicSelectAction
- (void)didSelectWithTopic:(NSInteger)topicInd
{
    newInfo.topic = [NSNumber numberWithInteger:topicInd];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:askTableViewOptionTopic]]
                          withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - postDelegate
- (void)MyPostDelegate:(MyPostDelegate*)poster didFinishPost:(NSArray*)result
{
    NSLog(@"finish post! %@",result);
    resultList = [[NSArray alloc] initWithArray:result];
    [self.tableView reloadData];
    [self closeAlertAnimation];
    [self dismissViewControllerAnimated:YES completion:nil];
    [delegate askTableView:self didFinishUploadData:YES];
}
- (void)MyPostDelegate:(MyPostDelegate*)poster didFailWithError:(NSError *)error
{
    NSLog(@"faild to post with error :%@",error);
    resultList = [[NSArray alloc] init];
    [self closeAlertAnimation];
    [self showAlertWithMessage:serviceNotAbailable];
}
- (void)MyPostDelegate:(MyPostDelegate *)poster didFailParseXmlWithError:(NSError *)error
{
    NSLog(@"faild to parse xml with error :%@",error);
    resultList = [[NSArray alloc] init];
    [self closeAlertAnimation];
    [self showAlertWithMessage:serviceNotAbailable];
}

#pragma mark - user define function

- (void)createBarItem
{
    UIBarButtonItem *confirmItem = [[[UIBarButtonItem alloc] initWithTitle:NSLocalizedStringFromTable(@"Done", @"InfoPlist", nil) style:UIBarButtonItemStyleBordered target:self action:@selector(confirmButtonPress:)] autorelease];
    self.navigationItem.leftBarButtonItem = confirmItem;
    UIBarButtonItem *closeItem = [[[UIBarButtonItem alloc] initWithTitle:NSLocalizedStringFromTable(@"Cancel", @"InfoPlist", nil) style:UIBarButtonItemStyleBordered target:self action:@selector(closeItemPress:)] autorelease];
    self.navigationItem.rightBarButtonItem = closeItem;
}

- (void)closeItemPress:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)confirmButtonPress:(id)sender
{
    [self startUploadQuestionWithalertInd:YES];
}

- (void)askPicutreSource
{
    UIActionSheet *actionsheet = [[[UIActionSheet alloc] 
                                   initWithTitle:NSLocalizedStringFromTable(@"CameraSource", @"InfoPlist", nil)
                                   delegate:self                  
                                   cancelButtonTitle:NSLocalizedStringFromTable(@"Cancel", @"InfoPlist", nil)
                                   destructiveButtonTitle:nil
                                   otherButtonTitles:NSLocalizedStringFromTable(@"TakePicture", @"InfoPlist", nil),NSLocalizedStringFromTable(@"PhotoAlbum", @"InfoPlist", nil), nil] autorelease];
    [actionsheet showInView:self.view];
}
- (void)takePictureWithButtonIndex:(NSInteger)buttonIndex
{
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.navigationItem.title = @"";
	picker.delegate = self;
    picker.mediaTypes = [NSArray arrayWithObjects:@"public.image",nil];
	if(buttonIndex == askChoosePhotoSourceTypeAlbum)
    {
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:^
         {
             
         }];
    }
    else if (buttonIndex == askChoosePhotoSourceTypeCamera)
    {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] == NO)
        {
            [infoPanel showPanelInView:self.view type:infoPanelTypeError title:@"Info" subTitle:NSLocalizedStringFromTable(@"CameraNotSupport", @"InfoPlist", nil) hideAfter:2];
        }
        else
        {
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:picker animated:YES completion:^
             {
                 
             }];
        }	
	}
}
- (void)startUploadQuestionWithalertInd:(BOOL)ind
{
    //http://kaxa.net/test/phone_upload.php?acc=sinss&pass=sinss&act=q&q_title=今天星期一&content=&u_course=1&u_education=2&image=xxx
    //http://kaxa.net/test/phone_upload.php?acc=sinss&pass=sinss&act=a&aid=34&content=這個好，唷。&image=xxxxxx
    //發問傳入參數 acc(帳號),pass(密碼),act='q'(發問動作指示),q_title(標題),content(內容),u_course(學科),u_education(程度),image(圖片)
    //回答傳入參數 acc(帳號),pass(密碼),act='a'(回答動作指示),aid(問題編號),content(內容),image(圖片)
    if (![self checkKaxaNetReachable])
    {
        [self showAlertWithMessage:kaxaNetNotReachableMessage];
        return;
    }
    if (![self checkAccountAvailable])
    {
        [infoPanel showPanelInView:self.view type:infoPanelTypeError title:@"Info" subTitle:NSLocalizedStringFromTable(@"NotCheckAccount", @"InfoPlist", nil) hideAfter:3];
        return;
    }
    if (ind)
        [self showAlertAnimation];
    
    if (questionType == askQuestionActionCreate)
    {
        NSURL *url1 = [NSURL URLWithString:askQuestionUrl2];
        //送出發問問題
        poster = [[MyPostDelegate alloc] initWithType:MyPostDelegateTypeAskQuestion];
        [poster setDelegate:self];
        [poster startUploadFileWithCreateQuestion:url1 withNewInfo:newInfo andAccount:accountInfo];
    }
    else if (questionType == askQuestionActionReply)
    {
        NSURL *url2 = [NSURL URLWithString:replyQuestionUrl2];
        //送出回答問題
        poster = [[MyPostDelegate alloc] initWithType:MyPostDelegateTypeReplyQuestion];
        [poster setDelegate:self];
        [poster startUploadFileWithReplyQuestion:url2 withAnswerInfo:newInfo AndAccount:accountInfo];
    }
    
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
    NSLog(@"MyArea:KaxaNetNotReachable");
    [[GlobalFunctions shareInstance] saveAppInfoWithKey:kaxaNetReachableKey andValue:kaxaNetNotReachableValue];
}
- (void)kaxaNetReachable:(NSNotification*)notify
{
    NSLog(@"MyArea:KaxaNetReachable");
    [[GlobalFunctions shareInstance] saveAppInfoWithKey:kaxaNetReachableKey andValue:kaxaNetReachableValue];
}

- (void)showAlertWithMessage:(NSString*)message
{
    UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:@"Information" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
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
