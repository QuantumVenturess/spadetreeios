//
//  MenuViewController.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/11/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "BrowseViewController.h"
#import "MenuViewController.h"
#import "MFSideMenu.h"
#import "SpadeTreeNavigationController.h"
#import "SpadeTreeTabBarController.h"
#import "SpadeTreeTableViewController.h"
#import "UIColor+Extensions.h"
#import "UIImage+Resize.h"
#import "User.h"
#import "UserDetailViewController.h"

@implementation MenuViewController

@synthesize messagesButton;
@synthesize messagesCount;
@synthesize notificationsButton;
@synthesize notificationsCount;
@synthesize profileImageView;
@synthesize requestsButton;
@synthesize requestsCount;

#pragma mark - Initializer

- (id) init
{
  self = [super init];
  if (self) {
    appDelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
    [[NSNotificationCenter defaultCenter] addObserver: self
      selector: @selector(enableAllButtons)
        name: AppTokenReceivedNotification object: nil];
  }
  return self;
}

- (void) loadView
{
  [super loadView];
  // View
  CGRect screen = [[UIScreen mainScreen] bounds];
  self.view = [[UIView alloc] init];
  self.view.backgroundColor = [UIColor blackColor];
  CGRect frame = screen;
  frame.size.height = screen.size.height - 20; 
  frame.size.width  = screen.size.width * 0.7;
  self.view.frame = frame;
  // Background image
  UIImageView *backgroundImage = [[UIImageView alloc] init];
  backgroundImage.frame = self.view.frame;
  backgroundImage.image = [UIImage imageNamed: @"join_background.png"];
  [self.view addSubview: backgroundImage];
  [self.view sendSubviewToBack: backgroundImage];
  // Background tint
  UIView *backgroundTint = [[UIView alloc] init];
  backgroundTint.alpha = 0.6;
  backgroundTint.backgroundColor = [UIColor blackColor];
  backgroundTint.frame = self.view.frame;
  [self.view addSubview: backgroundTint];

  // Alert view
  alertView = [[UIAlertView alloc] init];
  alertView.delegate = self;
  alertView.title = @"Sign out for sure?";
  [alertView addButtonWithTitle: @"Yes"];
  [alertView addButtonWithTitle: @"No"];

  float viewHeight     = self.view.frame.size.height;
  float viewWidth      = self.view.frame.size.width;
  float buttonHeight   = 60;
  UIColor *blackColor  = [UIColor colorWithRed: 0 green: 0 blue: 0 alpha: 0.5];
  UIColor *borderColor = [UIColor colorWithRed: 0 green: 0 blue: 0 alpha: 0];
  UIFont *font         = [UIFont fontWithName: @"HelveticaNeue" size: 15];
  UIFont *fontBold     = [UIFont fontWithName: @"HelveticaNeue-Bold" size: 18];
  CALayer *borderTop;
  CGRect countFrame = CGRectMake((viewWidth - (40 + 15)), 15, 40, 30);

  // Profile button
  profileButton = [[UIButton alloc] init];
  profileButton.backgroundColor = blackColor;
  profileButton.frame = CGRectMake(0, (viewHeight - (buttonHeight * 7)), 
    viewWidth, buttonHeight);
  [profileButton addTarget: self action: @selector(showProfile)
    forControlEvents: UIControlEventTouchUpInside];
  [self.view addSubview: profileButton];
  // image
  self.profileImageView = [[UIImageView alloc] init];
  self.profileImageView.clipsToBounds = YES;
  self.profileImageView.contentMode = UIViewContentModeTopLeft;
  self.profileImageView.frame = CGRectMake(15, 15, 30, 30);
  self.profileImageView.image = [UIImage imageNamed: @"placeholder.png"];
  [profileButton addSubview: self.profileImageView];
  // label
  UILabel *profileLabel = [[UILabel alloc] init];
  profileLabel.backgroundColor = [UIColor clearColor];
  profileLabel.font = font;
  profileLabel.frame = CGRectMake((15 + 30 + 15), 15, 
    (viewWidth - (15 + 30 + 15 + 15)), 30);
  profileLabel.text = @"Profile";
  profileLabel.textColor = [UIColor whiteColor];
  [profileButton addSubview: profileLabel];

  // Notifications button
  self.notificationsButton = [[UIButton alloc] init];
  self.notificationsButton.backgroundColor = blackColor;
  self.notificationsButton.frame = CGRectMake(0, 
    (viewHeight - (buttonHeight * 6)), viewWidth, buttonHeight);
  borderTop = [CALayer layer];
  borderTop.backgroundColor = borderColor.CGColor;
  borderTop.frame = CGRectMake(0, 0, viewWidth, 1);
  [self.notificationsButton.layer addSublayer: borderTop];
  [self.notificationsButton addTarget: self action: @selector(showNotifications)
    forControlEvents: UIControlEventTouchUpInside];
  [self.view addSubview: self.notificationsButton];
  // image
  UIImageView *notificationsImageView = [[UIImageView alloc] init];
  notificationsImageView.clipsToBounds = YES;
  notificationsImageView.contentMode = UIViewContentModeTopLeft;
  notificationsImageView.frame = CGRectMake(15, 15, 30, 30);
  notificationsImageView.image = [UIImage imageNamed: @"notifications.png"];
  [self.notificationsButton addSubview: notificationsImageView];
  // label
  UILabel *notificationsLabel = [[UILabel alloc] init];
  notificationsLabel.backgroundColor = [UIColor clearColor];
  notificationsLabel.font = font;
  notificationsLabel.frame = CGRectMake((15 + 30 + 15), 15, 
    (viewWidth - (15 + 30 + 15 + 15)), 30);
  notificationsLabel.text = @"Notifications";
  notificationsLabel.textColor = [UIColor whiteColor];
  [self.notificationsButton addSubview: notificationsLabel];
  // Notifications count
  self.notificationsCount = [[UILabel alloc] init];
  self.notificationsCount.backgroundColor = [UIColor clearColor];
  self.notificationsCount.font = fontBold;
  self.notificationsCount.frame = countFrame;
  self.notificationsCount.text = @"";
  self.notificationsCount.textAlignment = NSTextAlignmentRight;
  self.notificationsCount.textColor = [UIColor red];
  [self.notificationsButton addSubview: self.notificationsCount];

  // Requests button
  self.requestsButton = [[UIButton alloc] init];
  self.requestsButton.backgroundColor = blackColor;
  self.requestsButton.frame = CGRectMake(0, 
    (viewHeight - (buttonHeight * 5)), viewWidth, buttonHeight);
  borderTop = [CALayer layer];
  borderTop.backgroundColor = borderColor.CGColor;
  borderTop.frame = CGRectMake(0, 0, viewWidth, 1);
  [self.requestsButton.layer addSublayer: borderTop];
  [self.requestsButton addTarget: self action: @selector(showRequests)
    forControlEvents: UIControlEventTouchUpInside];
  [self.view addSubview: self.requestsButton];
  // image
  UIImageView *requestsImageView = [[UIImageView alloc] init];
  requestsImageView.clipsToBounds = YES;
  requestsImageView.contentMode = UIViewContentModeTopLeft;
  requestsImageView.frame = CGRectMake(15, 15, 30, 30);
  requestsImageView.image = [UIImage image: [UIImage imageNamed: 
    @"requests.png"] size: CGSizeMake(30, 30)];
  [self.requestsButton addSubview: requestsImageView];
  // label
  UILabel *requestsLabel = [[UILabel alloc] init];
  requestsLabel.backgroundColor = [UIColor clearColor];
  requestsLabel.font = font;
  requestsLabel.frame = CGRectMake((15 + 30 + 15), 15, 
    (viewWidth - (15 + 30 + 15 + 15)), 30);
  requestsLabel.text = @"Requests";
  requestsLabel.textColor = [UIColor whiteColor];
  [self.requestsButton addSubview: requestsLabel];
  // Requests count
  self.requestsCount = [[UILabel alloc] init];
  self.requestsCount.backgroundColor = [UIColor clearColor];
  self.requestsCount.font = fontBold;
  self.requestsCount.frame = countFrame;
  self.requestsCount.text = @"";
  self.requestsCount.textAlignment = NSTextAlignmentRight;
  self.requestsCount.textColor = [UIColor red];
  [self.requestsButton addSubview: self.requestsCount];

  // Messages button
  self.messagesButton = [[UIButton alloc] init];
  self.messagesButton.backgroundColor = blackColor;
  self.messagesButton.frame = CGRectMake(0, 
    (viewHeight - (buttonHeight * 4)), viewWidth, buttonHeight);
  borderTop = [CALayer layer];
  borderTop.backgroundColor = borderColor.CGColor;
  borderTop.frame = CGRectMake(0, 0, viewWidth, 1);
  [self.messagesButton.layer addSublayer: borderTop];
  [self.view addSubview: self.messagesButton];
  [self.messagesButton addTarget: self action: @selector(showMessages)
    forControlEvents: UIControlEventTouchUpInside];
  // image
  UIImageView *messagesImageView = [[UIImageView alloc] init];
  messagesImageView.clipsToBounds = YES;
  messagesImageView.contentMode = UIViewContentModeTopLeft;
  messagesImageView.frame = CGRectMake(15, 15, 30, 30);
  messagesImageView.image = [UIImage imageNamed: @"messages.png"];
  [self.messagesButton addSubview: messagesImageView];
  // label
  UILabel *messagesLabel = [[UILabel alloc] init];
  messagesLabel.backgroundColor = [UIColor clearColor];
  messagesLabel.font = font;
  messagesLabel.frame = CGRectMake((15 + 30 + 15), 15, 
    (viewWidth - (15 + 30 + 15 + 15)), 30);
  messagesLabel.text = @"Messages";
  messagesLabel.textColor = [UIColor whiteColor];
  [self.messagesButton addSubview: messagesLabel];
  // Messages count
  self.messagesCount = [[UILabel alloc] init];
  self.messagesCount.backgroundColor = [UIColor clearColor];
  self.messagesCount.font = fontBold;
  self.messagesCount.frame = countFrame;
  self.messagesCount.text = @"";
  self.messagesCount.textAlignment = NSTextAlignmentRight;
  self.messagesCount.textColor = [UIColor red];
  [self.messagesButton addSubview: self.messagesCount];

  // Edit Profile button
  editProfileButton = [[UIButton alloc] init];
  editProfileButton.backgroundColor = blackColor;
  editProfileButton.frame = CGRectMake(0, 
    (viewHeight - (buttonHeight * 3)), viewWidth, buttonHeight);
  borderTop = [CALayer layer];
  borderTop.backgroundColor = borderColor.CGColor;
  borderTop.frame = CGRectMake(0, 0, viewWidth, 1);
  [editProfileButton.layer addSublayer: borderTop];
  [editProfileButton addTarget: self action: @selector(showEditProfile)
    forControlEvents: UIControlEventTouchUpInside];
  [self.view addSubview: editProfileButton];
  // image
  UIImageView *editProfileImageView = [[UIImageView alloc] init];
  editProfileImageView.clipsToBounds = YES;
  editProfileImageView.contentMode = UIViewContentModeTopLeft;
  editProfileImageView.frame = CGRectMake(15, 15, 30, 30);
  editProfileImageView.image = [UIImage imageNamed: @"edit_profile.png"];
  [editProfileButton addSubview: editProfileImageView];
  // label
  UILabel *editProfileLabel = [[UILabel alloc] init];
  editProfileLabel.backgroundColor = [UIColor clearColor];
  editProfileLabel.font = font;
  editProfileLabel.frame = CGRectMake((15 + 30 + 15), 15, 
    (viewWidth - (15 + 30 + 15 + 15)), 30);
  editProfileLabel.text = @"Edit profile";
  editProfileLabel.textColor = [UIColor whiteColor];
  [editProfileButton addSubview: editProfileLabel];

  // About button
  aboutButton = [[UIButton alloc] init];
  aboutButton.backgroundColor = blackColor;
  aboutButton.frame = CGRectMake(0, 
    (viewHeight - (buttonHeight * 2)), viewWidth, buttonHeight);
  borderTop = [CALayer layer];
  borderTop.backgroundColor = borderColor.CGColor;
  borderTop.frame = CGRectMake(0, 0, viewWidth, 1);
  [aboutButton.layer addSublayer: borderTop];
  [aboutButton addTarget: self action: @selector(showAbout)
    forControlEvents: UIControlEventTouchUpInside];
  [self.view addSubview: aboutButton];
  // image
  UIImageView *aboutImageView = [[UIImageView alloc] init];
  aboutImageView.clipsToBounds = YES;
  aboutImageView.contentMode = UIViewContentModeTopLeft;
  aboutImageView.frame = CGRectMake(15, 15, 30, 30);
  aboutImageView.image = [UIImage imageNamed: @"about.png"];
  [aboutButton addSubview: aboutImageView];
  // label
  UILabel *aboutLabel = [[UILabel alloc] init];
  aboutLabel.backgroundColor = [UIColor clearColor];
  aboutLabel.font = font;
  aboutLabel.frame = CGRectMake((15 + 30 + 15), 15, 
    (viewWidth - (15 + 30 + 15 + 15)), 30);
  aboutLabel.text = @"About";
  aboutLabel.textColor = [UIColor whiteColor];
  [aboutButton addSubview: aboutLabel];

  // Sign Out button
  signOutButton = [[UIButton alloc] init];
  signOutButton.backgroundColor = blackColor;
  signOutButton.frame = CGRectMake(0, 
    (viewHeight - (buttonHeight * 1)), viewWidth, buttonHeight);
  borderTop = [CALayer layer];
  borderTop.backgroundColor = borderColor.CGColor;
  borderTop.frame = CGRectMake(0, 0, viewWidth, 1);
  [signOutButton.layer addSublayer: borderTop];
  [signOutButton addTarget: self action: @selector(signOut)
    forControlEvents: UIControlEventTouchUpInside];
  [self.view addSubview: signOutButton];
  // image
  UIImageView *signOutImageView = [[UIImageView alloc] init];
  signOutImageView.clipsToBounds = YES;
  signOutImageView.contentMode = UIViewContentModeTopLeft;
  signOutImageView.frame = CGRectMake(15, 15, 30, 30);
  signOutImageView.image = [UIImage imageNamed: @"sign_out.png"];
  [signOutButton addSubview: signOutImageView];
  // label
  UILabel *signOutLabel = [[UILabel alloc] init];
  signOutLabel.backgroundColor = [UIColor clearColor];
  signOutLabel.font = font;
  signOutLabel.frame = CGRectMake((15 + 30 + 15), 15, 
    (viewWidth - (15 + 30 + 15 + 15)), 30);
  signOutLabel.text = @"Sign Out";
  signOutLabel.textColor = [UIColor whiteColor];
  [signOutButton addSubview: signOutLabel];

  // Disable button clicks until user is signed in
  profileButton.userInteractionEnabled = NO;
  self.notificationsButton.userInteractionEnabled = NO;
  self.requestsButton.userInteractionEnabled = NO;
  self.messagesButton.userInteractionEnabled = NO;
  editProfileButton.userInteractionEnabled = NO;
  aboutButton.userInteractionEnabled = NO;

  buttons = @[
    profileButton,
    self.notificationsButton,
    self.requestsButton,
    self.messagesButton,
    editProfileButton,
    aboutButton
  ];
}

