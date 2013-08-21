//
//  HourBoxButton.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/17/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "Hour.h"
#import "HourFree.h"
#import "HourBoxButton.h"
#import "UIColor+Extensions.h"

@implementation HourBoxButton

@synthesize hour;
@synthesize hourFree;
@synthesize nameLabel;
@synthesize selected;

#pragma mark - Initializer

- (id) initWithHour: (Hour *) hourObject
{
  self = [super init];
  if (self) {
    self.hour = hourObject;
    self.backgroundColor = [UIColor whiteColor];
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.backgroundColor = [UIColor clearColor];
    self.nameLabel.font = [UIFont fontWithName: @"HelveticaNeue" size: 14];
    self.nameLabel.text = [NSString stringWithFormat: @"%i", 
      [self.hour hourOfDay]];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel.textColor = [UIColor gray: 50];
    [self addSubview: self.nameLabel];
  }
  return self;
}

- (id) initWithHourFree: (HourFree *) hourFreeObject
{
  self = [super init];
  if (self) {
    self.hourFree = hourFreeObject;
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.backgroundColor = [UIColor clearColor];
    self.nameLabel.font = [UIFont fontWithName: @"HelveticaNeue" size: 14];
    self.nameLabel.text = [NSString stringWithFormat: @"%i", 
      [self.hourFree.hour hourOfDay]];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel.textColor = [UIColor gray: 50];
    self.backgroundColor = [UIColor clearColor];
    [self addSubview: self.nameLabel];
  }
  return self;
}

#pragma mark - Methods

- (void) select
{
  self.backgroundColor = [UIColor spadeGreen];
  self.nameLabel.textColor = [UIColor whiteColor];
  self.selected = YES;
}

- (void) unselect
{
  self.backgroundColor = [UIColor whiteColor];
  self.nameLabel.textColor = [UIColor gray: 50];
  self.selected = NO;
}

@end
