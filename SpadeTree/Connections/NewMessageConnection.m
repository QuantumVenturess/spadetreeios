//
//  NewMessageConnection.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 8/1/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "Message.h"
#import "NewMessageConnection.h"

@implementation NewMessageConnection

#pragma mark - Initializer

- (id) initWithMessage: (Message *) messageObject
{
  self = [super init];
  if (self) {
    message = messageObject;
    NSString *string = [NSString stringWithFormat:
      @"%@/m/%i/new.json/", SpadeTreeApiURL, message.recipient.uid];
    NSURL *url = [NSURL URLWithString: string];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL: url];
    NSString *params = [NSString stringWithFormat:
      @"spadetree_token=%@&"
      @"content=%@",
      [User currentUser].appToken,
      message.content
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
  if ([json objectForKey: @"message"]) {
    int messageId = [[[json objectForKey: @"message"] objectForKey: 
      @"id"] integerValue];
    message.uid = messageId;
  }
  [super connectionDidFinishLoading: connection];
}

@end
