//
//  Day.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/17/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Day : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic) int uid;
@property (nonatomic) int value;

#pragma mark - Methods

- (NSString *) nameTitle;
- (void) readFromDictionary: (NSDictionary *) dictionary;

@end
