//
//  MessagesViewController.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/30/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "Message.h"
#import "MessageDetailViewController.h"
#import "MessageListCell.h"
#import "MessageListConnection.h"
#import "MessageListStore.h"
#import "MessagesViewController.h"

@implementation MessagesViewController

#pragma mark - Initializer

- (id) init
{
  self = [super init];
  if (self) {
    self.title = @"Messages";
    self.trackedViewName = @"Messages";
  }
  return self;
}

#pragma mark - Override UIViewController

- (void) loadView
{
  [super loadView];
  self.navigationItem.leftBarButtonItem = [[MenuBarButtonItem alloc] init];
}

- (void) viewWillAppear: (BOOL) animated
{
  [super viewWillAppear: animated];
  MessageListConnection *connection = [[MessageListConnection alloc] init];
  connection.completionBlock = ^(NSError *error) {
    [self.table reloadData];
  };
  [connection start];
  [self.table reloadData];
}

#pragma mark - Protocol UITableViewDataSource

- (UITableViewCell *) tableView: (UITableView *) tableView
cellForRowAtIndexPath: (NSIndexPath *) indexPath
{
  static NSString *identifier = @"MessageListCell";
  MessageListCell *cell = [tableView dequeueReusableCellWithIdentifier:
    identifier];
  if (!cell) {
    cell = [[MessageListCell alloc] initWithStyle: UITableViewCellStyleDefault
      reuseIdentifier: identifier];
  }
  Message *message = [[MessageListStore sharedStore].messages objectAtIndex:
    indexPath.row];
  [cell loadMessageData: message];
  return cell;
}

- (NSInteger) numberOfSectionsInTableView: (UITableView *) tableView
{
  return 1;
}

- (NSInteger) tableView: (UITableView *) tableView
numberOfRowsInSection: (NSInteger) section
{
  return [MessageListStore sharedStore].messages.count;
}

#pragma mark - Protocol UITableViewDelegate

- (void) tableView: (UITableView *) tableView
didSelectRowAtIndexPath: (NSIndexPath *) indexPath
{
  Message *message = [[MessageListStore sharedStore].messages objectAtIndex:
    indexPath.row];
  message.viewed = YES;
  [self.navigationController pushViewController: 
    [[MessageDetailViewController alloc] initWithMessage: 
      message] animated: YES];
}

- (CGFloat) tableView: (UITableView *) tableView
heightForRowAtIndexPath: (NSIndexPath *) indexPath
{
  return 60;
}

@end
