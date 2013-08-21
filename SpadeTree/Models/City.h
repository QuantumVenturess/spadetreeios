//
//  City.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/10/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import <Foundation/Foundation.h>

@class State;

@interface City : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *slug;
@property (nonatomic, weak) State *state;
@property (nonatomic) int uid;

#pragma mark - Methods

- (NSString *) nameTitle;
- (void) readFromDictionary: (NSDictionary *) dictionary;

@end
