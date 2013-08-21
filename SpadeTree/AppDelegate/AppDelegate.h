//
//  AppDelegate.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 6/27/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import <FacebookSDK/FacebookSDK.h>
#import <UIKit/UIKit.h>

extern NSString *const CurrentUserSignOut;
extern NSString *const FBSessionStateChangedNotification;

@class MFSideMenuContainerViewController;
@class JoinViewController;
@class MenuViewController;
@class PickView;
@class SpadeTreeTabBarController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
  void (^completionBlock) (void);
}

@property (nonatomic, strong) MFSideMenuContainerViewController *panel;
@property (nonatomic, strong) JoinViewController *joinViewController;
@property (nonatomic, strong) MenuViewController *menu;
@property (nonatomic, strong) PickView *pickView;
@property (nonatomic, strong) SpadeTreeTabBarController *tabBarController;
@property (nonatomic, strong) UIWindow *window;

#pragma mark - Methods

- (void) openSession;
- (void) signOut;

@end
