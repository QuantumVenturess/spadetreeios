//
//  NotificationGroup.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 8/5/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "NotificationGroup.h"

@implementation NotificationGroup

@synthesize date;
@synthesize dateString;
@synthesize notifications;

#pragma mark - Initializer

- (id) init
{
  self = [super init];
  if (self) {
    self.notifications = [NSMutableArray array];
  }
  return self;
}

#pragma mark - Getters

- (NSMutableArray *) notifications
{
  return [self notificationsSortedByCreated];
}

#pragma mark - Setters

- (void) setDateString: (NSString *) string
{
  NSDateFormatter *df = [[NSDateFormatter alloc] init];
  df.dateFormat = @"MMMM d, yyyy";
  NSDate *d  = [df dateFromString: string];
  self.date  = [d timeIntervalSince1970];
  dateString = string;
}

#pragma mark - Methods

- (NSMutableArray *) notificationsSortedByCreated
{
  NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey: @"created"
    ascending: NO];
  return (NSMutableArray *) [notifications sortedArrayUsingDescriptors:
    [NSArray arrayWithObject: sort]];
}

@end
