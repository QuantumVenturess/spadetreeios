//
//  HourFreeConnection.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/19/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "SpadeTreeConnection.h"

@class Hour;

@interface HourFreeConnection : SpadeTreeConnection

#pragma mark - Initializer

- (id) initWithHour: (Hour *) hourObject;

@end
