//
//  MessageDetailConnection.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/30/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "Message.h"
#import "MessageDetailConnection.h"
#import "MessageDetailStore.h"

@implementation MessageDetailConnection

#pragma mark - Initializer

- (id) initWithMessage: (Message *) messageObject
{
  self = [super init];
  if (self) {
    message = messageObject;
    NSString *string = [NSString stringWithFormat:
      @"%@/m/%i.json/?spadetree_token=%@", 
        SpadeTreeApiURL, message.sender.uid, [User currentUser].appToken];
    [self setRequestFromString: string];
  }
  return self;
}

#pragma mark - Protocol NSURLConnectionDataDelegate

- (void) connectionDidFinishLoading: (NSURLConnection *) connection
{
  NSDictionary *json = [NSJSONSerialization JSONObjectWithData: container
    options: 0 error: nil];
  NSMutableArray *messages = [NSMutableArray array];
  for (NSDictionary *dict in [json objectForKey: @"messages"]) {
    Message *m = [[Message alloc] init];
    [m readFromDictionary: dict];
    [messages addObject: m];
  }
  [[MessageDetailStore sharedStore].messages setObject: messages
    forKey: [NSString stringWithFormat: @"%i", message.sender.uid]];
  [super connectionDidFinishLoading: connection];
}

@end
