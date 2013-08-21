//
//  Choice.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 8/1/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import <Parse/Parse.h>
#import "AllInterestStore.h"
#import "AllUserStore.h"
#import "Choice.h"
#import "ChoiceListStore.h"
#import "ChoiceNote.h"
#import "City.h"
#import "Day.h"
#import "DayStore.h"
#import "Hour.h"
#import "HourStore.h"
#import "Interest.h"
#import "User.h"

@implementation Choice

@synthesize accepted;
@synthesize address;
@synthesize city;
@synthesize completed;
@synthesize created;
@synthesize content;
@synthesize date;
@synthesize dateCompleted;
@synthesize day;
@synthesize denied;
@synthesize hour;
@synthesize interest;
@synthesize tutee;
@synthesize tuteeViewed;
@synthesize tutor;
@synthesize tutorViewed;
// iOS
@synthesize notes;
@synthesize tuteePhone;
@synthesize tutorPhone;
@synthesize uid;

#pragma mark - Initializer

- (id) init
{
  self = [super init];
  if (self) {
    self.notes = [NSMutableArray array];
  }
  return self;
}

#pragma mark - Getters

- (NSArray *) notes
{
  NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey: @"created"
    ascending: NO];
  return [notes sortedArrayUsingDescriptors:
    [NSArray arrayWithObject: sort]];
}

#pragma mark - Methods

- (void) addChoiceNote: (ChoiceNote *) choiceNote
{
  NSPredicate *predicate = [NSPredicate predicateWithFormat:
    @"%K == %i", @"uid", choiceNote.uid];
  NSArray *array = [notes filteredArrayUsingPredicate: predicate];
  if (array.count == 0) {
    [notes addObject: choiceNote];
  }
}

- (NSString *) createdDateStringForList
{
  // Jun 24, 13
  NSDate *d = [NSDate dateWithTimeIntervalSince1970: self.created];
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  dateFormatter.dateFormat = @"MMM d, yy";
  NSString *dayString = [dateFormatter stringFromDate: d];
  return dayString;
}

- (NSString *) dateCompletedStringForList
{
  // Jun 24, 13
  NSDate *d = [NSDate dateWithTimeIntervalSince1970: self.dateCompleted];
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  dateFormatter.dateFormat = @"MMM d, yy";
  NSString *dayString = [dateFormatter stringFromDate: d];
  return dayString;
}

