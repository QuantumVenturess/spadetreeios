//
//  NotificationCell.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 8/5/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "Notification.h"
#import "NotificationCell.h"
#import "UIColor+Extensions.h"
#import "User.h"
#import "UserDetailViewController.h"

@implementation NotificationCell

@synthesize navigationController;

#pragma mark - Initializer

- (id) initWithStyle: (UITableViewCellStyle) style
reuseIdentifier: (NSString *) reuseIdentifier
{
  self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
    if (self) {
    CGRect screen = [[UIScreen mainScreen] bounds];
    UIFont *font = [UIFont fontWithName: @"HelveticaNeue" size: 12];
    // UITableViewCell properties
    UIView *bgView = [[UIView alloc] init];
    bgView.frame = screen;
    bgView.backgroundColor = [UIColor spadeGreen];
    self.selectedBackgroundView = bgView;
    self.selectionStyle = UITableViewCellSelectionStyleGray;
    // Main view
    UIView *mainView = [[UIView alloc] init];
    mainView.backgroundColor = [UIColor whiteColor];
    mainView.frame = CGRectMake(0, 0, screen.size.width, 40);
    [self.contentView addSubview: mainView];
    // Message label
    messageLabel = [[UILabel alloc] init];
    messageLabel.backgroundColor = [UIColor clearColor];
    messageLabel.font = font;
    messageLabel.textColor = [UIColor gray: 50];
    [mainView addSubview: messageLabel];
    // User Button
    userButton = [[UIButton alloc] init];
    userButton.backgroundColor = [UIColor clearColor];
    [userButton addTarget: self action: @selector(showUser)
      forControlEvents: UIControlEventTouchUpInside];
    [self.contentView addSubview: userButton];
    // User name label
    userNameLabel = [[UILabel alloc] init];
    userNameLabel.backgroundColor = [UIColor clearColor];
    userNameLabel.font = font;
    userNameLabel.textColor = [UIColor spadeGreenDark];
    [userButton addSubview: userNameLabel];
  }
  return self;
}

#pragma mark - Methods

- (void) loadNotificationData: (Notification *) notificationObject
{
  notification = notificationObject;
  CGRect screen = [[UIScreen mainScreen] bounds];
  // User button and name label
  userNameLabel.text = [notification.user fullName];
  CGSize userSize = [userNameLabel.text sizeWithFont: userNameLabel.font
    constrainedToSize: CGSizeMake((screen.size.width - 20), 20)];
  userNameLabel.frame = CGRectMake(0, 0, userSize.width, 20);
  userButton.frame = CGRectMake(10, 10, userSize.width, 20);
  // Message
  messageLabel.text = [NSString stringWithFormat: @" %@", notification.message];
  CGSize messageSize = [messageLabel.text sizeWithFont: messageLabel.font
    constrainedToSize: CGSizeMake(
      ((screen.size.width - 20) - userButton.frame.size.width), 20)];
  messageLabel.frame = CGRectMake(
    (userButton.frame.origin.x + userButton.frame.size.width), 10, 
      messageSize.width, 20);
}

- (void) showUser
{
  [self.navigationController pushViewController: 
    [[UserDetailViewController alloc] initWithUser: notification.user] 
      animated: YES];
}

@end
