//
//  NewChoiceNoteViewController.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 8/5/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "Choice.h"
#import "ChoiceNote.h"
#import "NewChoiceNoteConnection.h"
#import "NewChoiceNoteViewController.h"
#import "UIColor+Extensions.h"
#import "User.h"

@implementation NewChoiceNoteViewController

#pragma mark - Initializer

- (id) initWithChoice: (Choice *) choiceObject
{
  self = [super init];
  if (self) {
    choice     = choiceObject;
    self.title = @"Adding Note";
    self.trackedViewName = @"New Choice Note";
  }
  return self;
}

#pragma mark - Methods

- (void) submit
{
  NSString *content = [contentTextView.text stringByTrimmingCharactersInSet: 
    [NSCharacterSet whitespaceAndNewlineCharacterSet]];
  if (content.length > 0) {
    ChoiceNote *choiceNote = [[ChoiceNote alloc] init];
    choiceNote.choice  = choice;
    choiceNote.content = content;
    choiceNote.created = [[NSDate date] timeIntervalSince1970];
    choiceNote.uid     = 0;
    choiceNote.user    = [User currentUser];
    [choice addChoiceNote: choiceNote];
    [[[NewChoiceNoteConnection alloc] initWithChoiceNote: choiceNote] start];
    [self cancel];
  }
}

@end
