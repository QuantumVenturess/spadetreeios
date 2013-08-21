//
//  Message.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/30/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;

@interface Message : NSObject

@property (nonatomic) NSTimeInterval created;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) User *recipient;
@property (nonatomic, strong) User *sender;
@property (nonatomic) int uid;
@property (nonatomic) BOOL viewed;

#pragma mark - Methods

- (NSString *) createdDateStringForDetail;
- (NSString *) createdDateStringForList;
- (void) readFromDictionary: (NSDictionary *) dictionary;

@end
