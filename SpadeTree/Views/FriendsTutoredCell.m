//
//  FriendsTutoredCell.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/25/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "FriendsTutoredCell.h"
#import "Interest.h"
#import "InterestDetailViewController.h"
#import "UIColor+Extensions.h"
#import "User.h"

@implementation FriendsTutoredCell

@synthesize interests;
@synthesize navigationController;
@synthesize user;

#pragma mark - Initializer

- (id) initWithStyle: (UITableViewCellStyle) style
reuseIdentifier: (NSString *) reuseIdentifier
{
  self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
  if (self) {
    self.interests = [NSMutableArray array];

    UIFont *font = [UIFont fontWithName: @"HelveticaNeue" size: 14];
    CGRect screen = [[UIScreen mainScreen] bounds];
    // UITableViewCell properties
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    UIView *mainView = [[UIView alloc] init];
    mainView.backgroundColor = [UIColor clearColor];
    mainView.frame = CGRectMake(0, 0, screen.size.width, 60);
    [self.contentView addSubview: mainView];
    // Image view
    imageView = [[UIImageView alloc] init];
    imageView.clipsToBounds = YES;
    imageView.contentMode = UIViewContentModeTopLeft;
    imageView.frame = CGRectMake(10, 10, 40, 40);
    [mainView addSubview: imageView];
    // Name
    nameLabel = [[UILabel alloc] init];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.font = font;
    nameLabel.frame = CGRectMake((10 + 40 + 10), 10, 
      (screen.size.width - (10 + 40 + 10 + 10)), 20);
    nameLabel.textColor = [UIColor gray: 50];
    [mainView addSubview: nameLabel];
    // Interests view
    interestsView = [[UIView alloc] init];
    interestsView.clipsToBounds = YES;
    interestsView.frame = CGRectMake((10 + 40 + 10), (10 + 20), 
      (screen.size.width - (10 + 40 + 10 + 10)), 20);
    [self addSubview: interestsView];
  }
  return self;
}

#pragma mark - Methods

- (void) loadDictionaryData: (NSDictionary *) dictionary
{
  self.interests = [dictionary objectForKey: @"interests"];
  self.user      = [dictionary objectForKey: @"user"];
  // Image view
  if (self.user.image) {
    imageView.image = [self.user imageWithSize: CGSizeMake(40, 40)];
  }
  else {
    [self.user downloadImage: ^(NSError *error) {
      if (!error) {
        imageView.image = [self.user imageWithSize: CGSizeMake(40, 40)];
      }
    }];
    imageView.image = [UIImage imageNamed: @"placeholder.png"];
  }
  // Name
  nameLabel.text = [self.user fullName];
  // Interests
  NSMutableArray *buttons = [NSMutableArray array];
  for (Interest *interest in self.interests) {
    int index = [self.interests indexOfObject: interest];
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName: @"HelveticaNeue" size: 14];
    label.frame = CGRectMake(0, 0, 0, 20);
    label.text = [interest nameTitle];
    if (index + 1 != self.interests.count) {
      label.text = [NSString stringWithFormat: @"%@, ", label.text];
    }
    label.textColor = [UIColor spadeGreenDark];
    CGSize maxSize = CGSizeMake(interestsView.frame.size.width, 20);
    CGSize textSize = [label.text sizeWithFont: label.font
      constrainedToSize: maxSize];
    CGRect frame = label.frame;
    frame.size.width = textSize.width;
    label.frame = frame;
    UIButton *button = [[UIButton alloc] init];
    button.frame = label.frame;
    button.tag = index;
    [button addSubview: label];
    [button addTarget: self action: @selector(showInterest:)
      forControlEvents: UIControlEventTouchUpInside];
    [buttons addObject: button];
  }
  // Interest buttons
  // remove all buttons from interests view
  [interestsView.subviews makeObjectsPerformSelector: 
    @selector(removeFromSuperview)];
  // add buttons to interests view
  for (UIButton *button in buttons) {
    int index = [buttons indexOfObject: button];
    if (index > 0) {
      UIButton *previousButton = [buttons objectAtIndex: index - 1];
      CGRect frame = button.frame;
      frame.origin.x = previousButton.frame.origin.x + 
        previousButton.frame.size.width;
      button.frame = frame;
      // If the buttons for the interests are too long, make it smaller
      if (button.frame.origin.x + button.frame.size.width > 
        interestsView.frame.size.width) {
        // Resize the button
        CGRect newFrame = button.frame;
        newFrame.size.width = interestsView.frame.size.width - 
          button.frame.origin.x;
        button.frame = newFrame;
        // Resize the label on the button
        UIView *labelView = [button.subviews objectAtIndex: 0];
        CGRect newLabelFrame = labelView.frame;
        newLabelFrame.size.width = newFrame.size.width;
        labelView.frame = newLabelFrame;
      }
    }
    [interestsView addSubview: button];
  }
}

- (void) showInterest: (id) sender
{
  UIButton *button = (UIButton *) sender;
  Interest *interest = [self.interests objectAtIndex: button.tag];
  [self.navigationController pushViewController: 
    [[InterestDetailViewController alloc] initWithInterest: interest]
      animated: YES];
}

@end
