//
//  NotificationStore.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 8/5/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "AppDelegate.h"
#import "Notification.h"
#import "NotificationStore.h"

@implementation NotificationStore

@synthesize notifications;

#pragma mark - Initializer

- (id) init
{
  self = [super init];
  if (self) {
    // self.notifications = [NSMutableDictionary dictionary];
    self.notifications = [NSMutableArray array];
    [[NSNotificationCenter defaultCenter] addObserver: self
      selector: @selector(signOut) name: CurrentUserSignOut object: nil];
  }
  return self;
}

#pragma mark - Getters

- (NSArray *) notifications
{
  NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey: @"created"
    ascending: NO];
  return [notifications sortedArrayUsingDescriptors: 
    [NSArray arrayWithObject: sort]];
}

#pragma mark - Methods

+ (NotificationStore *) sharedStore
{
  static NotificationStore *store = nil;
  if (!store) {
    store = [[NotificationStore alloc] init];
  }
  return store;
}

- (void) addNotification: (Notification *) notification
{
  // NSDate *date = [NSDate dateWithTimeIntervalSince1970: 
  //   notification.created];
  // NSDateFormatter *df = [[NSDateFormatter alloc] init];
  // df.dateFormat = @"MMMM d, yyyy";
  // NSString *dateString = [df stringFromDate: date];
  // NSMutableArray *array = [notifications objectForKey: dateString];
  // if (!array) {
  //   array = [NSMutableArray array];
  //   [notifications setObject: array forKey: dateString];
  // }
  NSPredicate *predicate = [NSPredicate predicateWithFormat: 
    @"%K == %i", @"uid", notification.uid];
  if ([notifications filteredArrayUsingPredicate: predicate].count == 0) {
    [notifications addObject: notification];
  }
}

- (NSArray *) allDates
{
  // August 2, 2013
  // NSArray *sortedArray = [notifications.allKeys sortedArrayUsingComparator: 
  //   ^(id obj1, id obj2) {
  //     NSDateFormatter *df = [[NSDateFormatter alloc] init];
  //     df.dateFormat = @"MMMM d, yyyy";
  //     NSDate *date1 = [df dateFromString: obj1];
  //     NSDate *date2 = [df dateFromString: obj2];
  //     NSTimeInterval ti1 = [date1 timeIntervalSince1970];
  //     NSTimeInterval ti2 = [date2 timeIntervalSince1970];
  //     if (ti1 > ti2) {
  //       return (NSComparisonResult) NSOrderedAscending;
  //     }
  //     if (ti1 < ti2) {
  //       return (NSComparisonResult) NSOrderedDescending;
  //     }
  //     return (NSComparisonResult) NSOrderedSame;
  //   }
  // ];
  // return sortedArray;
  return [NSArray array];
}

- (void) readFromDictionary: (NSDictionary *) dictionary
{
  for (NSDictionary *dict in [dictionary objectForKey: @"notifications"]) {
    Notification *notification = [[Notification alloc] init];
    [notification readFromDictionary: dict];
  }
}

- (void) signOut
{
  [notifications removeAllObjects];
}

@end
