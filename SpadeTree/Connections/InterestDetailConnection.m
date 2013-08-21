//
//  InterestDetailConnection.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/10/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "Interest.h"
#import "InterestDetailConnection.h"

@implementation InterestDetailConnection

@synthesize interest;

#pragma mark - Initializer

- (id) initWithInterest: (Interest *) interestObject
{
  self = [super init];
  if (self) {
    self.interest = interestObject;
    NSString *requestString = [NSString stringWithFormat: 
      @"%@/i/%@.json/?spadetree_token=%@",
      SpadeTreeApiURL, self.interest.slug, [User currentUser].appToken];
    [self setRequestFromString: requestString];
  }
  return self;
}

#pragma mark - Override SpadeTreeConnection

- (void) connectionDidFinishLoading: (NSURLConnection *) connection
{
  NSDictionary *json = [NSJSONSerialization JSONObjectWithData: container
    options: 0 error: nil];
  [self.interest readFromDictionaryDetail: json];
  [super connectionDidFinishLoading: connection];
}

@end
