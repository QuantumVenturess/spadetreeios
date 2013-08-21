//
//  ChoiceNoteCell.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 8/5/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ChoiceNote;

@interface ChoiceNoteCell : UITableViewCell
{
  ChoiceNote *choiceNote;
  UILabel *contentLabel;
  UILabel *createdLabel;
  UIImageView *imageView;
  UILabel *nameLabel;
}

#pragma mark - Methods

- (void) loadChoiceNoteData: (ChoiceNote *) choiceNoteObject;

@end
