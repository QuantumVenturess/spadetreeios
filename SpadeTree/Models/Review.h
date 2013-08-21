//
//  Review.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/12/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;

@interface Review : NSObject

@property (nonatomic, strong) NSString *content;
@property (nonatomic) NSTimeInterval created;
@property (nonatomic) BOOL positive;
@property (nonatomic, strong) User *tutee;
@property (nonatomic, strong) User *tutor;
@property (nonatomic) int uid;

#pragma mark - Methods

- (NSString *) createdDateStringShort;
- (void) readFromDictionary: (NSDictionary *) dictionary;

@end
