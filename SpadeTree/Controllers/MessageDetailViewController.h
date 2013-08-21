//
//  MessageDetailViewController.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/30/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "SpadeTreeTableViewController.h"

@class Message;

@interface MessageDetailViewController : SpadeTreeTableViewController
<UITextViewDelegate>
{
  UIButton *contentButton;
  UITextView *contentTextView;
  UIView *contentTextBox;
  Message *message;
  NSString *textViewPlaceholder;

  BOOL tableFrameShifted;
}

#pragma mark - Initializer

- (id) initWithMessage: (Message *) messageObject;

@end
