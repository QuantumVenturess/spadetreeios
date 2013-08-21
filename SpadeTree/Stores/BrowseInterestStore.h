//
//  BrowseInterestStore.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/9/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Interest;

@interface BrowseInterestStore : NSObject

@property (nonatomic, strong) NSMutableArray *interests;
@property (nonatomic, weak) id viewController;

#pragma mark - Methods

+ (BrowseInterestStore *) sharedStore;

- (void) addInterest: (Interest *) interest;
- (void) fetchPage: (int) page completion: (void (^) (NSError *)) block;
- (NSArray *) group;
- (void) readFromDictionary: (NSDictionary *) dictionary;

@end
