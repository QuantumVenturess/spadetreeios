//
//  User.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 6/28/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const AppTokenReceivedNotification;

@class City;
@class Day;
@class Hour;
@class Interest;
@class Review;
@class State;

@interface User : NSObject

@property (nonatomic, strong) NSString *about;
@property (nonatomic, strong) NSString *accessToken;
@property (nonatomic, strong) NSString *appToken;
@property (nonatomic, strong) City *city;
@property (nonatomic, strong) NSString *email;
@property (nonatomic) double facebookId;
@property (nonatomic, strong) NSString *facebookLink;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *location;
@property (nonatomic) double phone;
@property (nonatomic) BOOL readTutorial;
@property (nonatomic) BOOL tutee;
@property (nonatomic) BOOL tutor;
@property (nonatomic) int uid;
// iOS
@property (nonatomic, strong) NSMutableArray *daysFree;
@property (nonatomic, strong) NSMutableDictionary *friendsTutored;
@property (nonatomic, strong) NSMutableArray *hoursFreeAm;
@property (nonatomic, strong) NSMutableArray *hoursFreePm;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSMutableArray *reviews;
@property (nonatomic, strong) NSMutableArray *skills;
@property (nonatomic, strong) State *state;
@property (nonatomic) NSTimeInterval updated;

#pragma mark - Methods

+ (User *) currentUser;

- (void) addFreeDay: (Day *) day;
- (void) addFreeHour: (Hour *) hour;
- (void) addNewReview: (Review *) review;
- (void) addSkill: (Interest *) interest;
- (void) downloadImage: (void (^) (NSError *error)) block;
- (NSArray *) friendsTutoredSortedByName;
- (NSString *) fullName;
- (void) getAccessToken: (NSDictionary *) dictionary;
- (UIImage *) imageWithSize: (CGSize) size;
- (NSURL *) imageURL;
- (NSString *) locationString;
- (void) readFromDictionary: (NSDictionary *) dictionary;
- (void) readFromDictionaryDaysAndHours: (NSDictionary *) dictionary;
- (void) readFromDictionaryFriendsTutored: (NSDictionary *) dictionary;
- (void) readFromDictionaryReviews: (NSDictionary *) dictionary;
- (void) readFromDictionarySkills: (NSDictionary *) dictionary;
- (BOOL) recentlyUpdated;
- (void) removeFreeDay: (Day *) day;
- (void) removeFreeHour: (Hour *) hour;
- (void) removeSkill: (Interest *) interest;
- (NSString *) pushNotificationChannelForAllChoices;
- (void) signOut;
- (NSString *) slug;
- (void) subscribeToChoicesChannel;

@end
