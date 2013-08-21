//
//  City.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/10/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "City.h"
#import "State.h"
#import "StateStore.h"

@implementation City

@synthesize name;
@synthesize slug;
@synthesize state;
@synthesize uid;

#pragma mark - Override NSObject

- (NSString *) description
{
  return self.name;
}

#pragma mark - Methods

- (NSString *) nameTitle
{
  return [self.name capitalizedString];
}

- (void) readFromDictionary: (NSDictionary *) dictionary
{
  NSDictionary *stateDict = [dictionary objectForKey: @"state"];
  NSString *stateName = [stateDict objectForKey: @"name"];
  State *stateObject = [[StateStore sharedStore].states objectForKey: 
    stateName];
  if (!stateObject) {
    stateObject = [[State alloc] init];
    [stateObject readFromDictionary: stateDict];
  }
  self.name  = [dictionary objectForKey: @"name"];
  self.slug  = [dictionary objectForKey: @"slug"];
  self.state = stateObject;
  self.uid   = [[dictionary objectForKey: @"id"] integerValue];
  [stateObject addCity: self];
}

@end
