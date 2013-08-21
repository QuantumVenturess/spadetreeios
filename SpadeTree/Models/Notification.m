//
//  Notification.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 8/5/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "AllInterestStore.h"
#import "AllUserStore.h"
#import "Choice.h"
#import "ChoiceListStore.h"
#import "Interest.h"
#import "Notification.h"
#import "NotificationStore.h"
#import "User.h"

@implementation Notification

@synthesize choice;
@synthesize created;
@synthesize interest;
@synthesize message;
@synthesize uid;
@synthesize user;

#pragma mark - Methods

- (void) readFromDictionary: (NSDictionary *) dictionary
{
  // Choice
  if ([dictionary objectForKey: @"choice"] != [NSNull null]) {
    NSDictionary *dict = [dictionary objectForKey: @"choice"];
    int choiceId = [[dict objectForKey: @"id"] integerValue];
    Choice *c = [[ChoiceListStore sharedStore] choiceForId: choiceId];
    if (!c) {
      c = [[Choice alloc] init];
      [c readFromDictionary: dict];
    }
    self.choice = c;
  }
  self.created = [[[NSDate date] initWithString: 
    [dictionary objectForKey: @"created"]] timeIntervalSince1970];
  // Interest
  if ([dictionary objectForKey: @"interest"] != [NSNull null]) {
    NSDictionary *dict = [dictionary objectForKey: @"interest"];
    NSString *interestName = [dict objectForKey: @"name"];
    Interest *i = [[AllInterestStore sharedStore].interests objectForKey:
      interestName];
    if (!i) {
      i = [[Interest alloc] init];
      [i readFromDictionary: dict];
    }
    self.interest = i;
  }
  self.message = [dictionary objectForKey: @"message"];
  self.uid     = [[dictionary objectForKey: @"id"] integerValue];
  // User
  NSDictionary *userDict = [dictionary objectForKey: @"user"];
  int userId = [[userDict objectForKey: @"id"] integerValue];
  User *u = [[AllUserStore sharedStore].users objectForKey: 
    [NSString stringWithFormat: @"%i", userId]];
  if (!u) {
    u = [[User alloc] init];
    [u readFromDictionary: userDict];
  }
  self.user = u;
  [[NotificationStore sharedStore] addNotification: self];
}

@end
