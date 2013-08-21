//
//  InterestBrowseSearchConnection.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/10/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "SpadeTreeConnection.h"

extern NSMutableArray *browseSearchConnectionList;

@interface InterestBrowseSearchConnection : SpadeTreeConnection

#pragma mark - Initializer

- (id) initWithTerm: (NSString *) term;

@end
