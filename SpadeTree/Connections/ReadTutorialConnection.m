//
//  ReadTutorialConnection.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 8/8/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "ReadTutorialConnection.h"

@implementation ReadTutorialConnection

#pragma mark - Initializer

- (id) init
{
  self = [super init];
  if (self) {
    NSString *string = [NSString stringWithFormat: 
      @"%@/u/read-tutorial.json/", SpadeTreeApiURL];
    NSURL *url = [NSURL URLWithString: string];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL: url];
    NSString *params = [NSString stringWithFormat:
      @"spadetree_token=%@", [User currentUser].appToken];
    [req setHTTPBody: [params dataUsingEncoding: NSUTF8StringEncoding]];
    [req setHTTPMethod: @"POST"];
    self.request = req;
  }
  return self;
}

@end
