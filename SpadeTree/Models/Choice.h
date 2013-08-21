//
//  Choice.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 8/1/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ChoiceNote;
@class City;
@class Day;
@class Hour;
@class Interest;
@class User;

@interface Choice : NSObject

@property (nonatomic) BOOL accepted;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) City *city;
@property (nonatomic) BOOL completed;
@property (nonatomic) NSTimeInterval created;
@property (nonatomic, strong) NSString *content;
@property (nonatomic) NSTimeInterval date;
@property (nonatomic) NSTimeInterval dateCompleted;
@property (nonatomic, strong) Day *day;
@property (nonatomic) BOOL denied;
@property (nonatomic, strong) Hour *hour;
@property (nonatomic, strong) Interest *interest;
@property (nonatomic, strong) User *tutee;
@property (nonatomic) BOOL tuteeViewed;
@property (nonatomic, strong) User *tutor;
@property (nonatomic) BOOL tutorViewed;
// iOS
@property (nonatomic, strong) NSMutableArray *notes;
@property (nonatomic) double tuteePhone;
@property (nonatomic) double tutorPhone;
@property (nonatomic) int uid;

#pragma mark - Methods

- (void) addChoiceNote: (ChoiceNote *) choiceNoteObject;
- (NSString *) createdDateStringForList;
- (NSString *) dateCompletedStringForList;
- (NSString *) dateStringLong;
- (NSString *) dateStringNumbers;
- (void) readFromDictionary: (NSDictionary *) dictionary;
- (void) readFromDictionaryNotes: (NSDictionary *) dictionary;
- (void) sendPushNotificationToTutee;
- (void) sendPushNotificationToTutor;
- (void) subscribeToChannel;
- (void) updateFromChoice: (Choice *) choice;

@end
