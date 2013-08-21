//
//  Day.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/17/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "Day.h"

@implementation Day

@synthesize name;
@synthesize uid;
@synthesize value;

#pragma mark - Override NSObject

- (NSString *) description
{
  return [NSString stringWithFormat: @"%@: %i",
    [self nameTitle], self.value];
}

#pragma mark - Methods

- (NSString *) nameTitle
{
  return [self.name capitalizedString];
}

- (void) readFromDictionary: (NSDictionary *) dictionary
{
  self.name  = [dictionary objectForKey: @"name"];
  self.uid   = [[dictionary objectForKey: @"id"] integerValue];
  self.value = [[dictionary objectForKey: @"value"] integerValue];
}

@end
