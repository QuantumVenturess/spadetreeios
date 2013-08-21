//
//  MessageDetailStore.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/30/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Message;
@class User;

@interface MessageDetailStore : NSObject

@property (nonatomic, strong) NSMutableDictionary *messages;

#pragma mark - Methods

+ (MessageDetailStore *) sharedStore;

- (void) addMessageFromRecipient: (Message *) message;
- (void) addMessageFromSender: (Message *) message;
- (NSArray *) messagesForUser: (User *) user;

@end
