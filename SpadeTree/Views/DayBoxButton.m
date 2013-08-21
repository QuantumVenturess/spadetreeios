//
//  DayBoxButton.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/17/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "Day.h"
#import "DayBoxButton.h"
#import "DayFree.h"
#import "UIColor+Extensions.h"

@implementation DayBoxButton

@synthesize day;
@synthesize dayFree;
@synthesize nameLabel;
@synthesize selected;

#pragma mark - Initializer

- (id) initWithDay: (Day *) dayObject
{
  self = [super init];
  if (self) {
    self.day = dayObject;
    self.backgroundColor = [UIColor whiteColor];
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.backgroundColor = [UIColor clearColor];
    self.nameLabel.font = [UIFont fontWithName: @"HelveticaNeue" size: 14];
    self.nameLabel.text = [self.day nameTitle];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel.textColor = [UIColor gray: 50];
    [self addSubview: self.nameLabel];
  }
  return self;
}

- (id) initWithDayFree: (DayFree *) dayFreeObject
{
  self = [super init];
  if (self) {
    self.dayFree = dayFreeObject;
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.backgroundColor = [UIColor clearColor];
    self.nameLabel.font = [UIFont fontWithName: @"HelveticaNeue" size: 14];
    self.nameLabel.text = [self.dayFree.day nameTitle];
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
