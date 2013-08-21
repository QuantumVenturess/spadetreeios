//
//  ChoiceListCell.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 8/1/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Choice;

@interface ChoiceListCell : UITableViewCell
{
  Choice *choice;
  UILabel *contentLabel;
  UILabel *createdLabel;
  UIImageView *imageView;
  UILabel *interestLabel;
  UILabel *nameLabel;
  UILabel *statusLabel;
}

#pragma mark - Methods

- (void) loadChoiceData: (Choice *) choiceObject;

@end
