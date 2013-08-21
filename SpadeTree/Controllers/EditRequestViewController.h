//
//  EditRequestViewController.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 8/2/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "SpadeTreeViewController.h"

@class TextFieldPadding;

@interface EditRequestViewController : SpadeTreeViewController
<UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>
{
  TextFieldPadding *addressTextField;
  Choice *choice;
  TextFieldPadding *cityTextField;
  UILabel *dateLabel;
  NSMutableArray *dates;
  UIPickerView *datePickerView;
  int selectedDateIndex;
  TextFieldPadding *stateTextField;
}

#pragma mark - Initializer

- (id) initWithChoice: (Choice *) choiceObject;

@end
