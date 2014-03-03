//
//  topicSelectViewController.m
//  KaxaQ&A
//
//  Created by sinss on 12/12/28.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import "topicSelectViewController.h"
#import "GlobalFunctions.h"

@interface topicSelectViewController ()

@end

@implementation topicSelectViewController
@synthesize topicIndex, delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView *imageview = [[UIImageView alloc] initWithImage:plainTableviewBg];
    [aTableView setBackgroundView:imageview];
    [imageview release];
    [aTableView setDelegate:self];
    [aTableView setDataSource:self];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    delegate = nil;
    [aTableView release], aTableView = nil;
    [super dealloc];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"topicCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    }
    NSUInteger row = [indexPath row];
    if (row % 2 == 1)
    {
        UIView *cellView = [[UIView alloc] init];
        [cellView setBackgroundColor:oddCellBackgroundColor];
        [cell setBackgroundView:cellView];
        [cellView release];
    }
    
    if (row == topicIndex)
    {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    }
    else
    {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    [cell.textLabel setText:[[GlobalFunctions shareInstance] getTopicNameWithIndex:row]];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self dismissViewControllerAnimated:YES completion:^{
        [delegate didSelectWithTopic:[indexPath row]];
    }];
}

@end
