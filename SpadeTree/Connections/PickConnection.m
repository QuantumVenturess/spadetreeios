//
//  PickConnection.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/19/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "PickConnection.h"

@implementation PickConnection

#pragma mark - Initializer

- (id) init
{
  self = [super init];
  if (self) {
    NSString *string = [NSString stringWithFormat: 
      @"%@/u/pick.json/", SpadeTreeApiURL];
    NSURL *url = [NSURL URLWithString: string];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL: url];
    NSString *paramValue;
    if ([User currentUser].tutee) {
      paramValue = @"tutee=1";
    }
    else if ([User currentUser].tutor) {
      paramValue = @"tutor=1";
    }
    NSString *params = [NSString stringWithFormat:
      @"spadetree_token=%@&"
      @"%@",
      [User currentUser].appToken,
      paramValue
    ];
    [req setHTTPBody: [params dataUsingEncoding: NSUTF8StringEncoding]];
    [req setHTTPMethod: @"POST"];
    self.request = req;
  }
  return self;
}

@end