- (NSString *) dateStringLong
{
  // July 29, 2013
  if (self.date) {
    NSDate *d = [NSDate dateWithTimeIntervalSince1970: self.date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"MMMM d, yyyy";
    NSString *dayString = [dateFormatter stringFromDate: d];
    return dayString;
  }
  return [NSString string];
}

- (NSString *) dateStringNumbers
{
  if (self.date) {
    NSDate *d = [NSDate dateWithTimeIntervalSince1970: self.date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"MM/dd/yyyy";
    NSString *dayString = [dateFormatter stringFromDate: d];
    return dayString;
  }
  return @"";
}

- (NSString *) pushNotificationChannel
{
  return [NSString stringWithFormat: @"choice_%i", self.uid];
}

- (void) readFromDictionary: (NSDictionary *) dictionary
{
  // Accepted
  if ([[dictionary objectForKey: @"accepted"] integerValue]) {
    self.accepted = YES;
  }
  else {
    self.accepted = NO;
  }
  // Address
  self.address = [dictionary objectForKey: @"address"];
  // City
  if ([dictionary objectForKey: @"city"] != [NSNull null]) {
    NSDictionary *cityDict = [dictionary objectForKey: @"city"];
    City *cityObject = [[City alloc] init];
    [cityObject readFromDictionary: cityDict];
    self.city = cityObject;
  }
  // Completed
  if ([[dictionary objectForKey: @"completed"] integerValue]) {
    self.completed = YES;
  }
  else {
    self.completed = NO;
  }
  // Created
  self.created = [[[NSDate date] initWithString: 
    [dictionary objectForKey: @"created"]] timeIntervalSince1970];
  // Content
  self.content = [dictionary objectForKey: @"content"];
  // Date
  if ([dictionary objectForKey: @"date"] != [NSNull null] ) {
    self.date = [[[NSDate date] initWithString:
      [dictionary objectForKey: @"date"]] timeIntervalSince1970];
  }
  // Date Completed
  if ([dictionary objectForKey: @"date_completed"] != [NSNull null]) {
    self.dateCompleted = [[[NSDate date] initWithString:
      [dictionary objectForKey: @"date_completed"]] timeIntervalSince1970];
  }
  // Day
  if ([dictionary objectForKey: @"day"] != [NSNull null]) {
    NSDictionary *dayDict = [dictionary objectForKey: @"day"];
    int value = [[dayDict objectForKey: @"value"] integerValue];
    self.day = [[DayStore sharedStore] dayForValue: value];
  }
  // Denied
  if ([[dictionary objectForKey: @"denied"] integerValue]) {
    self.denied = YES;
  }
  else {
    self.denied = NO;
  }
  // Hour
  if ([dictionary objectForKey: @"hour"] != [NSNull null]) {
    NSDictionary *hourDict = [dictionary objectForKey: @"hour"];
    int value = [[hourDict objectForKey: @"value"] integerValue];
    self.hour = [[HourStore sharedStore] hourForValue: value];
  }
  // Interest
  NSDictionary *interestDict = [dictionary objectForKey: @"interest"];
  Interest *interestObject = [[AllInterestStore sharedStore] interestForName:
    [interestDict objectForKey: @"name"]];
  if (!interestObject) {
    interestObject = [[Interest alloc] init];
    [interestObject readFromDictionary: interestDict];
  }
  self.interest = interestObject;
  // Tutee
  NSDictionary *tuteeDict = [dictionary objectForKey: @"tutee"];
  int tuteeId = [[tuteeDict objectForKey: @"id"] integerValue];
  User *tuteeObject = [[AllUserStore sharedStore].users objectForKey:
    [NSString stringWithFormat: @"%i", tuteeId]];
  if (!tuteeObject) {
    tuteeObject = [[User alloc] init];
    [tuteeObject readFromDictionary: tuteeDict];
  }
  self.tutee = tuteeObject;
  // Tutee phone
  if ([dictionary objectForKey: @"tutee_phone"]) {
    self.tuteePhone = [[dictionary objectForKey: @"tutee_phone"] doubleValue];
  }
  // Tutee viewed
  if ([[dictionary objectForKey: @"tutee_viewed"] integerValue]) {
    self.tuteeViewed = YES;
  }
  else {
    self.tuteeViewed = NO;
  }
  // Tutor
  NSDictionary *tutorDict = [dictionary objectForKey: @"tutor"];
  int tutorId = [[tutorDict objectForKey: @"id"] integerValue];
  User *tutorObject = [[AllUserStore sharedStore].users objectForKey:
    [NSString stringWithFormat: @"%i", tutorId]];
  if (!tutorObject) {
    tutorObject = [[User alloc] init];
    [tutorObject readFromDictionary: tutorDict];
  }
  self.tutor = tutorObject;
  // Tutor phone
  if ([dictionary objectForKey: @"tutor_phone"]) {
    self.tutorPhone = [[dictionary objectForKey: @"tutor_phone"] doubleValue];
  }
  // Tutor viewed
  if ([[dictionary objectForKey: @"tutor_viewed"] integerValue]) {
    self.tutorViewed = YES;
  }
  else {
    self.tutorViewed = NO;
  }
  // UID
  self.uid = [[dictionary objectForKey: @"id"] integerValue];

  // Add to ChoiceListStore
  [[ChoiceListStore sharedStore] addChoice: self];
}

- (void) readFromDictionaryNotes: (NSDictionary *) dictionary
{
  for (NSDictionary *dict in [dictionary objectForKey: @"notes"]) {
    ChoiceNote *note = [[ChoiceNote alloc] init];
    [note readFromDictionary: dict];
    note.choice = self;
    [self addChoiceNote: note];
  }
}

- (void) sendPushNotificationToTutee
{
  NSString *alert = [NSString stringWithFormat:
    @"%@ accepted your request", [[User currentUser] fullName]];
  NSTimeInterval interval = 60 * 60 * 24 * 7;
  NSDictionary *data = @{
    @"alert": alert,
    @"badge": @"Increment",
    @"choice_id": [NSString stringWithFormat: @"%i", self.uid]
  };
  PFPush *push = [[PFPush alloc] init];
  [push expireAfterTimeInterval: interval];
  [push setChannel: [self pushNotificationChannel]];
  [push setData: data];
  [push sendPushInBackground];
}

- (void) sendPushNotificationToTutor
{
  NSString *alert = [NSString stringWithFormat:
    @"%@ sent you a request", [[User currentUser] fullName]];
  NSTimeInterval interval = 60 * 60 * 24 * 7;
  NSDictionary *data = @{
    @"alert": alert,
    @"badge": @"Increment",
    @"choice_id": [NSString stringWithFormat: @"%i", self.uid]
  };
  PFPush *push = [[PFPush alloc] init];
  [push expireAfterTimeInterval: interval];
  [push setChannel: [self.tutor pushNotificationChannelForAllChoices]];
  [push setData: data];
  [push sendPushInBackground];
}

- (void) subscribeToChannel
{
  PFInstallation *currentInstallation = [PFInstallation currentInstallation];
  [currentInstallation addUniqueObject: [self pushNotificationChannel] 
    forKey: @"channels"];
  [currentInstallation saveInBackground];
}

- (void) updateFromChoice: (Choice *) choice
{
  self.accepted      = choice.accepted;
  self.address       = choice.address;
  self.city          = choice.city;
  self.completed     = choice.completed;
  self.content       = choice.content;
  self.date          = choice.date;
  self.dateCompleted = choice.dateCompleted;
  self.denied        = choice.denied;
  self.tuteeViewed   = self.tuteeViewed;
  self.tutorViewed   = self.tutorViewed;
}

@end
