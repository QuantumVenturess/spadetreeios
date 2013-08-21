//
//  TuteeChooseTutorialView.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 8/7/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "TuteeChooseTutorialView.h"
#import "UIColor+Extensions.h"
#import "UIImage+Resize.h"

@implementation TuteeChooseTutorialView

#pragma mark - Initializer

- (id) init
{
  self = [super init];
  if (self) {
    CGRect screen = [[UIScreen mainScreen] bounds];
    float marginTop = 20;
    if (screen.size.height > 480) {
      marginTop = 40;
    }
    self.backgroundColor = [UIColor clearColor];
    self.frame = CGRectMake(0, 0, screen.size.width, 
      (screen.size.height - 100));
    // Top view
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor whiteColor];
    topView.frame = CGRectMake(0, 0, screen.size.width, 
      (44 + 20 + 60 + 20 + 40 + 40 + 20));
    [self addSubview: topView];

    // Nav item
    UIView *navItem = [[UIView alloc] init];
    navItem.backgroundColor = [UIColor blackColor];
    navItem.frame = CGRectMake(0, 0, screen.size.width, 44);
    [topView addSubview: navItem];
    // title
    UILabel *navTitle = [[UILabel alloc] init];
    navTitle.backgroundColor = [UIColor clearColor];
    navTitle.font = [UIFont fontWithName: @"HelveticaNeue" size: 20];
    navTitle.frame = CGRectMake(((screen.size.width - 100) / 2.0), 0, 100, 44);
    navTitle.text = @"Chad F";
    navTitle.textAlignment = NSTextAlignmentCenter;
    navTitle.textColor = [UIColor whiteColor];
    [navItem addSubview: navTitle];
    // choose
    UILabel *chooseLabel = [[UILabel alloc] init];
    chooseLabel.backgroundColor = [UIColor clearColor];
    chooseLabel.font = [UIFont fontWithName: @"HelveticaNeue" size: 14];
    chooseLabel.frame = CGRectMake((screen.size.width - (50 + 10)), 
      13, 50, 18);
    chooseLabel.text = @"Choose";
    chooseLabel.textColor = [UIColor whiteColor];
    [navItem addSubview: chooseLabel];
    // image
    int imageSize = 60;
    UIImageView *userImageView = [[UIImageView alloc] init];
    userImageView.backgroundColor = [UIColor clearColor];
    userImageView.clipsToBounds = YES;
    userImageView.contentMode = UIViewContentModeTopLeft;
    userImageView.frame = CGRectMake(10, (navTitle.frame.origin.y + 
      navTitle.frame.size.height + 20), imageSize, imageSize);
    userImageView.image = [UIImage image: [UIImage imageNamed: 
      @"tutorial_user.jpg"] size: CGSizeMake(imageSize, imageSize)];
    [topView addSubview: userImageView];
    // Name label
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.font = [UIFont fontWithName: @"HelveticaNeue" size: 20];
    nameLabel.frame = CGRectMake((10 + imageSize + 10), 
      userImageView.frame.origin.y, 
        (screen.size.width - (10 + imageSize + 10 + 10)), (imageSize / 2.0));
    nameLabel.text = @"Chad F";
    nameLabel.textColor = [UIColor gray: 50];
    [topView addSubview: nameLabel];
    // Location
    // image
    UIImageView *locationImageView = [[UIImageView alloc] init];
    locationImageView.frame = CGRectMake((10 + imageSize + 10),
      (nameLabel.frame.origin.y + nameLabel.frame.size.height + (15 / 2.0)), 
        15, 15);
    locationImageView.image = [UIImage image: [UIImage imageNamed: 
      @"location.png"] size: CGSizeMake(15, 15)];
    [topView addSubview: locationImageView];
    // label
    UILabel *locationLabel = [[UILabel alloc] init];
    locationLabel.backgroundColor = [UIColor clearColor];
    locationLabel.font = [UIFont fontWithName: @"HelveticaNeue" size: 14];
    locationLabel.frame = CGRectMake((10 + imageSize + 10 + 15 + 5), 
      (nameLabel.frame.origin.y + nameLabel.frame.size.height), 
        (screen.size.width - (10 + imageSize + 10 + 10)), (imageSize / 2.0));
    locationLabel.text = @"San Diego, California";
    locationLabel.textColor = [UIColor gray: 50];
    [topView addSubview: locationLabel];

    // About
    imageSize = 18;
    UIView *header = [[UIView alloc] init];
    header.backgroundColor = [UIColor clearColor];
    header.frame = CGRectMake(0, (userImageView.frame.origin.y + 
      userImageView.frame.size.height + 20), screen.size.width, 40);
    [topView addSubview: header];
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName: @"HelveticaNeue" size: 20];
    label.frame = CGRectMake((10 + imageSize + 10), 0, 
      (screen.size.width - (10 + imageSize + 10 + 10)), 40);
    label.text = @"About";
    label.textColor = [UIColor gray: 50];
    [header addSubview: label];
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(10, 10, imageSize, imageSize);
    imageView.image = [UIImage image: [UIImage imageNamed: @"about_user.png"]
      size: CGSizeMake(imageSize, imageSize)];
    [header addSubview: imageView];
    // Content
    UILabel *aboutLabel = [[UILabel alloc] init];
    aboutLabel.backgroundColor = [UIColor clearColor];
    aboutLabel.font = [UIFont fontWithName: @"HelveticaNeue" size: 14];
    aboutLabel.frame = CGRectMake(10, (header.frame.origin.y + 
      header.frame.size.height), (screen.size.width - 20), 40);
    aboutLabel.numberOfLines = 0;
    aboutLabel.text = @"Art and music are my passions. "
      @"I also love going outdoors and playing every kind of sport.";
    aboutLabel.textColor = [UIColor gray: 50];
    [topView addSubview: aboutLabel];

    // Info
    UILabel *info = [[UILabel alloc] init];
    info.backgroundColor = [UIColor clearColor];
    info.font = [UIFont fontWithName: @"HelveticaNeue" size: 15];
    info.frame = CGRectMake(10, (topView.frame.origin.y + 
      topView.frame.size.height + marginTop), (screen.size.width - 20), 40);
    info.numberOfLines = 0;
    info.text = @"Find a tutor who shares the same interest "
      @"then choose him/her as your tutor";
    info.textAlignment = NSTextAlignmentCenter;
    info.textColor = [UIColor whiteColor];
    [self addSubview: info];
  }
  return self;
}

@end
