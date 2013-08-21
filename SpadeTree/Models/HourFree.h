//
//  HourFree.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/17/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Hour;

@interface HourFree : NSObject

@property (nonatomic, strong) Hour *hour;
@property (nonatomic) int uid;
@property (nonatomic) int value;

#pragma mark - Methods

- (void) readFromDictionary: (NSDictionary *) dictionary;

@end
