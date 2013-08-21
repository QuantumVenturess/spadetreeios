//
//  HourStore.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/19/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Hour;

@interface HourStore : NSObject

@property (nonatomic, strong) NSArray *hours;

#pragma mark - Methods

+ (HourStore *) sharedStore;

- (Hour *) hourForValue: (int) value;

@end
