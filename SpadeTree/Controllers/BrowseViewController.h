//
//  BrowseViewController.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 6/27/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "SpadeTreeTableViewController.h"

@class TextFieldPadding;

@interface BrowseViewController : SpadeTreeTableViewController
<UITextFieldDelegate>

@property (nonatomic, strong) TextFieldPadding *searchField;

@end
