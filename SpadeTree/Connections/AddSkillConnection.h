//
//  AddSkillConnection.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/18/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "SpadeTreeConnection.h"

@class Interest;

@interface AddSkillConnection : SpadeTreeConnection

@property (nonatomic, weak) Interest *interest;

#pragma mark - Initializer

- (id) initWithInterest: (Interest *) interestObject;

@end
