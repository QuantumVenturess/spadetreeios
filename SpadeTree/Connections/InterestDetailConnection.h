//
//  InterestDetailConnection.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/10/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "SpadeTreeConnection.h"

@class Interest;

@interface InterestDetailConnection : SpadeTreeConnection

@property (nonatomic, weak) Interest *interest;

#pragma mark - Initializer

- (id) initWithInterest: (Interest *) interestObject;

@end
