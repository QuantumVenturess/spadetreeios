//
//  DayBoxButton.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/17/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Day;
@class DayFree;

@interface DayBoxButton : UIButton

@property (nonatomic, strong) Day *day;
@property (nonatomic, strong) DayFree *dayFree;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic) BOOL selected;

#pragma mark - Initializer

- (id) initWithDay: (Day *) dayObject;
- (id) initWithDayFree: (DayFree *) dayFreeObject;

#pragma mark - Methods

- (void) select;
- (void) unselect;

@end
