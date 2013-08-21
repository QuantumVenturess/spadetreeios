//
//  JoinViewController.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 6/27/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "AppDelegate.h"
#import "JoinViewController.h"
#import "UIColor+Extensions.h"
#import "UIImage+Resize.h"

@implementation JoinViewController

#pragma mark - Initializer

- (id) init
{
  self = [super init];
  if (self) {
    self.trackedViewName = @"Join";
  }
  return self;
}

#pragma mark - Override UIViewController

- (void) loadView
{
  // View
  CGRect screen = [[UIScreen mainScreen] bounds];
  CGRect halfScreen = CGRectMake(screen.origin.x, screen.origin.y,
    (screen.size.width / 2.0), screen.size.height);
  self.view = [[UIView alloc] init];
  self.view.backgroundColor = [UIColor blackColor];
  self.view.frame = screen;
  // Background image
  UIImageView *backgroundImage = [[UIImageView alloc] init];
  backgroundImage.frame = screen;
  backgroundImage.image = [UIImage imageNamed: @"join_background.png"];
  [self.view addSubview: backgroundImage];
  [self.view sendSubviewToBack: backgroundImage];
  // Background tint
  UIView *backgroundTint = [[UIView alloc] init];
  backgroundTint.alpha = 0.5;
  backgroundTint.backgroundColor = [UIColor blackColor];
  backgroundTint.frame = screen;
  [self.view addSubview: backgroundTint];
  // Texture image
  UIView *textureView = [[UIView alloc] init];
  textureView.backgroundColor = [UIColor colorWithPatternImage: 
    [UIImage imageNamed: @"texture.png"]];
  textureView.frame = screen;
  // [self.view addSubview: textureView];

  // SpadeTree logo name
  UIImage *logoNameImage = [UIImage imageNamed: @"spadetree.png"];
  logoName = [[UIImageView alloc] init];
  logoName.clipsToBounds = YES;
  logoName.frame = CGRectMake(
    ((screen.size.width - logoNameImage.size.width) / 2.0), 
      ((screen.size.height - logoNameImage.size.height) / 2.0), 
        logoNameImage.size.width, logoNameImage.size.height);
  logoName.image = logoNameImage;
  [self.view addSubview: logoName];

  // Intro view
  introView = [[UIView alloc] init];
  introView.alpha = 0;
  introView.frame = CGRectMake(0, ((screen.size.height - 250) / 2.0), 
    screen.size.width, 250);
  [self.view addSubview: introView];
  // header
  UILabel *header = [[UILabel alloc] init];
  header.backgroundColor = [UIColor clearColor];
  header.font = [UIFont fontWithName: @"HelveticaNeue" size: 26];
  header.frame = CGRectMake(0, 0, screen.size.width, 40);
  header.text = @"Knowledge for everyone";
  header.textAlignment = NSTextAlignmentCenter;
  header.textColor = [UIColor whiteColor];
  [introView addSubview: header];
  // mission
  UILabel *mission = [[UILabel alloc] init];
  mission.backgroundColor = [UIColor clearColor];
  mission.font = [UIFont fontWithName: @"HelveticaNeue" size: 13];
  mission.frame = CGRectMake(20, 60, (screen.size.width - 40), 0);
  mission.lineBreakMode = NSLineBreakByWordWrapping;
  mission.numberOfLines = 0;
  mission.text = @"We connect passionate people with youth who are eager"
    @" to learn new skills that are not typically taught in school";
  mission.textAlignment = NSTextAlignmentRight;
  mission.textColor = [UIColor whiteColor];
  [mission sizeToFit];
  [introView addSubview: mission];
  // Join button
  UIButton *joinUsingFacebook = [[UIButton alloc] init];
  joinUsingFacebook.frame = CGRectMake(20, 
    (mission.frame.origin.y + mission.frame.size.height + 40), 
      (screen.size.width - 40), 48);
  joinUsingFacebook.backgroundColor = [UIColor colorWithRed: (61/255.0) 
    green: (100/255.0) blue: (153/255.0) alpha: 1];
  joinUsingFacebook.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
  joinUsingFacebook.titleLabel.font = [UIFont fontWithName: @"HelveticaNeue"
    size: 16];
  [joinUsingFacebook addTarget: self action: @selector(signIn) 
    forControlEvents: UIControlEventTouchUpInside];
  [joinUsingFacebook setTitle: @"Join using your Facebook" 
    forState: UIControlStateNormal];
  // add Facebook logo image to button
  UIImageView *facebookLogoView = [[UIImageView alloc] initWithImage: 
    [UIImage image: [UIImage imageNamed: @"facebook.png"] 
      size: CGSizeMake(38, 38) point: CGPointMake(5, 5)]];
  [joinUsingFacebook addSubview: facebookLogoView];
  [introView addSubview: joinUsingFacebook];
  // Facebook note
  UILabel *facebookNote = [[UILabel alloc] init];
  facebookNote.backgroundColor = [UIColor clearColor];
  facebookNote.font = [UIFont fontWithName: @"HelveticaNeue" size: 12];
  facebookNote.frame = CGRectMake(30, 
    (joinUsingFacebook.frame.origin.y + 48 + 40), (screen.size.width - 60), 0);
  facebookNote.lineBreakMode = NSLineBreakByWordWrapping;
  facebookNote.numberOfLines = 0;
  facebookNote.text = @"Using Facebook to sign up will help us confirm"
    @" your identity and keep SpadeTree safe."
      @" We will never post on your behalf";
  facebookNote.textAlignment = NSTextAlignmentCenter;
  facebookNote.textColor = [UIColor whiteColor];
  [facebookNote sizeToFit];
  [introView addSubview: facebookNote];

  // Slides
  // left
  leftSlide = [[UIView alloc] init];
  leftSlide.backgroundColor = [UIColor blackColor];
  leftSlide.frame = halfScreen;
  [self.view addSubview: leftSlide];
  // right
  rightSlide = [[UIView alloc] init];
  rightSlide.backgroundColor = [UIColor blackColor];
  rightSlide.frame = CGRectMake((screen.size.width / 2.0), 0, 
    (screen.size.width / 2.0), screen.size.height);
  [self.view addSubview: rightSlide];
  // Slide image views
  // left
  UIImageView *leftSlideImageView = [[UIImageView alloc] init];
  leftSlideImageView.frame = CGRectMake((halfScreen.size.width - 100), 
    (((halfScreen.size.height - 200) / 2.0) - 20), 100, 200);
  leftSlideImageView.image = [UIImage imageNamed: @"left_slide.png"];
  [leftSlide addSubview: leftSlideImageView];
  // right
  UIImageView *rightSlideImageView = [[UIImageView alloc] init];
  rightSlideImageView.frame = CGRectMake(0, 
    (((halfScreen.size.height - 200) / 2.0) - 20), 100, 200);
  rightSlideImageView.image = [UIImage imageNamed: @"right_slide.png"];
  [rightSlide addSubview: rightSlideImageView];
}

