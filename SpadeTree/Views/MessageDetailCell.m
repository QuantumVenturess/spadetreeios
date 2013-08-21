//
//  MessageDetailCell.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/30/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "Message.h"
#import "MessageDetailCell.h"
#import "UIColor+Extensions.h"
#import "User.h"

@implementation MessageDetailCell

#pragma mark - Initializer

- (id) initWithStyle: (UITableViewCellStyle) style
reuseIdentifier: (NSString *) reuseIdentifier
{
  self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
  if (self) {
    CGRect screen = [[UIScreen mainScreen] bounds];
    // UITableViewCell properties
    self.selectedBackgroundView = [[UIView alloc] init];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Main view
    UIView *mainView = [[UIView alloc] init];
    mainView.backgroundColor = [UIColor clearColor];
    mainView.frame = CGRectMake(0, 0, screen.size.width, 60);
    [self.contentView addSubview: mainView];
    // Image view
    imageView = [[UIImageView alloc] init];
    imageView.clipsToBounds = YES;
    imageView.contentMode = UIViewContentModeTopLeft;
    imageView.frame = CGRectMake(5, 5, 30, 30);
    [mainView addSubview: imageView];
    // Content view
    contentBox = [[UIView alloc] init];
    contentBox.backgroundColor = [UIColor gray: 255];
    contentBox.frame = CGRectMake((5 + 30), 5, 
      (screen.size.width - (35 * 3)), 50);
    [mainView addSubview: contentBox];
    // Content label
    contentLabel = [[UILabel alloc] init];
    contentLabel.backgroundColor = [UIColor clearColor];
    contentLabel.font = [UIFont fontWithName: @"HelveticaNeue" size: 13];
    contentLabel.frame = CGRectMake(5, 5, 
      (contentBox.frame.size.width - 10), 20);
    contentLabel.numberOfLines = 0;
    contentLabel.textColor = [UIColor gray: 50];
    [contentBox addSubview: contentLabel];
    // Created label
    createdLabel = [[UILabel alloc] init];
    createdLabel.backgroundColor = [UIColor clearColor];
    createdLabel.font = [UIFont fontWithName: @"HelveticaNeue" size: 11];
    createdLabel.frame = CGRectMake(5, (5 + 20 + 5), 
      (contentBox.frame.size.width - 10), 20);
    createdLabel.textColor = [UIColor gray: 150];
    [contentBox addSubview: createdLabel];
  }
  return self;
}

#pragma mark - Methods

- (void) loadMessageData: (Message *) messageObject
{
  message = messageObject;
  CGRect screen = [[UIScreen mainScreen] bounds];
  // Image
  if (message.sender.image) {
    imageView.image = [message.sender imageWithSize: CGSizeMake(30, 30)];
  }
  else {
    [message.sender downloadImage: ^(NSError *error) {
      imageView.image = [message.sender imageWithSize: 
        CGSizeMake(30, 30)];
    }];
    imageView.image = [UIImage imageNamed: @"placeholder.png"];
  }
  float maxWidth = (screen.size.width - (35 * 3)) - 10;
  // Content label
  contentLabel.text = message.content;
  CGSize contentSize = [contentLabel.text sizeWithFont: contentLabel.font
    constrainedToSize: CGSizeMake(maxWidth, 5000)];
  CGRect contentFrame = contentLabel.frame;
  contentFrame.size.height = contentSize.height;
  contentFrame.size.width  = contentSize.width;
  contentLabel.frame = contentFrame;
  // Created label
  createdLabel.text = [message createdDateStringForDetail];
  CGSize createdSize = [createdLabel.text sizeWithFont: createdLabel.font
    constrainedToSize: CGSizeMake((maxWidth), 20)];
  CGRect createdFrame = createdLabel.frame;
  createdFrame.origin.y = 5 + contentLabel.frame.size.height + 5;
  createdFrame.size.width = createdSize.width;
  createdLabel.frame = createdFrame;
  // Content box
  float biggestWidth = contentLabel.frame.size.width;
  if (createdLabel.frame.size.width > biggestWidth) {
    biggestWidth = createdLabel.frame.size.width;
  }
  CGRect boxFrame = contentBox.frame;
  boxFrame.size.height = contentLabel.frame.size.height +
    createdLabel.frame.size.height + (5 + 5 + 5);
  boxFrame.size.width  = biggestWidth + 10;
  contentBox.frame = boxFrame;

  CGRect imageViewFrame  = imageView.frame;
  CGRect contentBoxFrame = contentBox.frame;
  // If the current user is the message's sender
  if ([User currentUser].uid == message.sender.uid) {
    // Move the image to the right side
    imageViewFrame.origin.x = screen.size.width - 
      (imageView.frame.size.width + 5);
    imageViewFrame.origin.y = (5 + contentBox.frame.size.height) - 
      imageView.frame.size.height;
    // Move the content box to the right side
    contentBoxFrame.origin.x = screen.size.width -
      (contentBox.frame.size.width + imageView.frame.size.width + 5);
  }
  // If the message's sender is another user
  else {
    imageViewFrame.origin.x  = 5;
    imageViewFrame.origin.y  = 5;
    contentBoxFrame.origin.x = 5 + imageView.frame.size.width;
  }
  imageView.frame  = imageViewFrame;
  contentBox.frame = contentBoxFrame;
}

@end
