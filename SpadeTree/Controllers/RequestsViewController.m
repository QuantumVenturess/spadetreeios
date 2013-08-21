//
//  RequestsViewController.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/16/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "AppDelegate.h"
#import "Choice.h"
#import "ChoiceDetailViewController.h"
#import "ChoiceListCell.h"
#import "ChoiceListStore.h"
#import "MenuViewController.h"
#import "RequestsViewController.h"
#import "User.h"

@implementation RequestsViewController

#pragma mark - Initializer

- (id) init
{
  self = [super init];
  if (self) {
    self.title = self.trackedViewName = @"Requests";
  }
  return self;
}

#pragma mark - Override SpadeTreeTableViewController

- (void) reloadTable
{
  [super reloadTable];
  [[ChoiceListStore sharedStore] setViewController: self];
  for (int i = self.currentPage; i != 0; i--) {
    [[ChoiceListStore sharedStore] fetchPage: i completion:
      ^(NSError *error) {
        if (!error) {
          [self.table reloadData];
        }
        if ([User currentUser].tutee) {
          // Subscribe tutee to every choice / request
          for (Choice *choice in [ChoiceListStore sharedStore].choices) {
            [choice subscribeToChannel];
          }
        }
        self.fetching = NO;
      }
    ];
  }
  [self.table reloadData];
}

#pragma mark - Override UIViewController

- (void) loadView
{
  [super loadView];
  // Navigation item
  // Add menu button to navigation item
  self.navigationItem.leftBarButtonItem = [[MenuBarButtonItem alloc] init];
}

- (void) viewWillAppear: (BOOL) animated
{
  [super viewWillAppear: animated];
  [self reloadTable];
  if ([User currentUser].tutee) {
    // Set count to nothing
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    MenuViewController *menu = appDelegate.menu;
    menu.requestsCount.text  = @"";
  }
}

#pragma mark - Protocol UIScrollViewDelegate

- (void) scrollViewDidScroll: (UIScrollView *) scrollView
{
  float scrollViewHeight   = scrollView.frame.size.height;
  float contentHeight      = scrollView.contentSize.height;
  float totalContentOffset = contentHeight - scrollViewHeight;
  float limit = totalContentOffset - (scrollViewHeight / 1.0);
  if (!self.fetching && scrollView.contentOffset.y > limit 
    && self.maxPages > self.currentPage) {

    self.currentPage += 1;
    self.fetching = YES;
    [self reloadTable];
  }
}

#pragma mark - Protocol UITableViewDataSource

- (UITableViewCell *) tableView: (UITableView *) tableView
cellForRowAtIndexPath: (NSIndexPath *) indexPath
{
  static NSString *identifier = @"ChoiceListCell";
  ChoiceListCell *cell = [tableView dequeueReusableCellWithIdentifier:
    identifier];
  if (!cell) {
    cell = [[ChoiceListCell alloc] init];
  }
  [cell loadChoiceData: [[ChoiceListStore sharedStore].choices objectAtIndex: 
    indexPath.row]];
  return cell;
}

- (NSInteger) numberOfSectionsInTableView: (UITableView *) tableView
{
  return 1;
}

- (NSInteger) tableView: (UITableView *) tableView
numberOfRowsInSection: (NSInteger) section
{
  return [ChoiceListStore sharedStore].choices.count;
}

#pragma mark - Protocol UITableViewDelegate

- (void) tableView: (UITableView *) tableView
didSelectRowAtIndexPath: (NSIndexPath *) indexPath
{
  Choice *choice = 
    [[ChoiceListStore sharedStore].choices objectAtIndex: indexPath.row];
  [self.navigationController pushViewController:
    [[ChoiceDetailViewController alloc] initWithChoice: choice] animated: YES];
}

- (CGFloat) tableView: (UITableView *) tableView
heightForRowAtIndexPath: (NSIndexPath *) indexPath
{
  Choice *choice = 
    [[ChoiceListStore sharedStore].choices objectAtIndex: indexPath.row];
  CGRect screen = [[UIScreen mainScreen] bounds];
  CGSize contentSize = [choice.content sizeWithFont: 
    [UIFont fontWithName: @"HelveticaNeue" size: 13]
      constrainedToSize: CGSizeMake((screen.size.width - 20), 5000)];
  return 20 + 50 + 10 + 20 + 10 + contentSize.height + 20;
}

@end
