//
//  AddSkillConnection.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/18/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "AddSkillConnection.h"
#import "Interest.h"

@implementation AddSkillConnection

@synthesize interest;

#pragma mark - Initializer

- (id) initWithInterest: (Interest *) interestObject
{
  self = [super init];
  if (self) {
    self.interest = interestObject;
    NSString *string = [NSString stringWithFormat: 
      @"%@/skills/new.json/", SpadeTreeApiURL];
    NSURL *url = [NSURL URLWithString: string];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL: url];
    NSString *params = [NSString stringWithFormat: 
      @"spadetree_token=%@&"
      @"names=%@",
      [User currentUser].appToken, 
      self.interest.name
    ];
    [req setHTTPBody: [params dataUsingEncoding: NSUTF8StringEncoding]];
    [req setHTTPMethod: @"POST"];
    self.request = req;
  }
  return self;
}

#pragma mark - Protocol NSURLConnectionDataDelegate

- (void) connectionDidFinishLoading: (NSURLConnection *) connection
{
  NSDictionary *json = [NSJSONSerialization JSONObjectWithData: container
    options: 0 error: nil];
  [self.interest readFromDictionary: [json objectForKey: @"interest"]];
  [super connectionDidFinishLoading: connection];
}

@end
