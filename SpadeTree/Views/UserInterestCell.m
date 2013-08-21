//
//  UserInterestCell.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/12/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "Interest.h"
#import "InterestDetailViewController.h"
#import "UIColor+Extensions.h"
#import "UserInterestCell.h"

@implementation UserInterestCell

@synthesize navigationController;

#pragma mark - Initializer

- (id) initWithStyle: (UITableViewCellStyle) style
reuseIdentifier: (NSString *) reuseIdentifier
{
  self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
  if (self) {
    UIFont *font = [UIFont fontWithName: @"HelveticaNeue" size: 13];
    CGRect screen = [[UIScreen mainScreen] bounds];
    // UITableViewCell properties
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Main view
    mainView = [[UIView alloc] init];
    mainView.backgroundColor = [UIColor clearColor];
    mainView.frame = CGRectMake(0, 0, screen.size.width, 40);
    [self.contentView addSubview: mainView];
    // Title label
    // nameLabel = [[UILabel alloc] init];
    // nameLabel.backgroundColor = [UIColor clearColor];
    // nameLabel.font = [UIFont fontWithName: @"HelveticaNeue" size: 14];
    // nameLabel.frame = CGRectMake((10 + 18 + 10), 10, 
    //   (mainView.frame.size.width - (10 + 18 + 10 + 10)), 20);
    // nameLabel.textColor = [UIColor spadeGreenDark];
    // [mainView addSubview: nameLabel];
    float buttonWidth     = screen.size.width / 2.0;
    float nameLabelWidth  = buttonWidth - 40;
    CGRect nameLabelFrame = CGRectMake(20, 10, nameLabelWidth, 20);
    // Interest 1
    nameLabel1 = [[UILabel alloc] init];
    nameLabel1.backgroundColor = [UIColor clearColor];
    nameLabel1.font = font;
    nameLabel1.frame = nameLabelFrame;
    nameLabel1.textColor = [UIColor spadeGreenDark];
    button1 = [[UIButton alloc] init];
    button1.backgroundColor = [UIColor clearColor];
    button1.frame = CGRectMake(0, 0, buttonWidth, 40);
    button1.tag = 0;
    [button1 addSubview: nameLabel1];
    [button1 addTarget: self action: @selector(showInterest:)
      forControlEvents: UIControlEventTouchUpInside];
    [self addSubview: button1];
    // Interest 2
    nameLabel2 = [[UILabel alloc] init];
    nameLabel2.backgroundColor = [UIColor clearColor];
    nameLabel2.font = font;
    nameLabel2.frame = nameLabelFrame;
    nameLabel2.textColor = [UIColor spadeGreenDark];
    button2 = [[UIButton alloc] init];
    button2.backgroundColor = [UIColor clearColor];
    button2.frame = CGRectMake(buttonWidth, 0, buttonWidth, 40);
    button2.tag = 1;
    [button2 addSubview: nameLabel2];
    [button2 addTarget: self action: @selector(showInterest:)
      forControlEvents: UIControlEventTouchUpInside];
    [self addSubview: button2];

    // UITapGestureRecognizer *tapRecognizer =
    //   [[UITapGestureRecognizer alloc] initWithTarget: self
    //     action: @selector(selectCell)];
    // [self addGestureRecognizer: tapRecognizer];
  }
  return self;
}

#pragma mark - Methods

- (void) loadInterestData: (Interest *) interestObject
{
  // interest = interestObject;
  // nameLabel.text = [interest nameTitle];
}

- (void) loadInterests: (NSArray *) interests
{
  for (Interest *interestObject in interests) {
    int index = [interests indexOfObject: interestObject];
    if (index == 0) {
      interest1       = interestObject;
      nameLabel1.text = [interest1 nameTitle];
    }
    else if (index == 1) {
      interest2       = interestObject;
      nameLabel2.text = [interest2 nameTitle];
    }
  }
}

- (void) selectCell
{
  // mainView.backgroundColor = [UIColor spadeGreen];
  // nameLabel.textColor = [UIColor whiteColor];
}

- (void) showInterest: (id) sender
{
  UIButton *button = (UIButton *) sender;
  Interest *interest;
  if (button.tag == 0) {
    interest                = interest1;
    button1.backgroundColor = [UIColor spadeGreen];
    nameLabel1.textColor    = [UIColor whiteColor];
  }
  else if (button.tag == 1) {
    interest                = interest2;
    nameLabel2.textColor    = [UIColor whiteColor];
    button2.backgroundColor = [UIColor spadeGreen];
  }
  if (interest) {
    [self.navigationController pushViewController:
      [[InterestDetailViewController alloc] initWithInterest: interest]
        animated: YES];
  }
}

- (void) unselectCell
{
  button1.backgroundColor = [UIColor clearColor];
  nameLabel1.textColor    = [UIColor spadeGreenDark];
  button2.backgroundColor = [UIColor clearColor];
  nameLabel2.textColor    = [UIColor spadeGreenDark];
}

@end
