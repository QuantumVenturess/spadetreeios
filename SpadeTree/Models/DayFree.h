//
//  DayFree.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/17/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Day;

@interface DayFree : NSObject

@property (nonatomic, strong) Day *day;
@property (nonatomic) int uid;
// iOS
@property (nonatomic) int value;

#pragma mark - Methods

- (void) readFromDictionary: (NSDictionary *) dictionary;

@end
