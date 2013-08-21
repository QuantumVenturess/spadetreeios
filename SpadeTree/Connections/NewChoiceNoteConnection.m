//
//  NewChoiceNoteConnection.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 8/5/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "Choice.h"
#import "ChoiceNote.h"
#import "NewChoiceNoteConnection.h"

@implementation NewChoiceNoteConnection

#pragma mark - Initializer

- (id) initWithChoiceNote: (ChoiceNote *) choiceNoteObject
{
  self = [super init];
  if (self) {
    choiceNote = choiceNoteObject;
    NSString *string = [NSString stringWithFormat:
      @"%@/c/%i/new/note.json/", SpadeTreeApiURL, choiceNote.choice.uid];
    NSURL *url = [NSURL URLWithString: string];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL: url];
    NSString *params = [NSString stringWithFormat:
      @"spadetree_token=%@&"
      @"content=%@",
      [User currentUser].appToken,
      choiceNote.content
    ];
    [req setHTTPBody: [params dataUsingEncoding: NSUTF8StringEncoding]];
    [req setHTTPMethod: @"POST"];
    self.request = req;
  }
  return self;
}

#pragma mark - Protocol NSURLConnectionDataDelegate

- (void) connectionDidFinishLoading: (NSURLConnection *) connection
{
  NSDictionary *json = [NSJSONSerialization JSONObjectWithData: container
    options: 0 error: nil];
  choiceNote.uid = 
    [[[json objectForKey: @"choice_note"] objectForKey: @"id"] integerValue];
  [super connectionDidFinishLoading: connection];
}

@end
