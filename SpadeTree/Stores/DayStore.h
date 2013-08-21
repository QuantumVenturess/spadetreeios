//
//  DayStore.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/19/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Day;

@interface DayStore : NSObject

@property (nonatomic, strong) NSArray *days;

#pragma mark - Methods

+ (DayStore *) sharedStore;

- (Day *) dayForValue: (int) value;

@end
