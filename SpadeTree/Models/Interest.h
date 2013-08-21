//
//  Interest.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/9/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;

@interface Interest : NSObject

@property (nonatomic) NSTimeInterval created;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *slug;
@property (nonatomic, strong) NSMutableArray *tutees;
@property (nonatomic, strong) NSMutableArray *tutors;
@property (nonatomic) int uid;

#pragma mark - Methods

- (void) addUserToTutees: (User *) user;
- (void) addUserToTutors: (User *) user;
- (NSString *) nameTitle;
- (void) readFromDictionary: (NSDictionary *) dictionary;
- (void) readFromDictionaryDetail: (NSDictionary *) dictionary;

@end
