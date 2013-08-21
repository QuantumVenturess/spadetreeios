//
//  ChoiceListStore.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 8/1/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "AppDelegate.h"
#import "Choice.h"
#import "ChoiceListConnection.h"
#import "ChoiceListStore.h"

@implementation ChoiceListStore

@synthesize choices;
@synthesize viewController;

#pragma mark - Initializer

- (id) init
{
  self = [super init];
  if (self) {
    choices = [NSMutableArray array];
    [[NSNotificationCenter defaultCenter] addObserver: self
      selector: @selector(signOut) name: CurrentUserSignOut object: nil];
  }
  return self;
}

#pragma mark - Getters

- (NSMutableArray *) choices
{
  return [self choicesSortedByCreated];
}

#pragma mark - Methods

+ (ChoiceListStore *) sharedStore
{
  static ChoiceListStore *store = nil;
  if (!store) {
    store = [[ChoiceListStore alloc] init];
  }
  return store;
}

- (void) addChoice: (Choice *) choice
{
  NSPredicate *predicate = [NSPredicate predicateWithFormat: 
    @"%K == %i", @"uid", choice.uid];
  NSArray *array = [choices filteredArrayUsingPredicate: predicate];
  if (array.count > 0) {
    // Update choice
    [(Choice *) [array objectAtIndex: 0] updateFromChoice: choice];
  }
  else {
    // Add to choices
    [choices addObject: choice];
  }
}

- (Choice *) choiceForId: (int) choiceId
{
  NSPredicate *predicate = [NSPredicate predicateWithFormat: 
    @"%K == %i", @"uid", choiceId];
  NSArray *array = [choices filteredArrayUsingPredicate: predicate];
  if (array.count > 0) {
    return [array objectAtIndex: 0];
  }
  return nil;
}

- (NSMutableArray *) choicesSortedByCreated
{
  NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey: @"created"
    ascending: NO];
  return (NSMutableArray *) [choices sortedArrayUsingDescriptors:
    [NSArray arrayWithObject: sort]];
}

- (void) fetchPage: (int) page completion: (void (^) (NSError *error)) block
{
  ChoiceListConnection *connection =
    [[ChoiceListConnection alloc] initWithPage: page];
  connection.completionBlock = block;
  connection.viewController  = self.viewController;
  [connection start];
}

- (void) readFromDictionary: (NSDictionary *) dictionary
{
  for (NSDictionary *dict in [dictionary objectForKey: @"choices"]) {
    Choice *choice = [[Choice alloc] init];
    [choice readFromDictionary: dict];
  }
}

- (void) signOut
{
  [choices removeAllObjects];
}

@end
