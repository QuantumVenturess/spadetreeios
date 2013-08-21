//
//  MessageListStore.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/30/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "AppDelegate.h"
#import "Message.h"
#import "MessageListStore.h"
#import "User.h"

@implementation MessageListStore

@synthesize messages;

#pragma mark - Initializer

- (id) init
{
  self = [super init];
  if (self) {
    self.messages = [NSMutableArray array];
    [[NSNotificationCenter defaultCenter] addObserver: self
      selector: @selector(signOut) name: CurrentUserSignOut object: nil];
  }
  return self;
}

#pragma mark - Getters

- (NSMutableArray *) messages
{
  return [self messagesSortedByCreated];
}

#pragma mark - Methods

+ (MessageListStore *) sharedStore
{
  static MessageListStore *store = nil;
  if (!store) {
    store = [[MessageListStore alloc] init];
  }
  return store;
}

- (void) addMessage: (Message *) message
{
  NSPredicate *predicate = [NSPredicate predicateWithFormat:
    @"%K != %i", @"sender.uid", message.sender.uid];
  NSArray *array = [messages filteredArrayUsingPredicate: predicate];
  messages = [NSMutableArray arrayWithArray: array];
  [messages addObject: message];
}

- (NSMutableArray *) messagesSortedByCreated
{
  NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey: @"created"
    ascending: NO];
  return (NSMutableArray *) [messages sortedArrayUsingDescriptors:
    [NSArray arrayWithObject: sort]];
}

- (void) signOut
{
  [messages removeAllObjects];
}

- (int) unviewedMessagesCount
{
  NSPredicate *predicate = [NSPredicate predicateWithFormat: 
    @"%K == %@", @"viewed", [NSNumber numberWithBool: NO]];
  NSArray *array = [messages filteredArrayUsingPredicate: predicate];
  return array.count;
}

@end
