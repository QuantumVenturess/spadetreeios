//
//  NewModelViewController.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 8/5/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "NewModelViewController.h"
#import "UIColor+Extensions.h"

@implementation NewModelViewController

#pragma mark - Override UIViewController

- (void) loadView
{
  [super loadView];
  CGRect screen = [[UIScreen mainScreen] bounds];
  // Navigation
  UIFont *font14 = [UIFont fontWithName: @"HelveticaNeue" size: 14];
  CGSize maxSize = CGSizeMake(screen.size.width, 18);
  // cancel
  NSString *cancelString = @"Cancel";
  CGSize textSize = [cancelString sizeWithFont: font14
    constrainedToSize: maxSize];
  UILabel *cancelLabel = [[UILabel alloc] init];
  cancelLabel.backgroundColor = [UIColor clearColor];
  cancelLabel.font = font14;
  cancelLabel.frame = CGRectMake(5, 0, textSize.width, textSize.height);
  cancelLabel.text = cancelString;
  cancelLabel.textColor = [UIColor whiteColor];
  UIButton *cancelButton = [[UIButton alloc] init];
  cancelButton.frame = CGRectMake(0, 0, textSize.width + 5, textSize.height);
  [cancelButton addTarget: self action: @selector(cancel)
    forControlEvents: UIControlEventTouchUpInside];
  [cancelButton addSubview: cancelLabel];
  self.navigationItem.leftBarButtonItem = 
    [[UIBarButtonItem alloc] initWithCustomView: cancelButton];
  // submit
  NSString *submitString = @"Submit";
  textSize = [submitString sizeWithFont: font14
    constrainedToSize: maxSize];
  UILabel *submitLabel = [[UILabel alloc] init];
  submitLabel.backgroundColor = [UIColor clearColor];
  submitLabel.font = font14;
  submitLabel.frame = CGRectMake(0, 0, textSize.width, textSize.height);
  submitLabel.text = submitString;
  submitLabel.textColor = [UIColor whiteColor];
  UIButton *submitButton = [[UIButton alloc] init];
  submitButton.frame = CGRectMake(0, 0, textSize.width + 5, textSize.height);
  [submitButton addTarget: self action: @selector(submit)
    forControlEvents: UIControlEventTouchUpInside];
  [submitButton addSubview: submitLabel];
  self.navigationItem.rightBarButtonItem = 
    [[UIBarButtonItem alloc] initWithCustomView: submitButton];
  // Main
  UIView *mainView = [[UIView alloc] initWithFrame: screen];
  mainView.backgroundColor = [UIColor whiteColor];
  self.view = mainView;
  // Content
  // view
  contentView = [[UIView alloc] init];
  contentView.backgroundColor = [UIColor clearColor];
  contentView.frame = CGRectMake(10, 10, (screen.size.width - 20), 
    (screen.size.height - (20 + 44 + 10 + 10 + 216)));
  contentView.layer.borderColor = [UIColor blackColor].CGColor;
  contentView.layer.borderWidth = 1;
  [self.view addSubview: contentView];
  // text view
  contentTextView = [[UITextView alloc] init];
  // original insets (-8, -8, -8, -8)
  contentTextView.backgroundColor = [UIColor clearColor];
  contentTextView.contentInset = UIEdgeInsetsMake(-8, -8, -8, -8);
  // contentTextView.delegate = self;
  contentTextView.frame = CGRectMake(10, 10, 
    (contentView.frame.size.width - 20), (contentView.frame.size.height - 20));
  contentTextView.font = [UIFont fontWithName: @"HelveticaNeue" size: 15];
  contentTextView.textColor = [UIColor gray: 50];
  [contentView addSubview: contentTextView];
}

- (void) viewWillAppear: (BOOL) animated
{
  [super viewWillAppear: animated];
  [contentTextView becomeFirstResponder];
}

#pragma mark - Methods

- (void) cancel
{
  [self dismissViewControllerAnimated: YES completion: ^(void) {
    contentTextView.text = @"";
  }];
}

- (void) submit
{
  // Subclasses implement this
}

@end
