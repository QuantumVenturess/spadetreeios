//
//  TestConnection.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/18/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "TestConnection.h"

@implementation TestConnection

- (id) init
{
  self = [super init];
  if (self) {
    NSString *string = [NSString stringWithFormat: 
      @"%@/skills/new.json/", @"http://192.168.1.72:8000"];
    NSURL *url = [NSURL URLWithString: string];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL: url];
    NSString *params = [NSString stringWithFormat: 
      @"spadetree_token=%@&"
      @"names=%@", 
      @"9x00000xDAsCI", @"poetry"];
    [req setHTTPBody: [params dataUsingEncoding: NSUTF8StringEncoding]];
    [req setHTTPMethod: @"POST"];
    self.request = req;
  }
  return self;
}

- (void) connectionDidFinishLoading: (NSURLConnection *) connection
{
  NSDictionary *json = [NSJSONSerialization JSONObjectWithData: container
    options: 0 error: nil];
  NSLog(@"JSON: %@", json);
  NSString *html = [[NSString alloc] initWithData: container 
    encoding: NSUTF8StringEncoding];
  NSLog(@"HTML: %@", html);
  [super connectionDidFinishLoading: connection];
}

@end
