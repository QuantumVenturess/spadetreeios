//
//  AllUserStore.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/10/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "AllUserStore.h"
#import "AppDelegate.h"
#import "User.h"

@implementation AllUserStore

@synthesize users;

#pragma mark - Initializer

- (id) init
{
  self = [super init];
  if (self) {
    self.users = [NSMutableDictionary dictionary];
    [[NSNotificationCenter defaultCenter] addObserver: self
      selector: @selector(signOut) name: CurrentUserSignOut object: nil];
  }
  return self;
}

#pragma mark - Methods

+ (AllUserStore *) sharedStore
{
  static AllUserStore *store = nil;
  if (!store) {
    store = [[AllUserStore alloc] init];
  }
  return store;
}

- (void) addUser: (User *) user
{
  [self.users setObject: user forKey: 
    [NSString stringWithFormat: @"%i", user.uid]];
}

- (void) signOut
{
  [self.users removeAllObjects];
}

@end
