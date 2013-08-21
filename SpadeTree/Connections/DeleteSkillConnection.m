//
//  DeleteSkillConnection.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/18/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "DeleteSkillConnection.h"
#import "Interest.h"

@implementation DeleteSkillConnection

#pragma mark - Initialzer

- (id) initWithInterest: (Interest *) interestObject
{
  self = [super init];
  if (self) {
    NSString *string = [NSString stringWithFormat: 
      @"%@/skills/%i/delete_skill.json/", SpadeTreeApiURL, interestObject.uid];
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

#pragma mark - Protocol NSURLConnectionDataDelegate

- (void) connectionDidFinishLoading: (NSURLConnection *) connection
{
  // NSDictionary *json = [NSJSONSerialization JSONObjectWithData: container
  //  options: 0 error: nil];
  [super connectionDidFinishLoading: connection];
}

@end
