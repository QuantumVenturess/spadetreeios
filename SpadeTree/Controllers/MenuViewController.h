//
//  MenuViewController.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/11/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "SpadeTreeViewController.h"

@class AppDelegate;

@interface MenuViewController : SpadeTreeViewController <UIAlertViewDelegate>
{
  AppDelegate *appDelegate;
  UIButton *aboutButton;
  UIAlertView *alertView;
  NSArray *buttons;
  UIButton *editProfileButton;
  UIButton *profileButton;
  UIButton *signOutButton;
}

@property (nonatomic, strong) UIButton *messagesButton;
@property (nonatomic, strong) UILabel *messagesCount;
@property (nonatomic, strong) UIButton *notificationsButton;
@property (nonatomic, strong) UILabel *notificationsCount;
@property (nonatomic, strong) UIImageView *profileImageView;
@property (nonatomic, strong) UIButton *requestsButton;
@property (nonatomic, strong) UILabel *requestsCount;

#pragma mark - Methods

- (void) unselectAllButtons;

@end
