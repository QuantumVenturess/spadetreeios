//
//  UserReviewsConnection.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/12/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "SpadeTreeConnection.h"

@class User;

@interface UserReviewsConnection : SpadeTreeConnection

@property (nonatomic, weak) User *user;

#pragma mark - Initializer

- (id) initWithUser: (User *) userObject;

@end
