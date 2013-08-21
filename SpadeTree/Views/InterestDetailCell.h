//
//  InterestDetailCell.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/10/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import <UIKit/UIKit.h>

@class User;

@interface InterestDetailCell : UITableViewCell
{
  User *user;
  UILabel *locationLabel;
  UILabel *nameLabel;
}

@property (nonatomic, strong) UIImageView *imageView;

#pragma mark - Methods

- (void) loadUserData: (User *) userObject;

@end
