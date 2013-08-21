//
//  ChooseTutorConnection.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/17/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "SpadeTreeConnection.h"

@class Choice;
@class DayFree;
@class HourFree;

@interface ChooseTutorConnection : SpadeTreeConnection
{
  Choice *choice;
}

#pragma mark - Initializer

- (id) initWithDayFree: (DayFree *) dayFree hourFree: (HourFree *) hourFree 
choice: (Choice *) choiceObject;

@end