#pragma mark - Protocol UIAlertView

- (void) alertView: (UIAlertView *) alert 
clickedButtonAtIndex: (NSInteger) buttonIndex
{
  if (buttonIndex == 0) {
    [[NSNotificationCenter defaultCenter] postNotificationName: 
      CurrentUserSignOut object: nil];
  }
  else if (buttonIndex == 1) {
    [alertView dismissWithClickedButtonIndex: 1 animated: YES];
  }
}

#pragma mark - Methods

- (void) buttonSelected: (UIButton *) button
{
  [self unselectAllButtons];
  button.backgroundColor = [UIColor colorWithRed: 115/255.0 green: 202/255.0 
    blue: 36/255.0 alpha: 0.6];
}

- (void) enableAllButtons
{
  profileButton.userInteractionEnabled = YES;
  self.notificationsButton.userInteractionEnabled = YES;
  self.requestsButton.userInteractionEnabled = YES;
  self.messagesButton.userInteractionEnabled = YES;
  editProfileButton.userInteractionEnabled = YES;
  aboutButton.userInteractionEnabled = YES;
}

- (void) showAbout
{
  SpadeTreeNavigationController *nav = (SpadeTreeNavigationController *)
    appDelegate.tabBarController.aboutNav;
  [self switchToViewController: nav fromButton: aboutButton];
}

