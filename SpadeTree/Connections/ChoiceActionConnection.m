//
//  ChoiceActionConnection.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 8/2/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "Choice.h"
#import "ChoiceActionConnection.h"

@implementation ChoiceActionConnection

#pragma mark - Initializer

- (id) initWithChoice: (Choice *) choiceObject
{
  self = [super init];
  if (self) {
    choice = choiceObject;
    NSString *string = [NSString stringWithFormat:
      @"%@/c/%i/action.json/", SpadeTreeApiURL, choice.uid];
    NSURL *url = [NSURL URLWithString: string];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL: url];
    NSString *action;
    if ([User currentUser].tutee) {
      if (choice.completed) {
        action = @"complete";
      }
    }
    else if ([User currentUser].tutor) {
      if (choice.accepted) {
        action = @"accept";
      }
      else if (choice.denied) {
        action = @"deny";
      }
    }
    NSString *params = [NSString stringWithFormat:
      @"spadetree_token=%@&"
      @"action=%@",
      [User currentUser].appToken,
      action
    ];
    [req setHTTPBody: [params dataUsingEncoding: NSUTF8StringEncoding]];
    [req setHTTPMethod: @"POST"];
    self.request = req;
  }
  return self;
}

#pragma mark - NSURLConnectionDataDelegate

- (void) connectionDidFinishLoading: (NSURLConnection *) connection
{
  NSDictionary *json = [NSJSONSerialization JSONObjectWithData: container
    options: 0 error: nil];
  if ([json objectForKey: @"choice"]) {
    [choice readFromDictionary: [json objectForKey: @"choice"]];
    // If choice is accepted and not completed and user is a tutor
    if (choice.accepted && !choice.completed && [User currentUser].tutor) {
      // Send push notification to tutee
      [choice sendPushNotificationToTutee];
    }
  }
  [super connectionDidFinishLoading: connection];
}

@end
