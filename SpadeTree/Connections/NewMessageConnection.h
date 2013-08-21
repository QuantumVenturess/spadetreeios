//
//  NewMessageConnection.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 8/1/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "SpadeTreeConnection.h"

@class Message;

@interface NewMessageConnection : SpadeTreeConnection
{
  Message *message;
}

#pragma mark - Initializer

- (id) initWithMessage: (Message *) messageObject;

@end
