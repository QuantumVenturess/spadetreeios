//
//  EditInterestSearchResult.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/19/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "EditInterestSearchResult.h"
#import "Interest.h"
#import "UIColor+Extensions.h"

@implementation EditInterestSearchResult

@synthesize nameLabel;

#pragma mark - Initializer

- (id) init
{
  self = [super init];
  if (self) {
    CGRect screen = [[UIScreen mainScreen] bounds];
    self.backgroundColor = [UIColor clearColor];
    nameLabel = [[UILabel alloc] init];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.font = [UIFont fontWithName: @"HelveticaNeue" size: 14];
    nameLabel.frame = CGRectMake(33, 0, (screen.size.width - 43), 40);
    nameLabel.textColor = [UIColor whiteColor];
    [self addSubview: nameLabel];
    [self setBackgroundImage: [UIImage imageNamed: @"spade_green.png"]
      forState: UIControlStateHighlighted];
  }
  return self;
}

@end
