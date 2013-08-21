//
//  TutorialStartView.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 8/7/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "ReadTutorialConnection.h"
#import "TutorialStartView.h"
#import "UIColor+Extensions.h"
#import "User.h"

@implementation TutorialStartView

@synthesize viewController;

#pragma mark - Initializer

- (id) init
{
  self = [super init];
  if (self) {
    CGRect screen = [[UIScreen mainScreen] bounds];
    float screenHeight = screen.size.height - 20;
    self.backgroundColor = [UIColor clearColor];
    self.frame = screen;
    startButton = [[UIButton alloc] init];
    startButton.backgroundColor = [UIColor clearColor];
    startButton.frame = CGRectMake(((screen.size.width - 177) / 2.0),
      ((screenHeight - 34) / 2.0), 200, 34);
    [startButton addTarget: self action: @selector(hide)
      forControlEvents: UIControlEventTouchUpInside];
    [self addSubview: startButton];
  }
  return self;
}

#pragma mark - Methods

- (void) hide
{
  if (![User currentUser].readTutorial) {
    [User currentUser].readTutorial = YES;
    [[[ReadTutorialConnection alloc] init] start];
  }
  [self.viewController dismissViewControllerAnimated: YES 
    completion: nil];
}

@end
