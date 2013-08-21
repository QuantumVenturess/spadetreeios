//
//  SkillBoxButton.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/16/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "Interest.h"
#import "SkillBoxButton.h"
#import "UIColor+Extensions.h"

@implementation SkillBoxButton

@synthesize interest;
@synthesize nameLabel;

#pragma mark - Initializer

- (id) initWithInterest: (Interest *) interestObject
{
  self = [super init];
  if (self) {
    self.interest  = interestObject;
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.backgroundColor = [UIColor clearColor];
    self.nameLabel.font = [UIFont fontWithName: @"HelveticaNeue" size: 14];
    self.nameLabel.text = [self.interest nameTitle];
    self.nameLabel.textColor = [UIColor gray: 50];
    self.backgroundColor = [UIColor clearColor];
    [self addSubview: self.nameLabel];
  }
  return self;
}

@end
