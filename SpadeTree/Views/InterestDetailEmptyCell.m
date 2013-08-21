//
//  InterestDetailEmptyCell.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/11/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "InterestDetailEmptyCell.h"
#import "UIColor+Extensions.h"

@implementation InterestDetailEmptyCell

@synthesize label;

#pragma mark - Initializer

- (id) initWithStyle: (UITableViewCellStyle) style
reuseIdentifier: (NSString *) reuseIdentifier
{
  self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
  if (self) {
    CGRect screen = [[UIScreen mainScreen] bounds];
    // UITableViewCell properties
    self.selectedBackgroundView = [[UIView alloc] init];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Main view
    UIView *mainView = [[UIView alloc] init];
    mainView.backgroundColor = [UIColor whiteColor];
    mainView.frame = CGRectMake(0, 0, screen.size.width, 60);
    [self.contentView addSubview: mainView];
    // Label
    self.label = [[UILabel alloc] init];
    self.label.backgroundColor = [UIColor clearColor];
    self.label.font = [UIFont fontWithName: @"HelveticaNeue" size: 14];
    self.label.frame = CGRectMake((10 + 40 + 10), 10, 
      (screen.size.width - (10 + 40 + 10 + 10)), 40);
    self.label.textColor = [UIColor gray: 150];
    [mainView addSubview: self.label];
  }
  return self;
}

@end
