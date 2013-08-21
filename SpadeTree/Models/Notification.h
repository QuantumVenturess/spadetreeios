//
//  Notification.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 8/5/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Choice;
@class Interest;
@class User;

@interface Notification : NSObject

@property (nonatomic, strong) Choice *choice;
@property (nonatomic) NSTimeInterval created;
@property (nonatomic, strong) Interest *interest;
@property (nonatomic, strong) NSString *message;
@property (nonatomic) int uid;
@property (nonatomic, strong) User *user;

#pragma mark - Methods

- (void) readFromDictionary: (NSDictionary *) dictionary;

@end
