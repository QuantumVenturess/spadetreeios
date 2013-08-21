//
//  DayFreeConnection.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/19/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "SpadeTreeConnection.h"

@class Day;

@interface DayFreeConnection : SpadeTreeConnection

#pragma mark - Initializer

- (id) initWithDay: (Day *) dayObject;

@end
