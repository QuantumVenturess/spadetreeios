//
//  MessageListConnection.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/30/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "Message.h"
#import "MessageDetailStore.h"
#import "MessageListConnection.h"
#import "MessageListStore.h"

@implementation MessageListConnection

#pragma mark - Initializer

- (id) init
{
  self = [super init];
  if (self) {
    NSString *string = [NSString stringWithFormat:
      @"%@/m/messages.json/?spadetree_token=%@", 
        SpadeTreeApiURL, [User currentUser].appToken];
    [self setRequestFromString: string];
  }
  return self;
}

#pragma mark - NSURLConnectionDataDelegate

- (void) connectionDidFinishLoading: (NSURLConnection *) connection
{
  NSDictionary *json = [NSJSONSerialization JSONObjectWithData: container
    options: 0 error: nil];
  NSArray *messages = [json objectForKey: @"messages"];
  for (NSDictionary *messageDict in messages) {
    Message *message = [[Message alloc] init];
    [message readFromDictionary: messageDict];
    [[MessageDetailStore sharedStore] addMessageFromSender: message];
    [[MessageListStore sharedStore] addMessage: message];
  }
  [super connectionDidFinishLoading: connection];
}

@end
