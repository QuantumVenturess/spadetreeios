//
//  InterestGroup.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/10/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "InterestGroup.h"

@implementation InterestGroup

@synthesize interests;
@synthesize letter;

#pragma mark - Initializer

- (id) init
{
  self = [super init];
  if (self) {
    self.interests = [NSMutableArray array];
  }
  return self;
}

#pragma mark - Override

- (NSString *) description
{
  return [NSString stringWithFormat: @"%@: %i", [self.letter uppercaseString], 
    self.interests.count];
}

#pragma mark - Getters

- (NSMutableArray *) interests
{
  return [self interestsSortedByName];
}

#pragma mark - Methods

- (NSMutableArray *) interestsSortedByName
{
  NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey: @"name"
    ascending: YES];
  return (NSMutableArray *) [interests sortedArrayUsingDescriptors: 
    [NSArray arrayWithObject: sort]];
}

@end
