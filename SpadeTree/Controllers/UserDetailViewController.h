//
//  UserDetailViewController.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/11/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "SpadeTreeTableViewController.h"

@class SpadeTreeNavigationController;
@class User;

@interface UserDetailViewController : SpadeTreeTableViewController
{
  SpadeTreeNavigationController *addReviewNav;
  SpadeTreeNavigationController *chooseTutorNav;
  UILabel *nameLabel;
  UILabel *locationLabel;
  UIImageView *userImageView;
}

@property (nonatomic, strong) User *user;

#pragma mark - Initializer

- (id) initWithUser: (User *) userObject;

#pragma mark - Methods

- (void) loadUserData: (User *) userObject;

@end
