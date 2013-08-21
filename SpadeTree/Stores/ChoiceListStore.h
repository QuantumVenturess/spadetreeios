//
//  ChoiceListStore.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 8/1/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Choice;

@interface ChoiceListStore : NSObject

@property (nonatomic, strong) NSMutableArray *choices;
@property (nonatomic, weak) id viewController;

#pragma mark - Methods

+ (ChoiceListStore *) sharedStore;

- (void) addChoice: (Choice *) choice;
- (Choice *) choiceForId: (int) choiceId;
- (void) fetchPage: (int) page completion: (void (^) (NSError *error)) block;
- (void) readFromDictionary: (NSDictionary *) dictionary;

@end
