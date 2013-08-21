//
//  HourFreeConnection.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/19/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "Hour.h"
#import "HourFreeConnection.h"

@implementation HourFreeConnection

#pragma mark - Initializer

- (id) initWithHour: (Hour *) hourObject
{
  self = [super init];
  if (self) {
    NSString *string = [NSString stringWithFormat: 
      @"%@/h/%i/free_value.json/", SpadeTreeApiURL, hourObject.value];
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
