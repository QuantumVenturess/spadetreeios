//
//  DayFree.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/17/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "Day.h"
#import "DayFree.h"

@implementation DayFree

@synthesize day;
@synthesize uid;
// iOS
@synthesize value;

#pragma mark - Methods

- (void) readFromDictionary: (NSDictionary *) dictionary
{
  self.day = [[Day alloc] init];
  [self.day readFromDictionary: [dictionary objectForKey: @"day"]];
  self.uid   = [[dictionary objectForKey: @"id"] integerValue];
  self.value = self.day.value;
}

@end
