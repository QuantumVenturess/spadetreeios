//
//  TuteeSearchTutorialView.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 8/7/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "TextFieldPadding.h"
#import "TuteeSearchTutorialView.h"
#import "UIColor+Extensions.h"

@implementation TuteeSearchTutorialView

@synthesize cursor;
@synthesize info;
@synthesize interestView1;
@synthesize interestView2;
@synthesize searchField;

#pragma mark - Initializer

- (id) init
{
  self = [super init];
  if (self) {
    CGRect screen = [[UIScreen mainScreen] bounds];
    float marginTop = 20;
    if (screen.size.height > 480) {
      marginTop = 40;
    }
    self.backgroundColor = [UIColor clearColor];
    self.frame = CGRectMake(0, 0, screen.size.width, 
      (screen.size.height - 100));
    // Top view
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor whiteColor];
    topView.frame = CGRectMake(0, 0, screen.size.width, 
      (84 + 60 + 60 + 60 + 20));
    [self addSubview: topView];
    // Search view
    UIView *searchView = [[UIView alloc] init];
    searchView.backgroundColor = [UIColor whiteColor];
    searchView.frame = CGRectMake(0, 0, screen.size.width, 84);
    [topView addSubview: searchView];
    // search field
    searchField = [[TextFieldPadding alloc] init];
    searchField.backgroundColor = [UIColor clearColor];
    searchField.clearButtonMode = UITextFieldViewModeWhileEditing;
    searchField.frame = CGRectMake(10, 20, (screen.size.width - 20), 44);
    searchField.font  = [UIFont fontWithName: @"HelveticaNeue" size: 15];
    searchField.layer.borderWidth = 1.0;
    searchField.layer.borderColor = [UIColor blackColor].CGColor;
    searchField.paddingX = 40;
    searchField.paddingY = 12;
    searchField.textColor = [UIColor gray: 50];
    searchField.userInteractionEnabled = NO;
    [searchView addSubview: searchField];
    self.cursor = [[UIView alloc] init];
    self.cursor.backgroundColor = [UIColor red];
    self.cursor.frame = CGRectMake((40 + 20), 12, 3, 20);
    self.cursor.layer.opacity = 0;
    [searchField addSubview: self.cursor];
    // search field image
    UIImageView *searchImage = [[UIImageView alloc] init];
    searchImage.alpha = 0.5;
    searchImage.frame = CGRectMake(10, 0, 20, 20);
    searchImage.image = [UIImage imageNamed: @"search_interest.png"];
    UIView *searchImageView = [[UIView alloc] init];
    searchImageView.frame = CGRectMake(0, 0, 20, 20);
    [searchImageView addSubview: searchImage];
    searchField.leftView = searchImageView;
    searchField.leftViewMode = UITextFieldViewModeAlways;

    // Letter header
    UIView *header = [[UIView alloc] init];
    header.backgroundColor = [UIColor clearColor];
    header.frame = CGRectMake(0, (searchView.frame.origin.y + 
      searchView.frame.size.height), screen.size.width, 60);
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [UIColor blackColor].CGColor;
    layer.frame = CGRectMake(0, 59, (screen.size.width - 0), 1);
    [header.layer addSublayer: layer];
    [topView addSubview: header];
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.frame = CGRectMake(20, 10, (screen.size.width - 40), 40);
    label.font = [UIFont fontWithName: @"HelveticaNeue" size: 27];
    label.text = @"T";
    label.textColor = [UIColor gray: 50];
    [header addSubview: label];
    // Interests
    // Teaching
    interestView1 = [[UIView alloc] init];
    interestView1.backgroundColor = [UIColor spadeGreen];
    interestView1.frame = CGRectMake(0, (header.frame.origin.y + 
      header.frame.size.height), screen.size.width, 60);
    interestView1.hidden = YES;
    [topView addSubview: interestView1];
    UILabel *interestLabel1 = [[UILabel alloc] init];
    interestLabel1.backgroundColor = [UIColor clearColor];
    interestLabel1.font = [UIFont fontWithName: @"HelveticaNeue" size: 15];
    interestLabel1.frame = CGRectMake(20, (header.frame.origin.y + 
      header.frame.size.height), (screen.size.width - 40), 60);
    interestLabel1.text = @"Tennis";
    interestLabel1.textColor = [UIColor gray: 50];
    [topView addSubview: interestLabel1];
    // Tennis
    interestView2 = [[UIView alloc] init];
    interestView2.backgroundColor = [UIColor spadeGreen];
    interestView2.frame = CGRectMake(0, (interestView1.frame.origin.y + 
      interestView1.frame.size.height), screen.size.width, 60);
    interestView2.hidden = YES;
    [topView addSubview: interestView2];
    UILabel *interestLabel2 = [[UILabel alloc] init];
    interestLabel2.backgroundColor = [UIColor clearColor];
    interestLabel2.font = [UIFont fontWithName: @"HelveticaNeue" size: 15];
    interestLabel2.frame = CGRectMake(20, (interestView1.frame.origin.y + 
      interestView1.frame.size.height), (screen.size.width - 40), 60);
    interestLabel2.text = @"Traveling";
    interestLabel2.textColor = [UIColor gray: 50];
    [topView addSubview: interestLabel2];

    // Info
    info = [[UILabel alloc] init];
    info.backgroundColor = [UIColor clearColor];
    info.font = [UIFont fontWithName: @"HelveticaNeue" size: 15];
    info.frame = CGRectMake(10, (topView.frame.origin.y + 
      topView.frame.size.height + marginTop), (screen.size.width - 20), 40);
    info.numberOfLines = 0;
    info.textAlignment = NSTextAlignmentCenter;
    info.textColor = [UIColor whiteColor];
    [self addSubview: info];
  }
  return self;
}

@end
