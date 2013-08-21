//
//  NewChoiceNoteConnection.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 8/5/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "SpadeTreeConnection.h"

@class ChoiceNote;

@interface NewChoiceNoteConnection : SpadeTreeConnection
{
  ChoiceNote *choiceNote;
}

#pragma mark - Initializer

- (id) initWithChoiceNote: (ChoiceNote *) choiceNoteObject;

@end
