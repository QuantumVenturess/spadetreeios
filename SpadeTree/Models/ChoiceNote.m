//
//  ChoiceNote.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 8/5/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "AllUserStore.h"
#import "Choice.h"
#import "ChoiceNote.h"
#import "User.h"

@implementation ChoiceNote

@synthesize choice;
@synthesize content;
@synthesize created;
@synthesize uid;
@synthesize user;

#pragma mark - Methods

- (NSString *) createdDateString
{
  NSDate *date = [NSDate dateWithTimeIntervalSince1970: self.created];
  NSDateFormatter *df1 = [[NSDateFormatter alloc] init];
  df1.dateFormat = @"MMM d, yy";
  NSDateFormatter *df2 = [[NSDateFormatter alloc] init];
  df2.dateFormat = @"h:mm a";
  return [NSString stringWithFormat: @"%@ at %@",
    [df1 stringFromDate: date], [[df2 stringFromDate: date] lowercaseString]];
}

- (void) readFromDictionary: (NSDictionary *) dictionary
{
  self.content = [dictionary objectForKey: @"content"];
  self.created = [[[NSDate date] initWithString:
    [dictionary objectForKey: @"created"]] timeIntervalSince1970];
  self.uid = [[dictionary objectForKey: @"id"] integerValue];
  NSDictionary *userDict = [dictionary objectForKey: @"user"];
  int userId = [[userDict objectForKey: @"id"] integerValue];
  User *userObject = [[AllUserStore sharedStore].users objectForKey:
    [NSString stringWithFormat: @"%i", userId]];
  if (!userObject) {
    userObject = [[User alloc] init];
    [userObject readFromDictionary: userDict];
  }
  self.user = userObject;
}

@end
