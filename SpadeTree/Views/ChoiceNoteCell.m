//
//  ChoiceNoteCell.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 8/5/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "ChoiceNote.h"
#import "ChoiceNoteCell.h"
#import "UIColor+Extensions.h"
#import "User.h"

@implementation ChoiceNoteCell

#pragma mark - Initializer

- (id) initWithStyle: (UITableViewCellStyle) style
reuseIdentifier: (NSString *) reuseIdentifier
{
  self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
  if (self) {
    UIFont *font = [UIFont fontWithName: @"HelveticaNeue" size: 14];
    CGRect screen = [[UIScreen mainScreen] bounds];
    // Properties
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    UIView *mainView = [[UIView alloc] init];
    mainView.backgroundColor = [UIColor clearColor];
    mainView.frame = CGRectMake(0, 0, screen.size.width, 90);
    [self.contentView addSubview: mainView];
    // Image view
    imageView = [[UIImageView alloc] init];
    imageView.clipsToBounds = YES;
    imageView.contentMode = UIViewContentModeTopLeft;
    imageView.frame = CGRectMake(10, 10, 40, 40);
    [mainView addSubview: imageView];
    // Name
    nameLabel = [[UILabel alloc] init];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.font = font;
    nameLabel.frame = CGRectMake((10 + 40 + 10), 10, 
      (screen.size.width - (10 + 40 + 10 + 10)), 20);
    nameLabel.textColor = [UIColor gray: 50];
    [mainView addSubview: nameLabel];
    // Created
    createdLabel = [[UILabel alloc] init];
    createdLabel.backgroundColor = [UIColor clearColor];
    createdLabel.font = font;
    createdLabel.frame = CGRectMake((10 + 40 + 10), (10 + 20),
      (screen.size.width - (10 + 40 + 10 + 10)), 20);
    createdLabel.textColor = [UIColor gray: 150];
    [mainView addSubview: createdLabel];
    // Content
    contentLabel = [[UILabel alloc] init];
    contentLabel.backgroundColor = [UIColor clearColor];
    contentLabel.font = font;
    contentLabel.frame = CGRectMake(10, (10 + 40 + 10), 
      (screen.size.width - 20), 20);
    contentLabel.numberOfLines = 0;
    contentLabel.textColor = [UIColor gray: 50];
    [mainView addSubview: contentLabel];
  }
  return self;
}

#pragma mark - Methods

- (void) loadChoiceNoteData: (ChoiceNote *) choiceNoteObject
{
  choiceNote = choiceNoteObject;
  // Image view
  if (choiceNote.user.image) {
    imageView.image = [choiceNote.user imageWithSize: CGSizeMake(40, 40)];
  }
  else {
    [choiceNote.user downloadImage: ^(NSError *error) {
      if (!error) {
        imageView.image = [choiceNote.user imageWithSize: CGSizeMake(40, 40)];
      }
    }];
    imageView.image = [UIImage imageNamed: @"placeholder.png"];
  }
  // Name
  nameLabel.text = [choiceNote.user fullName];
  // Created
  createdLabel.text = [choiceNote createdDateString];
  // Content
  contentLabel.text = choiceNote.content;
  CGSize maxSize = CGSizeMake(contentLabel.frame.size.width, 1000);
  CGSize textSize = [contentLabel.text sizeWithFont: contentLabel.font
    constrainedToSize: maxSize];
  CGRect frame = contentLabel.frame;
  frame.size.height = textSize.height;
  contentLabel.frame = frame;
}

@end
