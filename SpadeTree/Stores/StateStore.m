//
//  StateStore.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/10/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "AppDelegate.h"
#import "State.h"
#import "StateStore.h"

@implementation StateStore

@synthesize states;

#pragma mark - Initializer

- (id) init
{
  self = [super init];
  if (self) {
    self.states = [NSMutableDictionary dictionary];
    [[NSNotificationCenter defaultCenter] addObserver: self
      selector: @selector(signOut) name: CurrentUserSignOut object: nil];
  }
  return self;
}

#pragma mark - Methods

+ (StateStore *) sharedStore
{
  static StateStore *store = nil;
  if (!store) {
    store = [[StateStore alloc] init];
  }
  return store;
}

- (void) addState: (State *) state
{
  [self.states setObject: state forKey: state.name];
}

- (void) signOut
{
  [self.states removeAllObjects];
}

@end
