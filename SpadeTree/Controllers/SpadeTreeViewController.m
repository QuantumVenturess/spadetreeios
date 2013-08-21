//
//  SpadeTreeViewController.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 6/27/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "AppDelegate.h"
#import "BrowseViewController.h"
#import "MenuViewController.h"
#import "MessagesCountConnection.h"
#import "MFSideMenu.h"
#import "NotificationsCountConnection.h"
#import "RequestsCountConnection.h"
#import "SpadeTreeNavigationController.h"
#import "SpadeTreeTabBarController.h"
#import "SpadeTreeViewController.h"

@implementation SpadeTreeViewController

#pragma mark - Override UIViewController

- (void) loadView
{
  // Navigation item
  // back button
  UIImage *backButtonImage = [UIImage imageNamed: @"back.png"];
  UIButton *backButton = [UIButton buttonWithType: UIButtonTypeCustom];
  backButton.frame = CGRectMake(0, 0, backButtonImage.size.width + 16,
    backButtonImage.size.height);
  [backButton addTarget: self action: @selector(goBack)
    forControlEvents: UIControlEventTouchUpInside];
  [backButton setImage: backButtonImage forState: UIControlStateNormal];
  self.navigationItem.leftBarButtonItem =
    [[UIBarButtonItem alloc] initWithCustomView: backButton];
  // browse button
  UIImage *browseImage = [UIImage imageNamed: @"browse.png"];
  UIButton *browseButton = [UIButton buttonWithType: UIButtonTypeCustom];
  browseButton.frame = CGRectMake(0, 0, browseImage.size.width + 16, 
    browseImage.size.height);
  [browseButton addTarget: self action: @selector(showBrowse)
    forControlEvents: UIControlEventTouchUpInside];
  [browseButton setImage: browseImage forState: UIControlStateNormal];
  self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithCustomView: browseButton];
  // title
  if (!self.title) {
    UIImageView *titleImageView = [[UIImageView alloc] init];
    UIImage *titleImage = [UIImage imageNamed: @"title_logo.png"];
    titleImageView.frame = CGRectMake(0, 0, titleImage.size.width, 
      titleImage.size.height);
    titleImageView.image = titleImage;
    self.navigationItem.titleView = titleImageView;
  }
}

- (void) setTitle: (NSString *) string
{
  [super setTitle: string];
  UILabel *label = [[UILabel alloc] init];
  label.backgroundColor = [UIColor clearColor];
  label.font            = [UIFont fontWithName: @"HelveticaNeue" size: 20];
  label.frame           = CGRectMake(0, 0, 0, 44);
  label.shadowColor     = [UIColor clearColor];
  label.shadowOffset    = CGSizeMake(0, 0);
  label.text            = string;
  label.textAlignment   = NSTextAlignmentCenter;
  label.textColor       = [UIColor whiteColor];
  [label sizeToFit];
  self.navigationItem.titleView = label;
}

- (void) viewWillAppear: (BOOL) animated
{
  [super viewWillAppear: animated];
  // Update notifications, requests, and messages count
  if ([[User currentUser].appToken length] > 0) {
    [[[NotificationsCountConnection alloc] init] start];
    [[[RequestsCountConnection alloc] init] start];
    [[[MessagesCountConnection alloc] init] start];
  }
}

#pragma mark - Methods

- (void) goBack
{
  [self.navigationController popViewControllerAnimated: YES];
}

- (void) showBrowse
{
  AppDelegate *appDelegate = (AppDelegate *)
    [UIApplication sharedApplication].delegate;
  SpadeTreeNavigationController *nav = (SpadeTreeNavigationController *)
    appDelegate.tabBarController.browseNav;
  NSArray *array = [NSArray arrayWithObjects: 
    appDelegate.tabBarController.selectedViewController, 
      (UIViewController *) nav, nil];
  appDelegate.tabBarController.viewControllers = array;
  appDelegate.tabBarController.selectedViewController = 
    (UIViewController *) nav;
  // Pop to the bottom root view controller
  [nav popToRootViewControllerAnimated: NO];
  // Scroll to the top
  BrowseViewController *browseViewController = 
    (BrowseViewController *) [nav topViewController];
  [browseViewController.table setContentOffset: CGPointMake(0, 0) animated: NO];
  // Make search field first responder
  [(UITextField *) browseViewController.searchField becomeFirstResponder];
  // Unselect all buttons for menu view controller
  [appDelegate.menu unselectAllButtons];
  [appDelegate.panel setMenuState: MFSideMenuStateClosed completion:^{}];
}

@end
