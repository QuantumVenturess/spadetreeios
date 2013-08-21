//
//  SpadeTreeTabBarController.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 6/27/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SpadeTreeNavigationController;
@class TutorialViewController;

@interface SpadeTreeTabBarController : UITabBarController

@property (nonatomic, strong) SpadeTreeNavigationController *aboutNav;
@property (nonatomic, strong) SpadeTreeNavigationController *browseNav;
@property (nonatomic, strong) SpadeTreeNavigationController *editProfileNav;
@property (nonatomic, strong) SpadeTreeNavigationController *messagesNav;
@property (nonatomic, strong) SpadeTreeNavigationController *notificationsNav;
@property (nonatomic, strong) SpadeTreeNavigationController *requestsNav;
@property (nonatomic, strong) TutorialViewController *tutorial;
@property (nonatomic, strong) SpadeTreeNavigationController *userDetailNav;

#pragma mark - Methods

- (void) showTutorial;
- (void) signOut;
- (void) switchToViewController: (UIViewController *) vc;

@end
