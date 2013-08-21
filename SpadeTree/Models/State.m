//
//  State.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/10/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "City.h"
#import "State.h"
#import "StateStore.h"

@implementation State

@synthesize cities;
@synthesize name;
@synthesize slug;
@synthesize uid;

#pragma mark - Initializer

- (id) init
{
  self = [super init];
  if (self) {
    self.cities = [NSMutableDictionary dictionary];
  }
  return self;
}

#pragma mark - Methods

- (void) addCity: (City *) city
{
  [self.cities setObject: city forKey: city.name];
}

- (NSString *) nameTitle
{
  return [self.name capitalizedString];
}

- (void) readFromDictionary: (NSDictionary *) dictionary
{
  self.name = [dictionary objectForKey: @"name"];
  self.slug = [dictionary objectForKey: @"slug"];
  self.uid  = [[dictionary objectForKey: @"id"] integerValue];
  [[StateStore sharedStore] addState: self];
}

@end
