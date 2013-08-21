//
//  EditProfileViewController.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/17/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "SpadeTreeViewController.h"

@class Interest;
@class TextFieldPadding;

@interface EditProfileViewController : SpadeTreeViewController
<UIAlertViewDelegate, UIScrollViewDelegate, UITextFieldDelegate, 
UITextViewDelegate>
{
  UIView *aboutBox;
  UIView *aboutView;
  UITextView *aboutTextView;
  NSString *aboutTextViewPlaceholder;
  UIBarButtonItem *addBarButtonItem;
  UIAlertView *alertView;
  UIView *dayBox;
  UIView *daysView;
  UIBarButtonItem *doneBarButtonItem;
  UIView *hourBox;
  UIView *hoursView;
  NSArray *interests;
  TextFieldPadding *locationCityField;
  TextFieldPadding *locationStateField;
  UIView *locationView;
  TextFieldPadding *phoneField;
  UIView *phoneView;
  UIScrollView *scroll;
  UIView *searchResults;
  UIView *skillBox;
  UIView *skillHeaderView;
  Interest *skillToRemove;
  NSMutableArray *subviews;

  BOOL keyboardShowing;
}

@property (nonatomic, strong) TextFieldPadding *searchField;

@end
