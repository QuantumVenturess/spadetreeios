//
//  InterestDetailCell.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/10/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "City.h"
#import "InterestDetailCell.h"
#import "State.h"
#import "UIColor+Extensions.h"
#import "User.h"

@implementation InterestDetailCell

@synthesize imageView;

#pragma mark - Initializer

- (id) initWithStyle: (UITableViewCellStyle) style
reuseIdentifier: (NSString *) reuseIdentifier
{
  self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
  if (self) {
    CGRect screen = [[UIScreen mainScreen] bounds];
    UIFont *font = [UIFont fontWithName: @"HelveticaNeue" size: 14];
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
    self.imageView = [[UIImageView alloc] init];
    self.imageView.backgroundColor = [UIColor clearColor];
    self.imageView.clipsToBounds = YES;
    self.imageView.contentMode = UIViewContentModeTopLeft;
    self.imageView.frame = CGRectMake(10, 10, 40, 40);
    [mainView addSubview: self.imageView];
    // Name label
    nameLabel = [[UILabel alloc] init];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.font = font;
    nameLabel.frame = CGRectMake((10 + 40 + 10), 10,
      (screen.size.width - (10 + 40 + 10 + 10)), 20);
    nameLabel.textColor = [UIColor gray: 50];
    [mainView addSubview: nameLabel];
    // Location label
    locationLabel = [[UILabel alloc] init];
    locationLabel.backgroundColor = [UIColor clearColor];
    locationLabel.font = font;
    locationLabel.frame = CGRectMake((10 + 40 + 10), (10 + 20),
      (screen.size.width - (10 + 40 + 10 + 10)), 20);
    locationLabel.textColor = [UIColor gray: 150];
    [mainView addSubview: locationLabel];
  }
  return self;
}

#pragma mark - Methods

- (void) loadUserData: (User *) userObject
{
  user = userObject;
  // Name and location label
  nameLabel.text     = [user fullName];
  locationLabel.text = [user locationString];
  // Image
  if (user.image) {
    self.imageView.image = [user imageWithSize: CGSizeMake(40, 40)];
  }
  else {
    [user downloadImage: ^(NSError *error) {
      self.imageView.image = [user imageWithSize: CGSizeMake(40, 40)];
    }];
    self.imageView.image = [UIImage imageNamed: @"placeholder.png"];
  }
}

@end