- (void) showEditProfile
{
  SpadeTreeNavigationController *nav = (SpadeTreeNavigationController *)
    appDelegate.tabBarController.editProfileNav;
  [self switchToViewController: nav fromButton: editProfileButton];
}

- (void) showMessages
{
  SpadeTreeNavigationController *nav = (SpadeTreeNavigationController *)
    appDelegate.tabBarController.messagesNav;
  [self switchToViewController: nav fromButton: messagesButton];
}

- (void) showNotifications
{
  SpadeTreeNavigationController *nav = (SpadeTreeNavigationController *)
    appDelegate.tabBarController.notificationsNav;
  [self switchToViewController: nav fromButton: self.notificationsButton];
}

- (void) showProfile
{
  SpadeTreeNavigationController *nav = (SpadeTreeNavigationController *)
    appDelegate.tabBarController.userDetailNav;
  [self switchToViewController: nav fromButton: profileButton];
}

- (void) showRequests
{
  SpadeTreeNavigationController *nav = (SpadeTreeNavigationController *)
    appDelegate.tabBarController.requestsNav;
  [self switchToViewController: nav fromButton: requestsButton];
}

- (void) signOut
{
  [alertView show];
}

- (void) switchToViewController: (SpadeTreeNavigationController *) nav
fromButton: (UIButton *) button;
{
  NSArray *array = [NSArray arrayWithObjects: 
    appDelegate.tabBarController.selectedViewController, 
      (UIViewController *) nav, nil];
  appDelegate.tabBarController.viewControllers = array;
  appDelegate.tabBarController.selectedViewController = 
    (UIViewController *) nav;
  // Pop to root view controller
  // [nav popToRootViewControllerAnimated: NO];
  // If view controller is the browse view controller
  if ([[nav topViewController] isKindOfClass: 
    [BrowseViewController class]]) {
    // Scroll all the way to the top
    SpadeTreeTableViewController *tableViewController = 
      (SpadeTreeTableViewController *) [nav topViewController];
    [tableViewController.table setContentOffset: CGPointMake(0, 0) 
      animated: NO];
  }
  // [appDelegate.panel setMenuState: MFSideMenuStateClosed];
  [appDelegate.panel toggleLeftSideMenuCompletion: ^{
    [self buttonSelected: button];
  }];
}

- (void) unselectAllButtons
{
  for (UIButton *b in buttons) {
    b.backgroundColor = [UIColor colorWithRed: 0 green: 0 blue: 0 alpha: 0.6];
  }
}

@end
