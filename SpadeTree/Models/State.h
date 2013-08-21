//
//  State.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/10/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import <Foundation/Foundation.h>

@class City;

@interface State : NSObject

@property (nonatomic, strong) NSMutableDictionary *cities;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *slug;
@property (nonatomic) int uid;

#pragma mark - Methods

- (void) addCity: (City *) city;
- (NSString *) nameTitle;
- (void) readFromDictionary: (NSDictionary *) dictionary;

@end
