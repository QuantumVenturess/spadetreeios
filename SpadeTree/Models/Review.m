//
//  Review.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/12/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "AllUserStore.h"
#import "Review.h"
#import "User.h"

@implementation Review

@synthesize content;
@synthesize created;
@synthesize positive;
@synthesize tutee;
@synthesize tutor;
@synthesize uid;

#pragma mark - Methods

- (NSString *) createdDateStringShort
{
  // Jan 05, 13
  NSDate *date = [NSDate dateWithTimeIntervalSince1970: self.created];
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  dateFormatter.dateFormat = @"MMM d, yy";
  NSString *day = [dateFormatter stringFromDate: date];
  return day;
}

- (void) readFromDictionary: (NSDictionary *) dictionary
{
  self.content = [dictionary objectForKey: @"content"];
  self.created = [[[NSDate date] initWithString:
    [dictionary objectForKey: @"created"]] timeIntervalSince1970];
  if ([[dictionary objectForKey: @"positive"] integerValue] == 1) {
    self.positive = YES;
  }
  else {
    self.positive = NO;
  }
  // Tutee
  NSDictionary *tuteeDict = [dictionary objectForKey: @"tutee"];
  User *tuteeObject = [[AllUserStore sharedStore].users objectForKey: 
    [tuteeDict objectForKey: @"id"]];
  if (!tuteeObject) {
    tuteeObject = [[User alloc] init];
    [tuteeObject readFromDictionary: tuteeDict];
  }
  self.tutee = tuteeObject;
  // Tutor
  NSDictionary *tutorDict = [dictionary objectForKey: @"tutor"];
  User *tutorObject = [[AllUserStore sharedStore].users objectForKey: 
    [tutorDict objectForKey: @"id"]];
  if (!tutorObject) {
    tutorObject = [[User alloc] init];
    [tutorObject readFromDictionary: tutorDict];
  }
  self.tutor = tutorObject;
  self.uid = [[dictionary objectForKey: @"id"] integerValue];
}

@end
