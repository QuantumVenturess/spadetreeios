//
//  UserAuthenticationConnection.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/5/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "UserAuthenticationConnection.h"

@implementation UserAuthenticationConnection

#pragma mark - Initializer

- (id) initWithUser: (User *) userObject
{
  self = [super init];
  if (self) {
    NSString *string = [NSString stringWithFormat: 
      @"%@/oauth/authenticate-app.json/", SpadeTreeApiURL];
    NSURL *url = [NSURL URLWithString: string];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL: url];
    NSString *params = [NSString stringWithFormat:
      @"access_token=%@&"
      @"bio=%@&"
      @"email=%@&"
      @"facebook_id=%0.0f&"
      @"facebook_link=%@&"
      @"first_name=%@&"
      @"last_name=%@&"
      @"location=%@", 
      userObject.accessToken, 
      userObject.about, 
      userObject.email, 
      userObject.facebookId, 
      userObject.facebookLink, 
      userObject.firstName, 
      userObject.lastName, 
      userObject.location ? userObject.location : @""
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
  [[User currentUser] getAccessToken: json];
  [super connectionDidFinishLoading: connection];
}

#pragma mark - Methods

- (void) start
{
  [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
  container = [[NSMutableData alloc] init];
  internalConnection = [[NSURLConnection alloc] initWithRequest: self.request
    delegate: self startImmediately: NO];
  [internalConnection scheduleInRunLoop: [NSRunLoop mainRunLoop]
    forMode: NSDefaultRunLoopMode];
  [internalConnection start];
  if (!sharedConnectionList) {
    sharedConnectionList = [NSMutableArray array];
  }
  [sharedConnectionList addObject: self];
}

@end
