//
//  DayFreeConnection.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/19/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "Day.h"
#import "DayFreeConnection.h"

@implementation DayFreeConnection

#pragma mark - Initializer

- (id) initWithDay: (Day *) dayObject
{
  self = [super init];
  if (self) {
    NSString *string = [NSString stringWithFormat: 
      @"%@/d/%i/free_value.json/", SpadeTreeApiURL, dayObject.value];
    NSURL *url = [NSURL URLWithString: string];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL: url];
    NSString *params = [NSString stringWithFormat: @"spadetree_token=%@",
      [User currentUser].appToken];
    [req setHTTPBody: [params dataUsingEncoding: NSUTF8StringEncoding]];
    [req setHTTPMethod: @"POST"];
    self.request = req;
  }
  return self;
}

@end
