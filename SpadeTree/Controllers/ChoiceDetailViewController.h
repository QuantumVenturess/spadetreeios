//
//  ChoiceDetailViewController.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 8/1/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "SpadeTreeTableViewController.h"

@class Choice;
@class SpadeTreeNavigationController;

@interface ChoiceDetailViewController : SpadeTreeTableViewController
{
  UIButton *acceptButton;
  UILabel *acceptButtonLabel;
  UILabel *addressLabel;
  Choice *choice;
  UILabel *cityStateLabel;
  UILabel *completedLabel;
  UILabel *dateLabel;
  UIButton *denyButton;
  UILabel *denyButtonLabel;
  SpadeTreeNavigationController *editRequestNav;
  UIButton *phoneButton;
  UILabel *phoneButtonLabel;
  UILabel *phoneLabel;
}

#pragma mark - Initializer

- (id) initWithChoice: (Choice *) choiceObject;

@end
