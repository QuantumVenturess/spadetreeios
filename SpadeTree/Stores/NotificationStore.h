//
//  NotificationStore.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 8/5/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Notification;

@interface NotificationStore : NSObject

@property (nonatomic, strong) NSMutableArray *notifications;
// @property (nonatomic, strong) NSMutableDictionary *notifications;

#pragma mark - Methods

+ (NotificationStore *) sharedStore;

- (void) addNotification: (Notification *) notification;
- (NSArray *) allDates;
- (void) readFromDictionary: (NSDictionary *) dictionary;

@end
