//
//  UserDetailConnection.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/12/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "UserDetailConnection.h"

@implementation UserDetailConnection

@synthesize user;

#pragma mark - Initializer

- (id) initWithUser: (User *) userObject
{
  self = [super init];
  if (self) {
    self.user = userObject;
    NSString *requestString = [NSString stringWithFormat: 
      @"%@/u/%@.json/?spadetree_token=%@",
        SpadeTreeApiURL, [self.user slug], [User currentUser].appToken];
    [self setRequestFromString: requestString];
  }
  return self;
}

#pragma mark - NSURLConnectionDataDelegate

- (void) connectionDidFinishLoading: (NSURLConnection *) connection
{
  NSDictionary *json = [NSJSONSerialization JSONObjectWithData: container
    options: 0 error: nil];
  [self.user readFromDictionary: [json objectForKey: @"user"]];
  [self.user readFromDictionaryDaysAndHours: json];
  [self.user readFromDictionarySkills: json];
  [super connectionDidFinishLoading: connection];
}

@end
