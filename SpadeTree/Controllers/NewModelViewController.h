//
//  NewModelViewController.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 8/5/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "SpadeTreeViewController.h"

@interface NewModelViewController : SpadeTreeViewController
{
  UITextView *contentTextView;
  UIView *contentView;
}

#pragma mark - Methods

- (void) cancel;
- (void) submit;

@end