- (void) viewDidAppear: (BOOL) animated
{
  [super viewDidAppear: animated];
  [self startAnimation];
}

#pragma mark - Methods

- (void) fadeInIntro: (void (^) (BOOL)) completion
{
  void (^animations) (void) = ^(void) {
    introView.alpha = 1;
  };
  [UIView animateWithDuration: 0.3 delay: 0.7
    options: UIViewAnimationOptionCurveLinear animations: animations
      completion: completion];
}

- (void) moveLogoName: (void (^) (BOOL)) completion
{
  void (^animations) (void) = ^(void) {
    CGRect logoNameFrame = logoName.frame;
    logoNameFrame.origin.y = 20;
    logoName.frame = logoNameFrame;
  };
  [UIView animateWithDuration: 0.5 delay: 0.5
    options: UIViewAnimationOptionCurveLinear animations: animations
      completion: completion];
}

- (void) signIn
{
  AppDelegate *appDelegate = (AppDelegate *)
    [UIApplication sharedApplication].delegate;
  [appDelegate openSession];
}

- (void) slideOpen: (void (^) (BOOL)) completion
{
  void (^animations) (void) = ^(void) {
    CGRect leftFrame    = leftSlide.frame;
    leftFrame.origin.x  -= leftFrame.size.width;
    leftSlide.frame     = leftFrame;
    CGRect rightFrame   = rightSlide.frame;
    rightFrame.origin.x += rightFrame.size.width;
    rightSlide.frame    = rightFrame;
  };
  [UIView animateWithDuration: 0.5 delay: 0.5
    options: UIViewAnimationOptionCurveLinear animations: animations
      completion: completion];
}

- (void) startAnimation
{
  [self fadeInIntro: nil];
  [self moveLogoName: nil];
  [self slideOpen: nil];
}

@end
