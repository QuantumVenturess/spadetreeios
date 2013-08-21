//
//  SkillBoxButton.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/16/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Interest;

@interface SkillBoxButton : UIButton

@property (nonatomic, weak) Interest *interest;
@property (nonatomic, strong) UILabel *nameLabel;

#pragma mark - Initializer

- (id) initWithInterest: (Interest *) interestObject;

@end
