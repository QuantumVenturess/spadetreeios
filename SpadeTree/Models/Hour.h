//
//  Hour.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/17/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Hour : NSObject

@property (nonatomic) int uid;
@property (nonatomic) int value;

#pragma mark - Methods

- (NSString *) hourAndAmPm;
- (int) hourOfDay;
- (void) readFromDictionary: (NSDictionary *) dictionary;

@end
