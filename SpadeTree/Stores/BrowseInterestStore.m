//
//  BrowseInterestStore.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/9/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "AppDelegate.h"
#import "BrowseInterestStore.h"
#import "Interest.h"
#import "InterestBrowseConnection.h"
#import "InterestGroup.h"

@implementation BrowseInterestStore

@synthesize interests;
@synthesize viewController;

#pragma mark - Initializer

- (id) init
{
  self = [super init];
  if (self) {
    self.interests = [NSMutableArray array];
    [[NSNotificationCenter defaultCenter] addObserver: self
      selector: @selector(signOut) name: CurrentUserSignOut object: nil];
  }
  return self;
}

#pragma mark - Methods

+ (BrowseInterestStore *) sharedStore
{
  static BrowseInterestStore *store = nil;
  if (!store) {
    store = [[BrowseInterestStore alloc] init];
  }
  return store;
}

- (void) addInterest: (Interest *) interest
{
  NSPredicate *predicate = [NSPredicate predicateWithFormat: 
    @"%K == %@", @"name", interest.name];
  NSArray *array = [self.interests filteredArrayUsingPredicate: predicate];
  if (array.count == 0) {
    [self.interests addObject: interest];
  }
}

- (void) fetchPage: (int) page completion: (void (^) (NSError *error)) block
{
  InterestBrowseConnection *connection = 
    [[InterestBrowseConnection alloc] initWithPage: page];
  connection.completionBlock = block;
  connection.viewController  = self.viewController;
  [connection start];
}

- (NSArray *) group
{
  NSMutableDictionary *groupByLetter = [NSMutableDictionary dictionary];
  for (Interest *interest in self.interests) {
    NSString *letter = [interest.name substringWithRange: NSMakeRange(0, 1)];
    NSMutableArray *array = [groupByLetter objectForKey: letter];
    if (!array) {
      array = [NSMutableArray array];
      [groupByLetter setObject: array forKey: letter];
    }
    [array addObject: interest];
  }
  NSMutableArray *interestGroups = [NSMutableArray array];
  for (int i = 0; i < groupByLetter.count; i++) {
    InterestGroup *interestGroup = [[InterestGroup alloc] init];
    interestGroup.interests = [groupByLetter.allValues objectAtIndex: i];
    interestGroup.letter    = [groupByLetter.allKeys objectAtIndex: i];
    [interestGroups addObject: interestGroup];
  }
  NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey: @"letter"
    ascending: YES];
  return [interestGroups sortedArrayUsingDescriptors: 
    [NSArray arrayWithObject: sort]];
}

- (void) readFromDictionary: (NSDictionary *) dictionary
{
  NSArray *array = [dictionary objectForKey: @"interests"];
  for (NSDictionary *dict in array) {
    Interest *interest = [[Interest alloc] init];
    [interest readFromDictionary: dict];
    [self addInterest: interest];
  }
}

- (void) signOut
{
  [self.interests removeAllObjects];
}

@end
