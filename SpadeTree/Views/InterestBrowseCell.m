//
//  InterestBrowseCell.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/10/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "Interest.h"
#import "InterestBrowseCell.h"
#import "UIColor+Extensions.h"

@implementation InterestBrowseCell

#pragma mark - Initializer

- (id) initWithStyle: (UITableViewCellStyle) style
reuseIdentifier: (NSString *) reuseIdentifier
{
  self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
    if (self) {
    CGRect screen = [[UIScreen mainScreen] bounds];
    // UITableViewCell properties
    UIView *bgView = [[UIView alloc] init];
    bgView.frame = screen;
    bgView.backgroundColor = [UIColor spadeGreen];
    self.selectedBackgroundView = bgView;
    self.selectionStyle = UITableViewCellSelectionStyleGray;
    // Main view
    UIView *mainView = [[UIView alloc] init];
    mainView.backgroundColor = [UIColor whiteColor];
    mainView.frame = CGRectMake(10, 0, (screen.size.width - 20), 60);
    [self.contentView addSubview: mainView];
    // Title label
    titleLabel = [[UILabel alloc] init];
    titleLabel.backgroundColor = [UIColor whiteColor];
    titleLabel.font = [UIFont fontWithName: @"HelveticaNeue" size: 15];
    titleLabel.frame = CGRectMake(10, 10, (mainView.frame.size.width - 20), 
      40);
    titleLabel.textColor = [UIColor gray: 50];
    [mainView addSubview: titleLabel];
  }
  return self;
}

#pragma mark - Methods

- (void) loadInterestData: (Interest *) interestObject
{
  interest = interestObject;
  titleLabel.text = [interest nameTitle];
}

@end
