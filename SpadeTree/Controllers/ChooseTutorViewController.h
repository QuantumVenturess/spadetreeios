//
//  ChooseTutorViewController.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/16/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "SpadeTreeViewController.h"

@class DayFree;
@class HourFree;
@class Interest;
@class User;

@interface ChooseTutorViewController : SpadeTreeViewController
{
  DayFree *dayFree;
  UIView *dayBox;
  UIView *chooseDayView;
  UIView *chooseHourView;
  HourFree *hourFree;
  UIView *hourBox;
  Interest *interest;
  UIScrollView *scroll;
  UIView *skillBox;
  NSMutableArray *subviews;
}

@property (nonatomic, strong) User *user;

#pragma mark - Initializer

- (id) initWithUser: (User *) userObject;

#pragma mark - Methods

- (void) refreshViews;

@end
