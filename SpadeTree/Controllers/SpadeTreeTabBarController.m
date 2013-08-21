//
//  SpadeTreeTabBarController.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 6/27/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "AboutViewController.h"
#import "BrowseViewController.h"
#import "EditProfileViewController.h"
#import "MessagesViewController.h"
#import "NotificationsViewController.h"
#import "RequestsViewController.h"
#import "SpadeTreeNavigationController.h"
#import "SpadeTreeTabBarController.h"
#import "SpadeTreeTableViewController.h"
#import "TutorialViewController.h"
#import "User.h"
#import "UserDetailViewController.h"

@implementation SpadeTreeTabBarController

@synthesize aboutNav;
@synthesize browseNav;
@synthesize editProfileNav;
@synthesize messagesNav;
@synthesize notificationsNav;
@synthesize requestsNav;
@synthesize tutorial;
@synthesize userDetailNav;

#pragma mark - Initializer

- (id) init
{
  self = [super init];
  if (self) {
    CGRect screen = [[UIScreen mainScreen] bounds];
    // Hide UITabBar
    CGRect frame = self.tabBar.frame;
    frame.origin.y = screen.size.height;
    self.tabBar.frame = frame;
    // View controllers
    self.browseNav = 
      [[SpadeTreeNavigationController alloc] initWithRootViewController:
        [[BrowseViewController alloc] init]];
    self.userDetailNav =
      [[SpadeTreeNavigationController alloc] initWithRootViewController:
        [[UserDetailViewController alloc] init]];
    self.notificationsNav = 
      [[SpadeTreeNavigationController alloc] initWithRootViewController:
        [[NotificationsViewController alloc] init]];
    self.requestsNav = 
      [[SpadeTreeNavigationController alloc] initWithRootViewController:
        [[RequestsViewController alloc] init]];
    self.messagesNav =
      [[SpadeTreeNavigationController alloc] initWithRootViewController:
        [[MessagesViewController alloc] init]];
    self.editProfileNav = 
      [[SpadeTreeNavigationController alloc] initWithRootViewController:
        [[EditProfileViewController alloc] init]];
    self.aboutNav =
      [[SpadeTreeNavigationController alloc] initWithRootViewController:
        [[AboutViewController alloc] init]];
    self.tutorial = [[TutorialViewController alloc] init];

    NSArray *vcs = @[
      self.browseNav
    //  self.userDetailNav,
    //  self.notificationsNav,
    //  self.requestsNav,
    //  self.messagesNav,
    //  self.editProfileNav
    ];

    self.viewControllers = vcs;
  }
  return self;
}

#pragma mark - Methods

- (void) showTutorial
{
  [self.tutorial.scroll setContentOffset: CGPointMake(0, 0) animated: NO];
  UINavigationController *nav = (UINavigationController *) 
    self.selectedViewController;
  [nav.topViewController presentViewController: self.tutorial
    animated: YES completion: nil];
} 

- (void) signOut
{
  NSArray *array = [NSArray arrayWithObjects:
    self.selectedViewController, self.browseNav, nil];
  self.viewControllers = array;
  self.selectedViewController = (UIViewController *) self.browseNav;
  SpadeTreeTableViewController *tvc;
  // Browse
  [self.browseNav popToRootViewControllerAnimated: NO];
  tvc = (SpadeTreeTableViewController *) self.browseNav.topViewController;
  [tvc.table reloadData];
  // Profile
  [self.userDetailNav popToRootViewControllerAnimated: NO];
  // Notifications
  [self.notificationsNav popToRootViewControllerAnimated: NO];
  // Requests
  [self.requestsNav popToRootViewControllerAnimated: NO];
  // Messages
  [self.messagesNav popToRootViewControllerAnimated: NO];
  // Edit profile
  [self.editProfileNav popToRootViewControllerAnimated: NO];
  // About
  [self.aboutNav popToRootViewControllerAnimated: NO];
}

- (void) switchToViewController: (UIViewController *) vc
{
  self.viewControllers = [NSArray arrayWithObjects: 
    self.selectedViewController, vc, nil];
  self.selectedViewController = vc;
}

@end
