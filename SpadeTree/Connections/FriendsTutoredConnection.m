//
//  FriendsTutoredConnection.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/25/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "FriendsTutoredConnection.h"
#import "User.h"

@implementation FriendsTutoredConnection

@synthesize user;

#pragma mark - Initializer

- (id) initWithUser: (User *) userObject
{
  self = [super init];
  if (self) {
    self.user = userObject;
    NSString *string = [NSString stringWithFormat: 
      @"%@/u/%@/friends-tutored.json/?spadetree_token=%@",
      SpadeTreeApiURL, [self.user slug], [User currentUser].appToken];
    [self setRequestFromString: string];
  }
  return self;
}

#pragma mark - Protocol NSURLConnectionDataDelegate

- (void) connectionDidFinishLoading: (NSURLConnection *) connection
{
  NSDictionary *json = [NSJSONSerialization JSONObjectWithData: container
    options: 0 error: nil];
  [self.user readFromDictionaryFriendsTutored: json];
  [super connectionDidFinishLoading: connection];
}

@end
