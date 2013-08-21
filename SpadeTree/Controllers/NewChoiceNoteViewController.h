//
//  NewChoiceNoteViewController.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 8/5/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "NewModelViewController.h"

@class Choice;

@interface NewChoiceNoteViewController : NewModelViewController
{
  Choice *choice;
}

#pragma mark - Initializer

- (id) initWithChoice: (Choice *) choiceObject;

@end
