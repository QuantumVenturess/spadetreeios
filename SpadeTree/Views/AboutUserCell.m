//
//  AboutUserCell.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/12/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "AboutUserCell.h"
#import "UIColor+Extensions.h"
#import "User.h"

@implementation AboutUserCell

@synthesize aboutLabel;

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
    UIView *mainView = [[UIView alloc] init];
    mainView.backgroundColor = [UIColor clearColor];
    mainView.frame = CGRectMake(0, 0, screen.size.width, 40);
    [self.contentView addSubview: mainView];
    // Content
    self.aboutLabel = [[UILabel alloc] init];
    self.aboutLabel.backgroundColor = [UIColor clearColor];
    self.aboutLabel.font = [UIFont fontWithName: @"HelveticaNeue" size: 14];
    self.aboutLabel.frame = CGRectMake(10, 10, (screen.size.width - 20), 20);
    self.aboutLabel.numberOfLines = 0;
    self.aboutLabel.textColor = [UIColor gray: 50];
    [mainView addSubview: self.aboutLabel];
  }
  return self;
}

#pragma mark - Methods

- (void) loadUserData: (User *) userObject
{
  self.aboutLabel.text = userObject.about;
  CGSize maxSize = CGSizeMake(self.aboutLabel.frame.size.width, 1000);
  CGSize textSize = [self.aboutLabel.text sizeWithFont: self.aboutLabel.font
    constrainedToSize: maxSize];
  CGRect frame = self.aboutLabel.frame;
  frame.size.height = textSize.height;
  self.aboutLabel.frame = frame;
}

@end
