//
//  HourBoxButton.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/17/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Hour;
@class HourFree;

@interface HourBoxButton : UIButton

@property (nonatomic, strong) Hour *hour;
@property (nonatomic, strong) HourFree *hourFree;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic) BOOL selected;

#pragma mark - Initializer

- (id) initWithHour: (Hour *) hourObject;
- (id) initWithHourFree: (HourFree *) hourFreeObject;

#pragma mark - Methods

- (void) select;
- (void) unselect;

@end
