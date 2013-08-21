//
//  StateStore.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/10/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import <Foundation/Foundation.h>

@class State;

@interface StateStore : NSObject

@property (nonatomic, strong) NSMutableDictionary *states;

#pragma mark - Methods

+ (StateStore *) sharedStore;

- (void) addState: (State *) state;

@end
