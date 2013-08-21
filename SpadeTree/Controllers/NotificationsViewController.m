//
//  NotificationsViewController.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/12/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "AppDelegate.h"
#import "ChoiceDetailViewController.h"
#import "InterestDetailViewController.h"
#import "MenuViewController.h"
#import "Notification.h"
#import "NotificationCell.h"
#import "NotificationsConnection.h"
#import "NotificationStore.h"
#import "NotificationsViewController.h"
#import "UIColor+Extensions.h"

@implementation NotificationsViewController

#pragma mark - Initializer

- (id) init
{
  self = [super init];
  if (self) {
    self.title = self.trackedViewName = @"Notifications";
  }
  return self;
}

#pragma mark - Override UIViewController

- (void) loadView
{
  [super loadView];
  CGRect screen = [[UIScreen mainScreen] bounds];
  // Navigation item
  // Add menu button to navigation item
  self.navigationItem.leftBarButtonItem = [[MenuBarButtonItem alloc] init];
  UIView *footerView = [[UIView alloc] init];
  footerView.frame = CGRectMake(0, 0, screen.size.width, 10);
  self.table.tableFooterView = footerView;
  UIView *headerView = [[UIView alloc] init];
  headerView.frame = CGRectMake(0, 0, screen.size.width, 10);
  self.table.tableHeaderView = headerView;
}

- (void) viewWillAppear: (BOOL) animated
{
  [super viewWillAppear: animated];
  NotificationsConnection *connection = [[NotificationsConnection alloc] init];
  connection.completionBlock = ^(NSError *error) {
    [self.table reloadData];
  };
  [connection start];
  [self.table reloadData];
  // Set count to nothing
  AppDelegate *appDelegate     = [UIApplication sharedApplication].delegate;
  MenuViewController *menu     = appDelegate.menu;
  menu.notificationsCount.text = @"";
}

#pragma mark - Protocol UITableViewDataSource

- (UITableViewCell *) tableView: (UITableView *) tableView
cellForRowAtIndexPath: (NSIndexPath *) indexPath
{
  NSString *indentifier = @"NotificationCell";
  NotificationCell *cell = [tableView dequeueReusableCellWithIdentifier: 
    indentifier];
  if (!cell) {
    cell = [[NotificationCell alloc] initWithStyle: 
      UITableViewCellStyleDefault reuseIdentifier: indentifier];
  }
  cell.navigationController = self.navigationController;
  Notification *notification = 
    [[NotificationStore sharedStore].notifications objectAtIndex: 
      indexPath.row];
  [cell loadNotificationData: notification];
  return cell;
}

- (NSInteger) numberOfSectionsInTableView: (UITableView *) tableView
{
  return 1;
}

- (NSInteger) tableView: (UITableView *) tableView
numberOfRowsInSection: (NSInteger) section
{
  return [NotificationStore sharedStore].notifications.count;
}

#pragma mark - Protocol UITableViewDelegate

- (void) tableView: (UITableView *) tableView
didSelectRowAtIndexPath: (NSIndexPath *) indexPath
{
  UIViewController *vc;
  Notification *notification = 
    [[NotificationStore sharedStore].notifications objectAtIndex: 
      indexPath.row];
  if (notification.choice) {
    vc = (UIViewController *)
      [[ChoiceDetailViewController alloc] initWithChoice: notification.choice];
  }
  else if (notification.interest) {
    vc = (UIViewController *)
      [[InterestDetailViewController alloc] initWithInterest: 
        notification.interest];
  }
  if (vc) {
    [self.navigationController pushViewController: vc animated: YES];
  }
}

- (CGFloat) tableView: (UITableView *) tableView
heightForHeaderInSection: (NSInteger) section
{
  return 0;
}

- (CGFloat) tableView: (UITableView *) tableView
heightForRowAtIndexPath: (NSIndexPath *) indexPath
{
  return 40;
}

- (UIView *) tableView: (UITableView *) tableView
viewForHeaderInSection: (NSInteger) section
{
  NSString *string;
  UIView *header = [[UIView alloc] init];
  header.backgroundColor = [UIColor colorWithRed: 255 green: 255 blue: 255
    alpha: 0.7];
  header.frame = CGRectMake(0, 0, tableView.frame.size.width, 40);
  CALayer *layer = [CALayer layer];
  layer.backgroundColor = [UIColor blackColor].CGColor;
  layer.frame = CGRectMake(0, 39, (tableView.frame.size.width - 0), 1);
  [header.layer addSublayer: layer];
  UILabel *label = [[UILabel alloc] init];
  label.backgroundColor = [UIColor clearColor];
  label.frame = CGRectMake(10, 10, (tableView.frame.size.width - 20), 20);
  label.font = [UIFont fontWithName: @"HelveticaNeue" size: 15];
  label.text = [string capitalizedString];
  label.textColor = [UIColor gray: 50];
  [header addSubview: label];
  return header;
}

@end
