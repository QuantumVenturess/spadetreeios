//
//  TuteeSearchTutorialView.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 8/7/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TextFieldPadding;

@interface TuteeSearchTutorialView : UIView

@property (nonatomic, strong) UIView *cursor;
@property (nonatomic, strong) UILabel *info;
@property (nonatomic, strong) UIView *interestView1;
@property (nonatomic, strong) UIView *interestView2;
@property (nonatomic, strong) TextFieldPadding *searchField;

@end
