//
//  HourFree.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/17/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "Hour.h"
#import "HourFree.h"

@implementation HourFree

@synthesize hour;
@synthesize uid;
@synthesize value;

#pragma mark - Methods

- (void) readFromDictionary: (NSDictionary *) dictionary
{
  self.hour = [[Hour alloc] init];
  [self.hour readFromDictionary: [dictionary objectForKey: @"hour"]];
  self.uid = [[dictionary objectForKey: @"id"] integerValue];
  self.value = self.hour.value;
}

@end
