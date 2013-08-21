//
//  AllUserStore.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/10/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;

@interface AllUserStore : NSObject

@property (nonatomic, strong) NSMutableDictionary *users;

#pragma mark - Methods

+ (AllUserStore *) sharedStore;

- (void) addUser: (User *) user;

@end
