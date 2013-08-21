//
//  SpadeTreeTableViewController.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 6/27/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "AppDelegate.h"
#import "SpadeTreeTabBarController.h"
#import "SpadeTreeTableViewController.h"

@implementation SpadeTreeTableViewController

@synthesize currentPage;
@synthesize fetching;
@synthesize maxPages;
@synthesize table;

#pragma mark - Initializer

- (id) init
{
  self = [super init];
  if (self) {
    self.currentPage = self.maxPages = 1;
    self.fetching    = NO;
    [[NSNotificationCenter defaultCenter] addObserver: self
      selector: @selector(signOut) name: CurrentUserSignOut object: nil];
  }
  return self;
}

#pragma mark - Override UIViewController

- (void) loadView
{
  [super loadView];
  CGRect screen = [[UIScreen mainScreen] bounds];
  // Allow table view to scroll below tab bar
  AppDelegate *appDelegate = (AppDelegate *) 
    [UIApplication sharedApplication].delegate;
  UIView *tabBarView = (UIView *) 
    [appDelegate.tabBarController.view.subviews objectAtIndex: 0];
  CGRect newFrame = screen;
  newFrame.size.height = screen.size.height - 20;
  tabBarView.frame = newFrame;
  // Main view, table
  self.table = [[UITableView alloc] init];
  self.table.backgroundColor = [UIColor whiteColor];
  self.table.dataSource = self;
  self.table.delegate   = self;
  self.table.frame      = screen;
  self.table.separatorColor = [UIColor clearColor];
  self.table.showsVerticalScrollIndicator = NO;
  self.view = self.table;
}

- (void) viewWillAppear: (BOOL) animated
{
  [super viewWillAppear: animated];
  [self.table deselectRowAtIndexPath: [self.table indexPathForSelectedRow]
    animated: NO];
}

#pragma mark - Methods

- (void) reloadTable
{
  // Subclass
}

- (void) signOut
{
  self.currentPage = self.maxPages = 1;
  self.fetching    = NO;
}

@end
