//
//  MessageListCell.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/30/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Message;

@interface MessageListCell : UITableViewCell
{
  UILabel *contentLabel;
  UILabel *createdLabel;
  UIImageView *imageView;
  Message *message;
  UILabel *nameLabel;
  UIView *viewedBorder;
}

#pragma mark - Methods

- (void) loadMessageData: (Message *) messageObject;

@end
