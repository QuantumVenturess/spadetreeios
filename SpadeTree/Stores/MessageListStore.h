//
//  MessageListStore.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/30/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Message;

@interface MessageListStore : NSObject

@property (nonatomic, strong) NSMutableArray *messages;

#pragma mark - Methods

+ (MessageListStore *) sharedStore;

- (void) addMessage: (Message *) message;
- (int) unviewedMessagesCount;

@end
