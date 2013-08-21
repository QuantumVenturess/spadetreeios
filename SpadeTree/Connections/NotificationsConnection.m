//
//  NotificationsConnection.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 8/5/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "NotificationsConnection.h"
#import "NotificationStore.h"

@implementation NotificationsConnection

#pragma mark - Initializer

- (id) init
{
  self = [super init];
  if (self) {
    NSString *string = [NSString stringWithFormat:
      @"%@/n/notifications.json/?spadetree_token=%@",
        SpadeTreeApiURL, [User currentUser].appToken];
    [self setRequestFromString: string];
  }
  return self;
}

#pragma mark - Protocol NSURLConnectionDateDelegate

- (void) connectionDidFinishLoading: (NSURLConnection *) connection
{
  NSDictionary *json = [NSJSONSerialization JSONObjectWithData: container
    options: 0 error: nil];
  [[NotificationStore sharedStore] readFromDictionary: json];
  [super connectionDidFinishLoading: connection];
}

@end
