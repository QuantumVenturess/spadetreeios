//
//  ChoiceNote.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 8/5/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Choice;
@class User;

@interface ChoiceNote : NSObject

@property (nonatomic, weak) Choice *choice;
@property (nonatomic, strong) NSString *content;
@property (nonatomic) NSTimeInterval created;
@property (nonatomic) int uid;
@property (nonatomic, strong) User *user;

#pragma mark - Methods

- (NSString *) createdDateString;
- (void) readFromDictionary: (NSDictionary *) dictionary;

@end
