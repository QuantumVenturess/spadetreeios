//
//  AllInterestStore.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/12/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Interest;

@interface AllInterestStore : NSObject

@property (nonatomic, strong) NSMutableDictionary *interests;

#pragma mark - Methods

+ (AllInterestStore *) sharedStore;

- (NSArray *) allInterests;
- (void) addInterest: (Interest *) interest;
- (Interest *) interestForName: (NSString *) name;
- (void) readFromDictionary: (NSDictionary *) dictionary;

@end
