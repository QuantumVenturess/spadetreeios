//
//  ChoiceNotesConnection.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 8/5/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "Choice.h"
#import "ChoiceNotesConnection.h"

@implementation ChoiceNotesConnection

#pragma mark - Initializer

- (id) initWithChoice: (Choice *) choiceObject
{
  self = [super init];
  if (self) {
    choice = choiceObject;
    NSString *string = [NSString stringWithFormat:
      @"%@/c/%i/notes.json/?spadetree_token=%@",
        SpadeTreeApiURL, choice.uid, [User currentUser].appToken];
    [self setRequestFromString: string];
  }
  return self;
}

#pragma mark - Protocol NSURLConnectionDataDelegate

- (void) connectionDidFinishLoading: (NSURLConnection *) connection
{
  NSDictionary *json = [NSJSONSerialization JSONObjectWithData: container
    options: 0 error: nil];
  [choice readFromDictionaryNotes: json];
  [super connectionDidFinishLoading: connection];
}

@end
