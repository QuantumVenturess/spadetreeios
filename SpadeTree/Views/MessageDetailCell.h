//
//  MessageDetailCell.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/30/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Message;

@interface MessageDetailCell : UITableViewCell
{
  UIView *contentBox;
  UILabel *contentLabel;
  UILabel *createdLabel;
  UIImageView *imageView;
  Message *message;
}

#pragma mark - Methods

- (void) loadMessageData: (Message *) messageObject;

@end
