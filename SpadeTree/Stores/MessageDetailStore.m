//
//  MessageDetailStore.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/30/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "AppDelegate.h"
#import "Message.h"
#import "MessageDetailStore.h"
#import "User.h"

@implementation MessageDetailStore

@synthesize messages;

#pragma mark - Initializer

- (id) init
{
  self = [super init];
  if (self) {
    self.messages = [NSMutableDictionary dictionary];
    [[NSNotificationCenter defaultCenter] addObserver: self
      selector: @selector(signOut) name: CurrentUserSignOut object: nil];
  }
  return self;
}

#pragma mark - Methods

+ (MessageDetailStore *) sharedStore;
{
  static MessageDetailStore *store = nil;
  if (!store) {
    store = [[MessageDetailStore alloc] init];
  }
  return store;
}

- (void) addMessageFromRecipient: (Message *) message
{
  NSString *key = [NSString stringWithFormat: @"%i", message.recipient.uid];
  NSMutableArray *array = [self.messages objectForKey: key];
  if (!array) {
    array = [NSMutableArray array];
  }
  NSPredicate *predicate = [NSPredicate predicateWithFormat:
    @"%K == %i", @"uid", message.uid];
  NSArray *filtered = [array filteredArrayUsingPredicate: predicate];
  if (filtered.count == 0) {
    [array addObject: message];
  }
  [self.messages setObject: array forKey: key];
}

- (void) addMessageFromSender: (Message *) message
{
  NSString *key = [NSString stringWithFormat: @"%i", message.sender.uid];
  NSMutableArray *array = [self.messages objectForKey: key];
  if (!array) {
    array = [NSMutableArray array];
  }
  NSPredicate *predicate = [NSPredicate predicateWithFormat:
    @"%K == %i", @"uid", message.uid];
  NSArray *filtered = [array filteredArrayUsingPredicate: predicate];
  if (filtered.count == 0) {
    [array addObject: message];
  }
  [self.messages setObject: array forKey: key];
}

- (NSArray *) messagesForUser: (User *) user
{
  NSMutableArray *array = [self.messages objectForKey:
    [NSString stringWithFormat: @"%i", user.uid]];
  if (array) {
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey: @"created"
      ascending: YES];
    return [array sortedArrayUsingDescriptors: [NSArray arrayWithObject: sort]];
  }
  return array;
}

- (void) signOut
{
  [self.messages removeAllObjects];
}

@end
