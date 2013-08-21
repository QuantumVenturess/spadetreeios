//
//  TutorRequestTutorialView.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 8/7/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "TutorRequestTutorialView.h"
#import "UIColor+Extensions.h"
#import "UIImage+Resize.h"

@implementation TutorRequestTutorialView

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
      (44 + 20 + 40 + 20 + 40 + 30 + 40 + 30 + 30 + 10));
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
    navTitle.text = @"Designing";
    navTitle.textAlignment = NSTextAlignmentCenter;
    navTitle.textColor = [UIColor whiteColor];
    [navItem addSubview: navTitle];
    // add note
    UIImage *addNoteImage = [UIImage image: 
      [UIImage imageNamed: @"add_note.png"] size: CGSizeMake(24, 24)];
    UIImageView *addNoteImageView = [[UIImageView alloc] init];
    addNoteImageView.frame = CGRectMake((screen.size.width - (24 + 10)), 
      10, 24, 24);
    addNoteImageView.image = addNoteImage;
    [navItem addSubview: addNoteImageView];

    UIFont *font15 = [UIFont fontWithName: @"HelveticaNeue" size: 15];
    UIFont *font20 = [UIFont fontWithName: @"HelveticaNeue" size: 20];
    // Accept button
    UILabel *acceptButtonLabel = [[UILabel alloc] init];
    acceptButtonLabel.backgroundColor = [UIColor clearColor];
    acceptButtonLabel.font = font15;
    acceptButtonLabel.frame = CGRectMake(0, 0, (screen.size.width / 3.0), 40);
    acceptButtonLabel.textAlignment = NSTextAlignmentCenter;
    acceptButtonLabel.text = @"Accept";
    acceptButtonLabel.textColor = [UIColor whiteColor];
    UIButton *acceptButton = [[UIButton alloc] init];
    acceptButton.backgroundColor = [UIColor spadeGreen];
    acceptButton.frame = CGRectMake(10, (navItem.frame.origin.y + 
      navItem.frame.size.height + 20), (screen.size.width / 3.0), 40);
    [acceptButton addSubview: acceptButtonLabel];
    [self addSubview: acceptButton];

    NSDate *date = [NSDate date];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    // Day and hour view
    UIView *dayHourView = [[UIView alloc] init];
    dayHourView.backgroundColor = [UIColor clearColor];
    dayHourView.frame = CGRectMake(0, (acceptButton.frame.origin.y + 
      acceptButton.frame.size.height + 20), screen.size.width, 70);
    [self addSubview: dayHourView];
    // image view
    UIImageView *dayHourImageView = [[UIImageView alloc] init];
    dayHourImageView.frame = CGRectMake(10, 11, 18, 18);
    dayHourImageView.image = [UIImage image: 
      [UIImage imageNamed: @"days_user.png"] size: CGSizeMake(18, 18)];
    [dayHourView addSubview: dayHourImageView];
    // label
    UILabel *dayHourLabel = [[UILabel alloc] init];
    dayHourLabel.backgroundColor = [UIColor clearColor];
    dayHourLabel.font = font20;
    dayHourLabel.frame = CGRectMake((10 + 18 + 10), 0, 
      (screen.size.width - (10 + 18 + 10 + 10)), 40);
    df.dateFormat = @"EEEE";
    NSString *weekday = [df stringFromDate: date];
    df.dateFormat = @"h a";
    NSString *dayTime = [[df stringFromDate: date] lowercaseString];
    dayHourLabel.text = [NSString stringWithFormat: @"%@ at %@",
      weekday, dayTime];
    dayHourLabel.textColor = [UIColor gray: 50];
    [dayHourView addSubview: dayHourLabel];
    // Date label
    UILabel *dateLabel = [[UILabel alloc] init];
    dateLabel.backgroundColor = [UIColor clearColor];
    dateLabel.font = font15;
    dateLabel.frame = CGRectMake((10 + 18 + 10), 40, 
      (screen.size.width - (10 + 18 + 10 + 10)), 30);
    df.dateFormat = @"MMMM d, yyyy";
    dateLabel.text = [df stringFromDate: date];
    dateLabel.textColor = [UIColor gray: 50];
    [dayHourView addSubview: dateLabel];

    // Location view
    UIView *locationView = [[UIView alloc] init];
    locationView.backgroundColor = [UIColor clearColor];
    locationView.frame = CGRectMake(0, (dayHourView.frame.origin.y + 
      dayHourView.frame.size.height), screen.size.width, 100);
    [self addSubview: locationView];
    // image view
    UIImageView *locationImageView = [[UIImageView alloc] init];
    locationImageView.frame = CGRectMake(10, 11, 18, 18);
    locationImageView.image = [UIImage image: 
      [UIImage imageNamed: @"location.png"] size: CGSizeMake(18, 18)];
    [locationView addSubview: locationImageView];
    // label
    UILabel *locationLabel = [[UILabel alloc] init];
    locationLabel.backgroundColor = [UIColor clearColor];
    locationLabel.font = font20;
    locationLabel.frame = CGRectMake((10 + 18 + 10), 0, 
      (screen.size.width - (10 + 18 + 10 + 10)), 40);
    locationLabel.text = @"Place to meet";
    locationLabel.textColor = [UIColor gray: 50];
    [locationView addSubview: locationLabel];
    // address label
    UILabel *addressLabel = [[UILabel alloc] init];
    addressLabel.backgroundColor = [UIColor clearColor];
    addressLabel.font = font15;
    addressLabel.frame = CGRectMake((10 + 18 + 10), 40, 
      (screen.size.width - (10 + 18 + 10 + 10)), 30);
    addressLabel.text = @"777 Knowledge Way";
    addressLabel.textColor = [UIColor gray: 50];
    [locationView addSubview: addressLabel];
    // city state label
    UILabel *cityStateLabel = [[UILabel alloc] init];
    cityStateLabel.backgroundColor = [UIColor clearColor];
    cityStateLabel.font = font15;
    cityStateLabel.frame = CGRectMake(addressLabel.frame.origin.x,
      (addressLabel.frame.origin.y + addressLabel.frame.size.height),
        addressLabel.frame.size.width, addressLabel.frame.size.height);
    cityStateLabel.text = @"Berkeley, California";
    cityStateLabel.textColor = [UIColor gray: 50];
    [locationView addSubview: cityStateLabel];

    // Info
    UILabel *info = [[UILabel alloc] init];
    info.backgroundColor = [UIColor clearColor];
    info.font = [UIFont fontWithName: @"HelveticaNeue" size: 15];
    info.frame = CGRectMake(10, (topView.frame.origin.y + 
      topView.frame.size.height + marginTop), (screen.size.width - 20), 40);
    info.numberOfLines = 0;
    info.text = @"Accept requests from tutees and begin teaching your skills";
    info.textAlignment = NSTextAlignmentCenter;
    info.textColor = [UIColor whiteColor];
    [self addSubview: info];
  }
  return self;
}

@end
