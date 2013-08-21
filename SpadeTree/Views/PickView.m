//
//  PickView.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/19/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "AppDelegate.h"
#import "PickConnection.h"
#import "PickView.h"
#import "SpadeTreeTabBarController.h"
#import "UIColor+Extensions.h"
#import "UIImage+Resize.h"
#import "User.h"

@implementation PickView

#pragma mark - Initializer

- (id) init
{
  self = [super init];
  if (self) {
    UIFont *font14 = [UIFont fontWithName: @"HelveticaNeue" size: 14];
    UIFont *font18 = [UIFont fontWithName: @"HelveticaNeue" size: 18];
    UIColor *gray50 = [UIColor gray: 50];
    CGRect screen = [[UIScreen mainScreen] bounds];
    // Main
    self.alpha = 0;
    self.backgroundColor = [UIColor colorWithRed: 0 green: 0 blue: 0
      alpha: 0.6];
    self.frame = screen;
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = [UIColor colorWithRed: 255 green: 255 blue: 255
      alpha: 1];
    backView.frame = screen;
    [self addSubview: backView];
    // Header label
    UILabel *headerLabel = [[UILabel alloc] init];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.font = font18;
    headerLabel.frame = CGRectMake(0, 10, backView.frame.size.width, 30);
    headerLabel.text = @"I am a...";
    headerLabel.textAlignment = NSTextAlignmentCenter;
    headerLabel.textColor = gray50;
    [backView addSubview: headerLabel];
    int topMargin = screen.size.height * 0.07;
    // Tutee
    UIView *tuteeView = [[UIView alloc] init];
    tuteeView.frame = CGRectMake(0, (30 + topMargin), 
      backView.frame.size.width, 170);
    [backView addSubview: tuteeView];
    UILabel *tuteeLabel = [[UILabel alloc] init];
    tuteeLabel.backgroundColor = [UIColor clearColor];
    tuteeLabel.font = font18;
    tuteeLabel.frame = CGRectMake(0, 0, backView.frame.size.width, 30);
    tuteeLabel.text = @"Tutee";
    tuteeLabel.textAlignment = NSTextAlignmentCenter;
    tuteeLabel.textColor = [UIColor spadeGreenDark];
    [tuteeView addSubview: tuteeLabel];
    UIButton *tuteeButton = [[UIButton alloc] init];
    tuteeButton.backgroundColor = [UIColor clearColor];
    tuteeButton.frame = CGRectMake(((backView.frame.size.width - 100) / 2.0), 
      (30 + 10), 100, 100);
    [tuteeButton addTarget: self action: @selector(pickTutee)
      forControlEvents: UIControlEventTouchUpInside];
    [tuteeView addSubview: tuteeButton];
    UIImageView *tuteeImageView = [[UIImageView alloc] init];
    tuteeImageView.frame = CGRectMake(0, 0, 100, 100);
    tuteeImageView.image = [UIImage image: [UIImage imageNamed: @"tutees.png"]
      size: CGSizeMake(100, 100)];
    [tuteeButton addSubview: tuteeImageView];
    UILabel *tuteeInfoLabel = [[UILabel alloc] init];
    tuteeInfoLabel.backgroundColor = [UIColor clearColor];
    tuteeInfoLabel.font = font14;
    tuteeInfoLabel.frame = CGRectMake(0, (30 + 10 + 100 + 10), 
      backView.frame.size.width, 40);
    tuteeInfoLabel.text = @"if I want to know more and learn new skills";
    tuteeInfoLabel.textAlignment = NSTextAlignmentCenter;
    tuteeInfoLabel.textColor = gray50;
    [tuteeView addSubview: tuteeInfoLabel];
    // Tutor
    UIView *tutorView = [[UIView alloc] init];
    tutorView.frame = CGRectMake(0, (30 + topMargin + 170 + 30), 
      backView.frame.size.width, 170);
    [backView addSubview: tutorView];
    UILabel *tutorLabel = [[UILabel alloc] init];
    tutorLabel.backgroundColor = [UIColor clearColor];
    tutorLabel.font = font18;
    tutorLabel.frame = CGRectMake(0, 0, backView.frame.size.width, 30);
    tutorLabel.text = @"Tutor";
    tutorLabel.textAlignment = NSTextAlignmentCenter;
    tutorLabel.textColor = [UIColor spadeGreenDark];
    [tutorView addSubview: tutorLabel];
    UIButton *tutorButton = [[UIButton alloc] init];
    tutorButton.backgroundColor = [UIColor clearColor];
    tutorButton.frame = CGRectMake(((backView.frame.size.width - 100) / 2.0), 
      (30 + 10), 100, 100);
    [tutorButton addTarget: self action: @selector(pickTutor)
      forControlEvents: UIControlEventTouchUpInside];
    [tutorView addSubview: tutorButton];
    UIImageView *tutorImageView = [[UIImageView alloc] init];
    tutorImageView.frame = CGRectMake(0, 0, 100, 100);
    tutorImageView.image = [UIImage image: [UIImage imageNamed: @"tutors.png"]
      size: CGSizeMake(100, 100)];
    [tutorButton addSubview: tutorImageView];
    UILabel *tutorInfoLabel = [[UILabel alloc] init];
    tutorInfoLabel.backgroundColor = [UIColor clearColor];
    tutorInfoLabel.font = font14;
    tutorInfoLabel.frame = CGRectMake(0, (30 + 10 + 100 + 10), 
      backView.frame.size.width, 20);
    tutorInfoLabel.text = @"if I am passionate and want to teach my skills";
    tutorInfoLabel.textAlignment = NSTextAlignmentCenter;
    tutorInfoLabel.textColor = gray50;
    [tutorView addSubview: tutorInfoLabel];
  }
  return self;
}

#pragma mark - Methods

- (void) hidePickView
{
  void (^animations) (void) = ^(void) {
    self.alpha = 0;
  };
  void (^completion) (BOOL finished) = ^(BOOL finished) {
    self.hidden = YES;
    // If user has not read tutorial, show it
    AppDelegate *appDelegate = (AppDelegate *)
      [UIApplication sharedApplication].delegate;
    if (![User currentUser].readTutorial) {
      [appDelegate.tabBarController showTutorial];
    }
  };
  [UIView animateWithDuration: 0.1 delay: 0
    options: UIViewAnimationOptionCurveLinear animations: animations
      completion: completion];
  [[[PickConnection alloc] init] start];
}

- (void) pickTutee
{
  [User currentUser].tutee = YES;
  [User currentUser].tutor = NO;
  [self hidePickView];
}

- (void) pickTutor
{
  [User currentUser].tutee = NO;
  [User currentUser].tutor = YES;
  [[User currentUser] subscribeToChoicesChannel];
  [self hidePickView];
}

@end
