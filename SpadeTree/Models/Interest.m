//
//  Interest.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/9/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "AllInterestStore.h"
#import "AllUserStore.h"
#import "Interest.h"
#import "User.h"

@implementation Interest

@synthesize created;
@synthesize name;
@synthesize slug;
@synthesize tutees;
@synthesize tutors;
@synthesize uid;

#pragma mark - Initializer

- (id) init
{
  self = [super init];
  if (self) {
    self.tutees = [NSMutableArray array];
    self.tutors = [NSMutableArray array];
  }
  return self;
}

#pragma mark - Override NSObject

- (NSString *) description
{
  return self.name;
}

#pragma mark - Getters

- (NSMutableArray *) tutees
{
  NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey: @"firstName"
    ascending: YES];
  return (NSMutableArray *) [tutees sortedArrayUsingDescriptors:
    [NSArray arrayWithObject: sort]];
}

- (NSMutableArray *) tutors
{
  NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey: @"firstName"
    ascending: YES];
  return (NSMutableArray *) [tutors sortedArrayUsingDescriptors: 
    [NSArray arrayWithObject: sort]];
}

#pragma mark - Methods

- (void) addUserToTutees: (User *) user
{
  NSPredicate *predicate = [NSPredicate predicateWithFormat:
    @"%K == %i", @"uid", user.uid];
  if ([tutees filteredArrayUsingPredicate: predicate].count == 0) {
    [tutees addObject: user];
  }
}

- (void) addUserToTutors: (User *) user
{
  NSPredicate *predicate = [NSPredicate predicateWithFormat:
    @"%K == %i", @"uid", user.uid];
  if ([tutors filteredArrayUsingPredicate: predicate].count == 0) {
    [tutors addObject: user];
  }
}

- (NSString *) nameTitle
{
  return [self.name capitalizedString];
}

- (void) readFromDictionary: (NSDictionary *) dictionary
{
  self.created = [[[NSDate date] initWithString:
    [dictionary objectForKey: @"created"]] timeIntervalSince1970];
  self.name = [dictionary objectForKey: @"name"];
  self.slug = [dictionary objectForKey: @"slug"];
  self.uid  = [[dictionary objectForKey: @"id"] integerValue];
  [[AllInterestStore sharedStore] addInterest: self];
}

- (void) readFromDictionaryDetail: (NSDictionary *) dictionary
{
  NSArray *tuteesArray = [dictionary objectForKey: @"tutees"];
  NSArray *tutorsArray = [dictionary objectForKey: @"tutors"];
  for (NSDictionary *userDict in tuteesArray) {
    int userUid = [[userDict objectForKey: @"id"] integerValue];
    NSString *key = [NSString stringWithFormat: @"%i", userUid];
    User *user = [[AllUserStore sharedStore].users objectForKey: key];
    if (!user) {
      user = [[User alloc] init];
      [user readFromDictionary: userDict];
    }
    [self addUserToTutees: user];
  }
  for (NSDictionary *userDict in tutorsArray) {
    int userUid = [[userDict objectForKey: @"id"] integerValue];
    NSString *key = [NSString stringWithFormat: @"%i", userUid];
    User *user = [[AllUserStore sharedStore].users objectForKey: key];
    if (!user) {
      user = [[User alloc] init];
      [user readFromDictionary: userDict];
    }
    [self addUserToTutors: user];
  }
}

@end
