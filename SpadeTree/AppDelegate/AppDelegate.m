//
//  AppDelegate.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 6/27/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import <NewRelicAgent/NewRelicAgent.h>
#import <Parse/Parse.h>
#import "AppDelegate.h"
#import "Choice.h"
#import "ChoiceDetailViewController.h"
#import "ChoiceInfoConnection.h"
#import "ChoiceListStore.h"
#import "GAI.h"
#import "JoinViewController.h"
#import "MenuViewController.h"
#import "MessagesCountConnection.h"
#import "MFSideMenu.h"
#import "NotificationsCountConnection.h"
#import "PickView.h"
#import "RequestsCountConnection.h"
#import "SpadeTreeNavigationController.h"
#import "SpadeTreeTabBarController.h"
#import "User.h"

#import "TestConnection.h"

NSString *const CurrentUserSignOut = @"CurrentUserSignOut";
NSString *const FBSessionStateChangedNotification = 
  @"com.quantum.Login:FBSessionStateChangedNotification";

@implementation AppDelegate

@synthesize joinViewController;
@synthesize menu;
@synthesize panel;
@synthesize tabBarController;

#pragma mark - Protocol UIApplicationDelegate

- (BOOL) application: (UIApplication *) application 
didFinishLaunchingWithOptions: (NSDictionary *) launchOptions
{
  // Google Analytics
  // Optional: automatically send uncaught exceptions to Google Analytics
  [GAI sharedInstance].trackUncaughtExceptions = YES;
  // Optional: set Google Analytics dispatch interval to e.g. 20 seconds
  [GAI sharedInstance].dispatchInterval = 20;
  // Optional: set debug to YES for extra debugging information
  [GAI sharedInstance].debug = YES;
  // Create tracker instance
  [[GAI sharedInstance] trackerWithTrackingId: @"UA-41570926-2"];

  // New Relic
  [NewRelicAgent startWithApplicationToken: 
    @"AAb78268e644fb7a4f83d32d1132a4bf2775b22737"];
  // Parse setup
  [Parse setApplicationId: @"iRqqfEEivn7v7W8SHTOj4qOzaXuedhJkqCDWYn1m"
    clientKey: @"DlfBQJyxNFyS0qXU9uigFh7B9lETBw8RuYKgYUbW"];

  // Register for push notifications
  [application registerForRemoteNotificationTypes:
    UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge];

  // [[[TestConnection alloc] init] start];
  CGRect screen = [[UIScreen mainScreen] bounds];
  self.window   = [[UIWindow alloc] initWithFrame: screen];
  // Override point for customization after application launch.

  // Notifications
  [[NSNotificationCenter defaultCenter] addObserver: self
    selector: @selector(updateAllCounts) name: AppTokenReceivedNotification
      object: nil];
  [[NSNotificationCenter defaultCenter] addObserver: self
    selector: @selector(signOut) name: CurrentUserSignOut object: nil];

  // View controllers
  self.joinViewController = [[JoinViewController alloc] init];
  self.menu               = [[MenuViewController alloc] init];
  self.tabBarController   = [[SpadeTreeTabBarController alloc] init];
  // Panel
  self.panel = 
    [MFSideMenuContainerViewController containerWithCenterViewController: 
      self.tabBarController leftMenuViewController: self.menu 
        rightMenuViewController: nil];
  [self.panel setMenuWidth: screen.size.width * 0.7];
  [self.panel setShadowEnabled: NO];
  // Pick view (tutee or tutor)
  self.pickView = [[PickView alloc] init];
  self.pickView.hidden = YES;
  [self.tabBarController.view addSubview: self.pickView];

  // Set root view controller for app
  self.window.backgroundColor    = [UIColor whiteColor];
  self.window.rootViewController = self.panel;
  [self.window makeKeyAndVisible];

  // Facebook
  if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
    // If current session has a valid Facebook token
    [self openSession];
  }
  else {
    // If current session does not have a valid Facebook token
    [self showJoin];
  }

  // Extract the notification data
  NSDictionary *notificationPayload = 
    launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey];
  if (notificationPayload) {
    [[NSNotificationCenter defaultCenter] addObserver: self
      selector: @selector(launchCompletionBlock)
        name: AppTokenReceivedNotification object: nil];
    // Set the completion block to open the choice detail
    [self.tabBarController switchToViewController: (UIViewController *) 
      self.tabBarController.requestsNav];
    UINavigationController *nav = self.tabBarController.requestsNav;
    completionBlock = ^(void) {
      // Open choice
      if ([notificationPayload objectForKey: @"choice_id"]) {
        int choiceId = [[notificationPayload objectForKey: 
          @"choice_id"] integerValue];
        ChoiceInfoConnection *connection = 
          [[ChoiceInfoConnection alloc] initWithChoiceId: choiceId];
        connection.completionBlock = ^(NSError *error) {
          if (!error) {
            Choice *choice = [[ChoiceListStore sharedStore] choiceForId: 
              choiceId];
            if (choice) {
              ChoiceDetailViewController *choiceDetail = 
                [[ChoiceDetailViewController alloc] initWithChoice: choice];
              [nav pushViewController: choiceDetail animated: NO];
            }
          }
        };
        [connection start];
      }
    };
  }

  return YES;
}

