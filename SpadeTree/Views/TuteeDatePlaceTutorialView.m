//
//  TuteeDatePlaceTutorialView.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 8/7/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "TextFieldPadding.h"
#import "TuteeDatePlaceTutorialView.h"
#import "UIColor+Extensions.h"

@implementation TuteeDatePlaceTutorialView

@synthesize dateButton;
@synthesize addressTextField;

#pragma mark - Initializer

- (id) init
{
  self = [super init];
  if (self) {
    NSDate *date = [NSDate date];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
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
      (44 + 20 + 40 + 10 + 40 + 20 + 40 + 10 + 40 + 20));
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
    navTitle.frame = CGRectMake(((screen.size.width - 200) / 2.0), 0, 200, 44);
    navTitle.text = @"Set Date & Place";
    navTitle.textAlignment = NSTextAlignmentCenter;
    navTitle.textColor = [UIColor whiteColor];
    [navItem addSubview: navTitle];
    // choose
    UILabel *saveLabel = [[UILabel alloc] init];
    saveLabel.backgroundColor = [UIColor clearColor];
    saveLabel.font = [UIFont fontWithName: @"HelveticaNeue" size: 14];
    saveLabel.frame = CGRectMake((screen.size.width - (35 + 10)), 
      13, 35, 18);
    saveLabel.text = @"Save";
    saveLabel.textAlignment = NSTextAlignmentCenter;
    saveLabel.textColor = [UIColor whiteColor];
    [navItem addSubview: saveLabel];

    // Date
    UILabel *dateHeader = [[UILabel alloc] init];
    dateHeader.backgroundColor = [UIColor clearColor];
    dateHeader.font = [UIFont fontWithName: @"HelveticaNeue" size: 20];
    dateHeader.frame = CGRectMake(10, (navItem.frame.origin.y + 
      navItem.frame.size.height + 20), (screen.size.width - 20), 40);
    df.dateFormat = @"EEEE";
    dateHeader.text = [NSString stringWithFormat: 
      @"Choose a date on %@", [df stringFromDate: date]];
    dateHeader.textColor = [UIColor gray: 50];
    [topView addSubview: dateHeader];
    // button
    dateButton = [[UIButton alloc] init];
    dateButton.backgroundColor = [UIColor clearColor];
    dateButton.frame = CGRectMake(10,
      (dateHeader.frame.origin.y + dateHeader.frame.size.height + 10), 
        (screen.size.width - 20), 40);
    dateButton.layer.borderColor = [UIColor blackColor].CGColor;
    dateButton.layer.borderWidth = 1;
    [topView addSubview: dateButton];
    // label
    UILabel *dateLabel = [[UILabel alloc] init];
    dateLabel.backgroundColor = [UIColor clearColor];
    dateLabel.font = [UIFont fontWithName: @"HelveticaNeue" size: 15];
    dateLabel.frame = CGRectMake(10, 10, 
      (dateButton.frame.size.width - 20), 20);
    df.dateFormat = @"MMMM d, yyyy";
    dateLabel.text = [df stringFromDate: date];
    dateLabel.textColor = [UIColor gray: 50];
    [dateButton addSubview: dateLabel];

    // Place
    UILabel *placeHeader = [[UILabel alloc] init];
    placeHeader.backgroundColor = [UIColor clearColor];
    placeHeader.font = [UIFont fontWithName: @"HelveticaNeue" size: 20];
    placeHeader.frame = CGRectMake(10, 
      (dateButton.frame.origin.y + dateButton.frame.size.height + 20), 
        (screen.size.width - 20), 40);
    placeHeader.text = @"Pick a place to meet";
    placeHeader.textColor = [UIColor gray: 50];
    [topView addSubview: placeHeader];
    // address
    addressTextField = [[TextFieldPadding alloc] init];
    addressTextField.backgroundColor = [UIColor clearColor];
    addressTextField.font = [UIFont fontWithName: @"HelveticaNeue" size: 15];
    addressTextField.frame = CGRectMake(10, 
      (placeHeader.frame.origin.y + placeHeader.frame.size.height + 10),
        (screen.size.width - 20), 40);
    addressTextField.layer.borderColor = [UIColor blackColor].CGColor;
    addressTextField.layer.borderWidth = 1;
    addressTextField.paddingX = 10;
    addressTextField.paddingY = 10;
    addressTextField.text = @"1234 Learning Street";
    addressTextField.textColor = [UIColor gray: 50];
    addressTextField.userInteractionEnabled = NO;
    [topView addSubview: addressTextField];

    // Info
    UILabel *info = [[UILabel alloc] init];
    info.backgroundColor = [UIColor clearColor];
    info.font = [UIFont fontWithName: @"HelveticaNeue" size: 15];
    info.frame = CGRectMake(10, (topView.frame.origin.y + 
      topView.frame.size.height + marginTop), (screen.size.width - 20), 40);
    info.numberOfLines = 0;
    info.text = @"After sending your tutor a request, "
      @"set a date and place to start learning";
    info.textAlignment = NSTextAlignmentCenter;
    info.textColor = [UIColor whiteColor];
    [self addSubview: info];
  }
  return self;
}

@end
