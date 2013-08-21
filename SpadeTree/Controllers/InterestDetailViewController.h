//
//  InterestDetailViewController.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/10/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "SpadeTreeTableViewController.h"

@class Interest;

@interface InterestDetailViewController : SpadeTreeTableViewController

@property (nonatomic, strong) Interest *interest;

#pragma mark - Initializer

- (id) initWithInterest: (Interest *) interestObject;

@end
