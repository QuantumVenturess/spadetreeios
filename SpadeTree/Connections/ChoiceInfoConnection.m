//
//  ChoiceInfoConnection.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 8/8/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "Choice.h"
#import "ChoiceInfoConnection.h"

@implementation ChoiceInfoConnection

#pragma mark - Initializer

- (id) initWithChoiceId: (int) choiceId
{
  self = [super init];
  if (self) {
    NSString *string = [NSString stringWithFormat:
      @"%@/c/%i/info.json/?spadetree_token=%@",
        SpadeTreeApiURL, choiceId, [User currentUser].appToken];
    [self setRequestFromString: string];
  }
  return self;
}

#pragma mark - NSURLConnectionDelegate

- (void) connectionDidFinishLoading: (NSURLConnection *) connection
{
  NSDictionary *json = [NSJSONSerialization JSONObjectWithData: container
    options: 0 error: nil];
  Choice *choice = [[Choice alloc] init];
  [choice readFromDictionary: [json objectForKey: @"choice"]];
  [super connectionDidFinishLoading: connection];
}

@end
