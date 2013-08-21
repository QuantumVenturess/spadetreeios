//
//  HourStore.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/19/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "Hour.h"
#import "HourStore.h"

@implementation HourStore

@synthesize hours;

#pragma mark - Initializer

- (id) init
{
  self = [super init];
  if (self) {
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 24; i++) {
      Hour *hour = [[Hour alloc] init];
      hour.value = i;
      [array addObject: hour];
    }
    self.hours = array;
  }
  return self;
}

#pragma mark - Methods

+ (HourStore *) sharedStore
{
  static HourStore *store = nil;
  if (!store) {
    store = [[HourStore alloc] init];
  }
  return store;
}

- (Hour *) hourForValue: (int) value
{
  NSPredicate *predicate = [NSPredicate predicateWithFormat: 
    @"%K == %i", @"value", value];
  NSArray *array = [self.hours filteredArrayUsingPredicate: predicate];
  if (array.count > 0) {
    return [array objectAtIndex: 0];
  }
  return nil;
}

@end
