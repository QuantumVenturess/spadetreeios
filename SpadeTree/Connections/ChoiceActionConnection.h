//
//  ChoiceActionConnection.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 8/2/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "SpadeTreeConnection.h"

@class Choice;

@interface ChoiceActionConnection : SpadeTreeConnection
{
  Choice *choice;
}

#pragma mark - Initializer

- (id) initWithChoice: (Choice *) choiceObject;

@end
