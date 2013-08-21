//
//  AddReviewCell.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/26/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "AddReviewCell.h"
#import "UIColor+Extensions.h"

@implementation AddReviewCell

@synthesize addReviewButton;

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
    // Add review
    // label
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.font  = [UIFont fontWithName: @"HelveticaNeue" size: 14];
    label.text  = @"+ Add Review";
    label.textAlignment = NSTextAlignmentRight;
    label.textColor = [UIColor spadeGreenDark];
    CGSize textSize = [label.text sizeWithFont: label.font 
      constrainedToSize: CGSizeMake(screen.size.width - 20, 20)];
    label.frame = CGRectMake(0, 10, textSize.width, textSize.height);
    // button
    self.addReviewButton = [[UIButton alloc] init];
    self.addReviewButton.frame = CGRectMake(
      (screen.size.width - (10 + label.frame.size.width)), 0, 
        label.frame.size.width, 40);
    [self.addReviewButton addSubview: label];
    [self addSubview: self.addReviewButton];
  }
  return self;
}

@end
