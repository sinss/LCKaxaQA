//
//  aboutTeamViewController.m
//  KaxaQ&A
//
//  Created by 張星星 on 12/4/23.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import "aboutTeamViewController.h"

@interface aboutTeamViewController ()

@end

@implementation aboutTeamViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        self.title = NSLocalizedStringFromTable(@"AboutKaxa", @"InfoPlist", nil);
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
    [teamTableView setDelegate:self];
    [teamTableView setDataSource:self];
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
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger sec = [indexPath section];
    
     if (sec == aboutTeamTableViewSectionCompany)
     return defaultTableViewCellHeight;
     else
     
    return customContentTextViewCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *companyCellIdentifier = @"companyCellIdentifier";
    static NSString *introCellIdentifier = @"introCellIdentifier";
    static NSString *purposeCellIdentifier = @"purposeCellIdentifier";
    
    NSUInteger sec = [indexPath section];
    
     if (sec == aboutTeamTableViewSectionCompany)
     {
     customSingleLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:companyCellIdentifier];
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
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
     cell.accessoryType = UITableViewCellAccessoryNone;
     [cell.contentLabel setFont:[UIFont fontWithName:@"Helvetica" size:20]];
     }
     [cell.contentLabel setText:@"KaxaNet"];
     return cell;
     }
     
    else if (sec == aboutTeamTableViewSectionIntro)
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
        [cell.contentTextView setText:[[[NSBundle mainBundle] infoDictionary] objectForKey:aboutTeamSupportKey]];
        return cell;
    }
    else if (sec == aboutTeamTableViewSectionPurpose)
    {
        customContentTextCell *cell = [tableView dequeueReusableCellWithIdentifier:purposeCellIdentifier];
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
        }
        [cell.contentTextView setText:[[[NSBundle mainBundle] infoDictionary] objectForKey:aboutTeamKey]];
        return cell;
    }
    return nil;
}
@end
