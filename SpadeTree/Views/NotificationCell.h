//
//  NotificationCell.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 8/5/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Notification;

@interface NotificationCell : UITableViewCell
{
  UILabel *messageLabel;
  Notification *notification;
  UIButton *userButton;
  UILabel *userNameLabel;
}

@property (nonatomic, weak) UINavigationController *navigationController;

#pragma mark - Methods

- (void) loadNotificationData: (Notification *) notificationObject;

@end
