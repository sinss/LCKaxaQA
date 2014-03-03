//
//  aboutSystemViewController.m
//  KaxaQ&A
//
//  Created by 張星星 on 12/4/23.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import "aboutSystemViewController.h"
#import "customContentTextCell.h"


@interface aboutSystemViewController ()

@end

@implementation aboutSystemViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = NSLocalizedStringFromTable(@"SystemIntro", @"InfoPlist", nil);
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
    if (functionList == nil)
    {
        functionList = [[NSArray alloc] initWithObjects:@"版本",@"系統簡介", nil];
    }
}

- (void)dealloc
{
    [functionList release], functionList = nil;
    [systemTableView release], systemTableView = nil;
    [super dealloc];
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
#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [functionList count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger sec = [indexPath section];
    if (sec == aboutSystemTableViewSectionVersion)
        return defaultTableViewCellHeight;
    else if (sec == aboutSystemTableViewSectionIntro)
        return customContentTextViewCellHeight;
    else 
        return defaultTableViewCellHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *versionCellIdentifier = @"versionCellIdentifier";
    static NSString *introCellIdentifier = @"introCellIdentifier";
    
    NSUInteger sec = [indexPath section];
    
    if (sec == aboutSystemTableViewSectionVersion)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:versionCellIdentifier];
        if (cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:versionCellIdentifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        [cell.textLabel setText:@"Version"];
        [cell.detailTextLabel setText:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]];
        return cell;
    }
    else if (sec == aboutSystemTableViewSectionIntro)
    {
        customContentTextCell *cell = [tableView dequeueReusableCellWithIdentifier:introCellIdentifier];
        if (cell == nil) 
        {
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"customContentTextCell" owner:self options:nil];
            for (id currentObj in topLevelObjects)
            {
                if ([currentObj isKindOfClass:[customContentTextCell class]])
                {
                    cell = currentObj;
                }
                break;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        [cell.contentTextView setText:[[[NSBundle mainBundle] infoDictionary] objectForKey:aboutSystemKey]];
        return cell;
    }
    return nil;
}
@end
