//
//  UserReviewsConnection.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/12/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "UserReviewsConnection.h"

@implementation UserReviewsConnection

@synthesize user;

#pragma mark - Initializer

- (id) initWithUser: (User *) userObject
{
  self = [super init];
  if (self) {
    self.user = userObject;
    NSString *requestString = [NSString stringWithFormat: 
      @"%@/u/%@/reviews.json/?spadetree_token=%@",
        SpadeTreeApiURL, [self.user slug], [User currentUser].appToken];
    [self setRequestFromString: requestString];
  }
  return self;
}

#pragma mark - Protocol NSURLConnectionDataDelegate

- (void) connectionDidFinishLoading: (NSURLConnection *) connection
{
  NSDictionary *json = [NSJSONSerialization JSONObjectWithData: container
    options: 0 error: nil];
  [self.user readFromDictionaryReviews: json];
  [super connectionDidFinishLoading: connection];
}

@end
