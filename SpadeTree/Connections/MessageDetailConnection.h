//
//  MessageDetailConnection.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/30/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "SpadeTreeConnection.h"

@class Message;

@interface MessageDetailConnection : SpadeTreeConnection
{
  Message *message;
}

#pragma mark - Initializer

- (id) initWithMessage: (Message *) messageObject;

@end
