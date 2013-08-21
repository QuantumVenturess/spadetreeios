//
//  AllInterestStore.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/12/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "AllInterestStore.h"
#import "AppDelegate.h"
#import "Interest.h"

@implementation AllInterestStore

@synthesize interests;

#pragma mark - Initializer

- (id) init
{
  self = [super init];
  if (self) {
    self.interests = [NSMutableDictionary dictionary];
    [[NSNotificationCenter defaultCenter] addObserver: self
      selector: @selector(signOut) name: CurrentUserSignOut object: nil];
  }
  return self;
}

#pragma mark - Methods

+ (AllInterestStore *) sharedStore
{
  static AllInterestStore *store = nil;
  if (!store) {
    store = [[AllInterestStore alloc] init];
  }
  return store;
}

- (NSArray *) allInterests
{
  NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey: @"name"
    ascending: YES];
  return [self.interests.allValues sortedArrayUsingDescriptors:
    [NSArray arrayWithObject: sort]];
}

- (void) addInterest: (Interest *) interest
{
  Interest *i = [self.interests objectForKey: interest.name];
  if (!i) {
    [self.interests setObject: interest forKey: interest.name];
  }
}

- (Interest *) interestForName: (NSString *) string
{
  NSPredicate *predicate = [NSPredicate predicateWithFormat:
    @"%K == %@", @"name", [string lowercaseString]];
  NSArray *array = [self.interests.allValues filteredArrayUsingPredicate: 
    predicate];
  if (array.count > 0) {
    return [array objectAtIndex: 0];
  }
  return nil;
}

- (void) readFromDictionary: (NSDictionary *) dictionary
{
  NSArray *array = [dictionary objectForKey: @"interests"];
  for (NSDictionary *dict in array) {
    NSString *name = [dict objectForKey: @"name"];
    Interest *interest = [self.interests objectForKey: name];
    if (!interest) {
      interest = [[Interest alloc] init];
      [interest readFromDictionary: dict];
    }
  }
}

- (void) signOut
{
  [self.interests removeAllObjects];
}

@end
