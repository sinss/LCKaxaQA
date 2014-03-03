//
//  customSystemTableViewController.m
//  KaxaQ&A
//
//  Created by 張星星 on 12/3/23.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import "customSystemTableViewController.h"

@interface customSystemTableViewController ()

@end

@implementation customSystemTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) 
    {
        self.title = NSLocalizedString(@"系統介紹", @"系統介紹");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (functionList == nil)
    {
        functionList = [[NSArray alloc] initWithObjects:@"版本",@"系統簡介", nil];
    }
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
        [cell.textLabel setText:@"當前版本"];
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
