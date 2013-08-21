//
//  ChooseTutorConnection.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/17/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "Choice.h"
#import "ChooseTutorConnection.h"
#import "DayFree.h"
#import "HourFree.h"
#import "Interest.h"

@implementation ChooseTutorConnection

#pragma mark - Initializer

- (id) initWithDayFree: (DayFree *) dayFree hourFree: (HourFree *) hourFree 
choice: (Choice *) choiceObject
{
  self = [super init];
  if (self) {
    choice = choiceObject;
    NSString *string = [NSString stringWithFormat:
      @"%@/u/%@/choose.json/", SpadeTreeApiURL, [choice.tutor slug]];
    NSURL *url = [NSURL URLWithString: string];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL: url];
    NSString *params = [NSString stringWithFormat:
      @"spadetree_token=%@&"
      @"content=%@&"
      @"day_free_pk=%i&"
      @"hour_free_pk=%i&"
      @"interest_pk=%i",
      [User currentUser].appToken,
      choice.content,
      dayFree.uid,
      hourFree.uid,
      choice.interest.uid
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
  [choice readFromDictionary: [json objectForKey: @"choice"]];
  [choice subscribeToChannel];
  [choice sendPushNotificationToTutor];
  [super connectionDidFinishLoading: connection];
}

@end