- (void) application: (UIApplication *) application
didFailToRegisterForRemoteNotificationsWithError: (NSError *) error
{
  NSLog(@"Failed to register for pushes: %@", error.localizedDescription);
}

- (void) application: (UIApplication *) application
didReceiveRemoteNotification: (NSDictionary *) userInfo
{
  // In app alert view pop up
  // [PFPush handlePush: userInfo];
  // If user is in the program
  if (application.applicationState == UIApplicationStateActive) {
    [self updateAllCounts];
  }
  // If user is not in the program
  else {
    // Open the choice detail view controller
    [self.tabBarController switchToViewController: (UIViewController *) 
      self.tabBarController.requestsNav];
    UINavigationController *nav = self.tabBarController.requestsNav;
    // Extract the notification data when an app is opened from a notification
    int choiceId = [[userInfo objectForKey: @"choice_id"] integerValue];
    Choice *choice = [[ChoiceListStore sharedStore] choiceForId: choiceId];
    void (^showChoiceDetailViewController) (Choice *choiceObject) =
      ^(Choice *choiceObject) {
        ChoiceDetailViewController *choiceDetail = 
          [[ChoiceDetailViewController alloc] initWithChoice: choiceObject];
          [nav pushViewController: choiceDetail animated: NO];
      };
    if (choice) {
      showChoiceDetailViewController(choice);
    }
    else {
      // Download choice if its not in the choice list store
      ChoiceInfoConnection *connection =
        [[ChoiceInfoConnection alloc] initWithChoiceId: choiceId];
      connection.completionBlock = ^(NSError *error) {
        if (!error) {
          Choice *newChoice = [[ChoiceListStore sharedStore] choiceForId: 
            choiceId];
          showChoiceDetailViewController(newChoice);
        }
      };
      [connection start];
    }
  }
}

- (void) application: (UIApplication *) application
didRegisterForRemoteNotificationsWithDeviceToken: (NSData *) newDeviceToken
{
  // Store the deviceToken in the current installation and save it to Parse
  PFInstallation *currentInstallation = [PFInstallation currentInstallation];
  [currentInstallation setDeviceTokenFromData: newDeviceToken];
  [currentInstallation saveInBackground];
}

- (BOOL) application: (UIApplication *) application openURL: (NSURL *) url
sourceApplication: (NSString *) sourceApplication annotation: (id) annotation
{
  return [FBSession.activeSession handleOpenURL: url];
}

- (void) applicationDidBecomeActive: (UIApplication *) application
{
  // The flow back to app may be interrupted, let Facebook take care of cleanup
  [FBSession.activeSession handleDidBecomeActive];

  // Clearing the badge
  PFInstallation *currentInstallation = [PFInstallation currentInstallation];
  if (currentInstallation.badge != 0) {
    currentInstallation.badge = 0;
    [currentInstallation saveEventually];
  }
  [self updateAllCounts];
}

- (void) applicationWillTerminate: (UIApplication *) application
{
  [self signOut];
  exit(0);
}

#pragma mark - Methods

- (void) launchCompletionBlock
{
  completionBlock();
}

- (void) openSession
{
  NSArray *permissions = [NSArray arrayWithObjects: @"email", @"user_about_me", 
    @"user_location", nil];
  [FBSession openActiveSessionWithReadPermissions: permissions allowLoginUI: YES
    completionHandler: ^(FBSession *session, FBSessionState state, 
      NSError *error) {
    [self sessionStateChanged: session state: state error: error];
  }];
}

- (void) sessionStateChanged: (FBSession *) session
state: (FBSessionState) state error: (NSError *) error
{
  switch (state) {
    case FBSessionStateOpen: {
      // If Facebook session is good
      UIViewController *presentedViewController =
        [self.tabBarController presentedViewController];
      if ([presentedViewController isKindOfClass: [JoinViewController class]]) {
        // If the presented view controller is the JoinViewController, dismiss
        [presentedViewController dismissViewControllerAnimated: NO
          completion: nil];
      }
      [User currentUser];
      break;
    }
    case FBSessionStateClosed:
    case FBSessionStateClosedLoginFailed:
      // [[User currentUser] signOut];
      [FBSession.activeSession closeAndClearTokenInformation];
      [self showJoin];
      break;
    default:
      break;
  }
  [[NSNotificationCenter defaultCenter] postNotificationName:
    FBSessionStateChangedNotification object: session];
  if (error) {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: @"Error"
      message: error.localizedDescription delegate: nil
        cancelButtonTitle: @"Ok" otherButtonTitles: nil];
    [alertView show];
  }
}

- (void) showJoin
{
  UIViewController *viewController = 
    [self.tabBarController presentedViewController];
  if (![viewController isKindOfClass: [JoinViewController class]]) {
    // If the current view controller is not JoinViewController, present it
    [self.tabBarController presentViewController: self.joinViewController
      animated: NO completion: nil];
  }
}

- (void) signOut
{
  [panel toggleLeftSideMenuCompletion: ^{
    // Reset all view controllers
    [(SpadeTreeTabBarController *) self.tabBarController signOut];
    // User sign out
    [[User currentUser] signOut];
    // Facebook sign out
    [FBSession.activeSession closeAndClearTokenInformation];
  }];
}

- (void) updateAllCounts
{
  [[[NotificationsCountConnection alloc] init] start];
  [[[RequestsCountConnection alloc] init] start];
  [[[MessagesCountConnection alloc] init] start];
}

@end
