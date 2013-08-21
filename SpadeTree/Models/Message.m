//
//  Message.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/30/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "AllUserStore.h"
#import "Message.h"
#import "NSDate+TimeAgo.h"
#import "User.h"

@implementation Message

@synthesize content;
@synthesize created;
@synthesize recipient;
@synthesize sender;
@synthesize uid;
@synthesize viewed;

#pragma mark - Methods

- (NSString *) createdDateStringForDetail
{
  float now = [[NSDate date] timeIntervalSince1970];
  float day  = 3600 * 24;
  float week = day * 7;
  NSDate *date = [NSDate dateWithTimeIntervalSince1970: self.created];
  if (self.created + day > now) {
    return [date timeAgo];
  }
  else if (self.created + week > now) {
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    dateFormatter1.dateFormat = @"EEE";
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    dateFormatter2.dateFormat = @"h:mm a";
    return [NSString stringWithFormat: @"%@, %@",
      [dateFormatter1 stringFromDate: date], 
        [[dateFormatter2 stringFromDate: date] lowercaseString]];
  }
  return [self createdDateStringForList];
}

- (NSString *) createdDateStringForList
{
  NSDate *date = [NSDate dateWithTimeIntervalSince1970: self.created];
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  dateFormatter.dateFormat = @"MMM d, yy";
  NSString *day = [dateFormatter stringFromDate: date];
  // dateFormatter.dateFormat = @"h:mm a";
  // NSString *dateTime = [dateFormatter stringFromDate: date];
  // return [NSString stringWithFormat: @"%@ at %@", 
  //   day, [dateTime lowercaseString]];
  return day;
}

- (void) readFromDictionary: (NSDictionary *) dictionary
{
  self.content = [dictionary objectForKey: @"content"];
  self.created = [[[NSDate date] initWithString:
    [dictionary objectForKey: @"created"]] timeIntervalSince1970];
  self.recipient = [User currentUser];
  // Sender
  NSDictionary *senderDict = [dictionary objectForKey: @"sender"];
  int senderId = [[senderDict objectForKey: @"id"] integerValue];
  self.sender = [[AllUserStore sharedStore].users objectForKey:
    [NSString stringWithFormat: @"%i", senderId]];
  if (!self.sender) {
    self.sender = [[User alloc] init];
    [self.sender readFromDictionary: senderDict];
  }
  self.uid = [[dictionary objectForKey: @"id"] integerValue];
  if ([[dictionary objectForKey: @"viewed"] integerValue]) {
    self.viewed = YES;
  }
  else {
    self.viewed = NO;
  }
}

@end
