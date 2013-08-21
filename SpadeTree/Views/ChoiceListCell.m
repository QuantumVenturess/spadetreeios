//
//  ChoiceListCell.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 8/1/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "Choice.h"
#import "ChoiceListCell.h"
#import "Day.h"
#import "Hour.h"
#import "Interest.h"
#import "UIColor+Extensions.h"
#import "User.h"

@implementation ChoiceListCell

#pragma mark - Initializer

- (id) initWithStyle: (UITableViewCellStyle) style 
reuseIdentifier: (NSString *) reuseIdentifier
{
  self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
  if (self) {
    CGRect screen = [[UIScreen mainScreen] bounds];
    UIFont *font13 = [UIFont fontWithName: @"HelveticaNeue" size: 13];
    // UITableViewCell properties
    self.selectedBackgroundView = [[UIView alloc] init];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Main view
    UIView *mainView = [[UIView alloc] init];
    mainView.backgroundColor = [UIColor clearColor];
    mainView.frame = CGRectMake(0, 0, screen.size.width, 150);
    [self.contentView addSubview: mainView];
    // Image view
    imageView = [[UIImageView alloc] init];
    imageView.clipsToBounds = YES;
    imageView.contentMode = UIViewContentModeTopLeft;
    imageView.frame = CGRectMake(10, 20, 50, 50);
    [mainView addSubview: imageView];
    // Name label
    nameLabel = [[UILabel alloc] init];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.font = [UIFont fontWithName: @"HelveticaNeue" size: 18];
    nameLabel.frame = CGRectMake((10 + 50 + 10), 20,
      (screen.size.width - (10 + 50 + 10 + 10)), 30);
    nameLabel.textColor = [UIColor gray: 50];
    [mainView addSubview: nameLabel];
    // Interest label
    interestLabel = [[UILabel alloc] init];
    interestLabel.backgroundColor = [UIColor clearColor];
    interestLabel.font = [UIFont fontWithName: @"HelveticaNeue" size: 14];
    interestLabel.frame = CGRectMake((10 + 50 + 10), (20 + 30),
      (screen.size.width - (10 + 50 + 10 + 10)), 20);
    [mainView addSubview: interestLabel];
    // Status label
    statusLabel = [[UILabel alloc] init];
    statusLabel.backgroundColor = [UIColor clearColor];
    statusLabel.font = font13;
    statusLabel.frame = CGRectMake(10, (20 + 50 + 10),
      ((screen.size.width - 20) / 1.5), 20);
    statusLabel.textColor = [UIColor gray: 150];
    [mainView addSubview: statusLabel];
    // Created label
    createdLabel = [[UILabel alloc] init];
    createdLabel.backgroundColor = [UIColor clearColor];
    createdLabel.font = font13;
    createdLabel.frame = CGRectMake(
      (statusLabel.frame.origin.x + statusLabel.frame.size.width), 
        statusLabel.frame.origin.y, ((screen.size.width - 20) / 3), 20);
    createdLabel.textAlignment = NSTextAlignmentRight;
    createdLabel.textColor = [UIColor gray: 150];
    [mainView addSubview: createdLabel];
    // Content label
    contentLabel = [[UILabel alloc] init];
    contentLabel.backgroundColor = [UIColor clearColor];
    contentLabel.font = font13;
    contentLabel.frame = CGRectMake(10, (20 + 50 + 10 + 20 + 10), 
      (screen.size.width - 20), 20);
    contentLabel.numberOfLines = 0;
    contentLabel.textColor = [UIColor gray: 50];
    [mainView addSubview: contentLabel];
  }
  return self;
}

#pragma mark - Methods

- (void) loadChoiceData: (Choice *) choiceObject
{
  choice = choiceObject;
  User *user;
  // If current user is a tutee, then get the choice's tutor
  if ([User currentUser].tutee) {
    user = choice.tutor;
  }
  // If the current user is a tutor, then get the choice's tutee
  else {
    user = choice.tutee;
  }
  // Image
  if (user.image) {
    imageView.image = [user imageWithSize: CGSizeMake(50, 50)];
  }
  else {
    [user downloadImage: ^(NSError *error) {
      imageView.image = [user imageWithSize: 
        CGSizeMake(50, 50)];
    }];
    imageView.image = [UIImage imageNamed: @"placeholder.png"];
  }
  // Name label
  NSString *dear;
  if ([User currentUser].tutee) {
    dear = @"To";
  }
  else {
    dear = @"From";
  }
  nameLabel.text = [NSString stringWithFormat: @"%@: %@", 
    dear, [user fullName]];
  // Interest label
  interestLabel.text = [NSString stringWithFormat: @"%@ - %@ at %@",
    [choice.interest nameTitle], [choice.day nameTitle], 
      [choice.hour hourAndAmPm]];
  // Status label
  NSString *status;
  if (choice.completed) {
    // Completed on Jun 24, 13
    status = [NSString stringWithFormat: @"Completed on %@",
      [choice dateCompletedStringForList]];
    statusLabel.textColor = [UIColor gray: 150];
  }
  else if (choice.accepted) {
    // Accepted
    status = @"Accepted";
    statusLabel.textColor = [UIColor spadeGreen];
  }
  else if (choice.denied) {
    // Denied
    status = @"Denied";
    statusLabel.textColor = [UIColor red];
  }
  else {
    // If current user is a tutee
    if ([User currentUser].tutee) {
      // Waiting for Bob's acceptance
      status = @"Request pending";
    }
    else {
      // Waiting for your acceptance
      status = @"Waiting for your decision";
    }
  }
  statusLabel.text = status;
  // Created label
  createdLabel.text = [choice createdDateStringForList];
  // Content label
  contentLabel.text = choice.content;
  CGSize contentSize = [contentLabel.text sizeWithFont: contentLabel.font
    constrainedToSize: CGSizeMake(contentLabel.frame.size.width, 5000)];
  CGRect contentFrame = contentLabel.frame;
  contentFrame.size.height = contentSize.height;
  contentLabel.frame = contentFrame;
}

@end
