//
//  TutorEditProfileTutorialView.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 8/7/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "TextFieldPadding.h"
#import "TutorEditProfileTutorialView.h"
#import "UIColor+Extensions.h"
#import "UIImage+Resize.h"

@implementation TutorEditProfileTutorialView

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
      (40 + 80 + 40 + 40 + 40 + 40 + 20));
    [self addSubview: topView];

    UIFont *font14 = [UIFont fontWithName: @"HelveticaNeue" size: 14];
    UIFont *font20 = [UIFont fontWithName: @"HelveticaNeue" size: 20];
    UIColor *gray50 = [UIColor gray: 50];
    CGRect headerFrame = CGRectMake((10 + 18 + 10), 0,
      (screen.size.width - (10 + 18 + 10 + 10)), 40);
    CGRect imageFrame = CGRectMake(10, 10, 18, 18);
    CGSize imageSize = CGSizeMake(18, 18);
    // About view
    UIView *aboutView = [[UIView alloc] init];
    aboutView.backgroundColor = [UIColor clearColor];
    aboutView.frame = CGRectMake(0, 0, 
      screen.size.width, (40 + 80));
    UILabel *aboutLabel = [[UILabel alloc] init];
    aboutLabel.backgroundColor = [UIColor clearColor];
    aboutLabel.font = font20;
    aboutLabel.frame = headerFrame;
    aboutLabel.text = @"About";
    aboutLabel.textColor = gray50;
    [aboutView addSubview: aboutLabel];
    UIImageView *aboutImageView = [[UIImageView alloc] init];
    aboutImageView.frame = imageFrame;
    aboutImageView.image = [UIImage image: [UIImage imageNamed:
      @"about_user.png"] size: imageSize];
    [aboutView addSubview: aboutImageView];
    [self addSubview: aboutView];
    // about box
    UIView *aboutBox = [[UIView alloc] init];
    aboutBox.backgroundColor = [UIColor clearColor];
    aboutBox.frame = CGRectMake(10, (aboutLabel.frame.origin.y + 
      aboutLabel.frame.size.height), (screen.size.width - 20), 80);
    aboutBox.layer.borderColor = [UIColor spadeGreen].CGColor;
    aboutBox.layer.borderWidth = 1;
    [aboutView addSubview: aboutBox];
    // about text view
    UITextView *aboutTextView = [[UITextView alloc] init];
    aboutTextView.backgroundColor = [UIColor clearColor];
    // Top, left, bottom. right
    aboutTextView.contentInset = UIEdgeInsetsMake(-8, -8, -8, -8);
    aboutTextView.frame = CGRectMake(10, 10, 
      (aboutBox.frame.size.width - 20), 60);
    aboutTextView.font = [UIFont fontWithName: @"HelveticaNeue" size: 15];
    aboutTextView.scrollEnabled = NO;
    aboutTextView.text = @"Art and music are my passions. "
      @"I also love going outdoors and playing every kind of sport, "
      @"especially            .";
    aboutTextView.textColor = gray50;
    aboutTextView.userInteractionEnabled = NO;
    [aboutBox addSubview: aboutTextView];

    // Location view
    UIView *locationView = [[UIView alloc] init];
    locationView.backgroundColor = [UIColor whiteColor];
    locationView.frame = CGRectMake(0, (aboutView.frame.origin.y + 
      aboutView.frame.size.height), screen.size.width, (40 + 40));
    [self addSubview: locationView];
    UILabel *locationLabel = [[UILabel alloc] init];
    locationLabel.backgroundColor = [UIColor clearColor];
    locationLabel.font = font20;
    locationLabel.frame = headerFrame;
    locationLabel.text = @"Location";
    locationLabel.textColor = gray50;
    [locationView addSubview: locationLabel];
    UIImageView *locationImageView = [[UIImageView alloc] init];
    locationImageView.frame = imageFrame;
    locationImageView.image = [UIImage image: [UIImage imageNamed:
      @"location.png"] size: imageSize];
    [locationView addSubview: locationImageView];
    // city field
    TextFieldPadding *locationCityField = [[TextFieldPadding alloc] init];
    locationCityField.backgroundColor = [UIColor clearColor];
    locationCityField.font = font14;
    locationCityField.frame = CGRectMake(10, 40, (screen.size.width - 20), 40);
    locationCityField.layer.borderColor = [UIColor spadeGreen].CGColor;
    locationCityField.layer.borderWidth = 1;
    locationCityField.paddingX = 10;
    locationCityField.paddingY = 10;
    locationCityField.text = @"San Diego";
    locationCityField.textColor = gray50;
    locationCityField.userInteractionEnabled = NO;
    [locationView addSubview: locationCityField];

    // Phone view
    UIView *phoneView = [[UIView alloc] init];
    phoneView.backgroundColor = [UIColor clearColor];
    phoneView.frame = CGRectMake(0, (locationView.frame.origin.y +
      locationView.frame.size.height), screen.size.width, (40 + 40 + 10));
    [self addSubview: phoneView];
    UILabel *phoneLabel = [[UILabel alloc] init];
    phoneLabel.backgroundColor = [UIColor clearColor];
    phoneLabel.font = font20;
    phoneLabel.frame = headerFrame;
    phoneLabel.text = @"Contact number";
    phoneLabel.textColor = gray50;
    [phoneView addSubview: phoneLabel];
    UIImageView *phoneImageView = [[UIImageView alloc] init];
    phoneImageView.frame = imageFrame;
    phoneImageView.image = [UIImage image: [UIImage imageNamed:
      @"phone.png"] size: imageSize];
    [phoneView addSubview: phoneImageView];
    // phone field
    TextFieldPadding *phoneField = [[TextFieldPadding alloc] init];
    phoneField.backgroundColor = [UIColor clearColor];
    phoneField.font = font14;
    phoneField.frame = CGRectMake(10, 40, (screen.size.width - 20), 40);
    phoneField.layer.borderColor = [UIColor spadeGreen].CGColor;
    phoneField.layer.borderWidth = 1;
    phoneField.paddingX = 10;
    phoneField.paddingY = 10;
    phoneField.text = @"408-858-1234";
    phoneField.textColor = gray50;
    phoneField.userInteractionEnabled = NO;
    [phoneView addSubview: phoneField];

    // Info
    UILabel *info = [[UILabel alloc] init];
    info.backgroundColor = [UIColor clearColor];
    info.font = [UIFont fontWithName: @"HelveticaNeue" size: 15];
    info.frame = CGRectMake(10, (topView.frame.origin.y + 
      topView.frame.size.height + marginTop), (screen.size.width - 20), 40);
    info.numberOfLines = 0;
    info.text = @"Update your profile, then add your skills and passions so "
      @"that tutees can find you";
    info.textAlignment = NSTextAlignmentCenter;
    info.textColor = [UIColor whiteColor];
    [self addSubview: info];
  }
  return self;
}

@end
