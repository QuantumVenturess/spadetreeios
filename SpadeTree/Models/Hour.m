//
//  Hour.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/17/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "Hour.h"

@implementation Hour

@synthesize uid;
@synthesize value;

#pragma mark - Override NSObject

- (NSString *) description
{
  return [NSString stringWithFormat: @"%i: %i", self.value, [self hourOfDay]];
}

#pragma mark - Methods

- (NSString *) amPm
{
  if (self.value < 12) {
    return @"am";
  }
  return @"pm";
}

- (NSString *) hourAndAmPm
{
  return [NSString stringWithFormat: @"%i %@", [self hourOfDay], [self amPm]];
}

- (int) hourOfDay
{
  if (self.value > 0) {
    if (self.value > 12) {
      return self.value - 12;
    }
    else {
      return self.value;
    }
  }
  return 12;
}

- (void) readFromDictionary: (NSDictionary *) dictionary
{
  self.uid   = [[dictionary objectForKey: @"id"] integerValue];
  self.value = [[dictionary objectForKey: @"value"] integerValue];
}

@end
