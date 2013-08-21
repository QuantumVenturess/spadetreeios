//
//  DayStore.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/19/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "Day.h"
#import "DayStore.h"

@implementation DayStore

@synthesize days;

#pragma mark - Initializer

- (id) init
{
  self = [super init];
  if (self) {
    Day *sunday = [[Day alloc] init];
    sunday.name = @"sunday";
    sunday.value = 0;
    Day *monday = [[Day alloc] init];
    monday.name = @"monday";
    monday.value = 1;
    Day *tuesday = [[Day alloc] init];
    tuesday.name = @"tuesday";
    tuesday.value = 2;
    Day *wednesday = [[Day alloc] init];
    wednesday.name = @"wednesday";
    wednesday.value = 3;
    Day *thursday = [[Day alloc] init];
    thursday.name = @"thursday";
    thursday.value = 4;
    Day *friday = [[Day alloc] init];
    friday.name = @"friday";
    friday.value = 5;
    Day *saturday = [[Day alloc] init];
    saturday.name = @"saturday";
    saturday.value = 6;
    self.days = @[sunday, monday, tuesday, wednesday, thursday, friday, 
      saturday];
  }
  return self;
}

#pragma mark - Methods

+ (DayStore *) sharedStore
{
  static DayStore *store = nil;
  if (!store) {
    store = [[DayStore alloc] init];
  }
  return store;
}

- (Day *) dayForValue: (int) value
{
  NSPredicate *predicate = [NSPredicate predicateWithFormat:
    @"%K == %i", @"value", value];
  NSArray *array = [self.days filteredArrayUsingPredicate: predicate];
  if (array.count > 0) {
    return [array objectAtIndex: 0];
  }
  return nil;
}

@end
