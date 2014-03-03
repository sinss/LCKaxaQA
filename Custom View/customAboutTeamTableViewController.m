//
//  customAboutTeamTableViewController.m
//  KaxaQ&A
//
//  Created by 張星星 on 12/3/23.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import "customAboutTeamTableViewController.h"

@interface customAboutTeamTableViewController ()

@end

@implementation customAboutTeamTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) 
    {
        self.title = NSLocalizedString(@"關於Kaxa", @"關於Kaxa");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

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
        [cell.contentTextView setText:[[[NSBundle mainBundle] infoDictionary] objectForKey:aboutSystemKey]];
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
        [cell.contentTextView setText:[[[NSBundle mainBundle] infoDictionary] objectForKey:aboutSystemKey]];
        return cell;
    }
    return nil;
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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
