//
//  MessageListCell.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/30/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "Message.h"
#import "MessageListCell.h"
#import "UIColor+Extensions.h"
#import "User.h"

@implementation MessageListCell

#pragma mark - Initializer

- (id) initWithStyle: (UITableViewCellStyle) style
reuseIdentifier: (NSString *) reuseIdentifier
{
  self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
  if (self) {
    CGRect screen = [[UIScreen mainScreen] bounds];
    UIFont *font14 = [UIFont fontWithName: @"HelveticaNeue" size: 14];
    // UITableViewCell properties
    UIView *bgView = [[UIView alloc] init];
    bgView.frame = screen;
    bgView.backgroundColor = [UIColor spadeGreen];
    self.selectedBackgroundView = bgView;
    self.selectionStyle = UITableViewCellSelectionStyleGray;
    // Main view
    UIView *mainView = [[UIView alloc] init];
    mainView.backgroundColor = [UIColor whiteColor];
    mainView.frame = CGRectMake(0, 0, screen.size.width, 60);
    [self.contentView addSubview: mainView];
    // Image view
    imageView = [[UIImageView alloc] init];
    imageView.clipsToBounds = YES;
    imageView.contentMode = UIViewContentModeTopLeft;
    imageView.frame = CGRectMake(10, 10, 40, 40);
    [mainView addSubview: imageView];
    // Name label
    nameLabel = [[UILabel alloc] init];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.font = [UIFont fontWithName: @"HelveticaNeue-Bold" size: 14];
    nameLabel.frame = CGRectMake((10 + 40 + 10), 10, 
      ((screen.size.width - (10 + 40 + 10 + 10)) / 2.0), 20);
    nameLabel.textColor = [UIColor gray: 50];
    [mainView addSubview: nameLabel];
    // Content label
    contentLabel = [[UILabel alloc] init];
    contentLabel.backgroundColor = [UIColor clearColor];
    contentLabel.font = font14;
    contentLabel.frame = CGRectMake((10 + 40 + 10), (10 + 20),
      (screen.size.width - (10 + 40 + 10 + 10)), 20);
    contentLabel.textColor = [UIColor gray: 50];
    [mainView addSubview: contentLabel];
    // Created label
    createdLabel = [[UILabel alloc] init];
    createdLabel.backgroundColor = [UIColor clearColor];
    createdLabel.font = [UIFont fontWithName: @"HelveticaNeue" size: 12];
    createdLabel.frame =
      CGRectMake((10 + 40 + 10 + nameLabel.frame.size.width), 10, 
        ((screen.size.width - (10 + 40 + 10 + 10)) / 2.0), 20);
    createdLabel.textAlignment = NSTextAlignmentRight;
    createdLabel.textColor = [UIColor gray: 150];
    [mainView addSubview: createdLabel];
    // Viewed border
    viewedBorder = [[UIView alloc] init];
    viewedBorder.backgroundColor = [UIColor clearColor];
    viewedBorder.frame = CGRectMake(0, 0, 1, 60);
    [mainView addSubview: viewedBorder];
  }
  return self;
}

#pragma mark - Methods

- (void) loadMessageData: (Message *) messageObject
{
  message = messageObject;
  // Image
  if (message.sender.image) {
    imageView.image = [message.sender imageWithSize: CGSizeMake(40, 40)];
  }
  else {
    [message.sender downloadImage: ^(NSError *error) {
      imageView.image = [message.sender imageWithSize: 
        CGSizeMake(40, 40)];
    }];
    imageView.image = [UIImage imageNamed: @"placeholder.png"];
  }
  // Name
  nameLabel.text = [message.sender fullName];
  // Content
  contentLabel.text = message.content;
  // Created
  createdLabel.text = [message createdDateStringForList];
  // If message is not viewed
  if (message.viewed) {
    viewedBorder.backgroundColor = [UIColor clearColor];
  }
  else {
    viewedBorder.backgroundColor = [UIColor colorWithRed: 1 green: (26/255.0) 
      blue: 0 alpha: 1];
  }
}

@end
