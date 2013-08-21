//
//  TutorialViewController.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 8/6/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "TextFieldPadding.h"
#import "TuteeChooseTutorialView.h"
#import "TuteeDatePlaceTutorialView.h"
#import "TuteeSearchTutorialView.h"
#import "TutorEditProfileTutorialView.h"
#import "TutorRequestTutorialView.h"
#import "TutorialStartView.h"
#import "TutorialViewController.h"
#import "UIColor+Extensions.h"
#import "UIImage+Resize.h"
#import "User.h"

@implementation TutorialViewController

@synthesize scroll;

#pragma mark - Initializer

- (id) init
{
  self = [super init];
  if (self) {
    tutorialStart = [[TutorialStartView alloc] init];
    tutorialStart.viewController = self;
    // Tutee
    tuteeChoose    = [[TuteeChooseTutorialView alloc] init];
    tuteeDatePlace = [[TuteeDatePlaceTutorialView alloc] init];
    tuteeSearch    = [[TuteeSearchTutorialView alloc] init];
    // Tutor
    tutorEditProfile = [[TutorEditProfileTutorialView alloc] init];
    tutorRequest     = [[TutorRequestTutorialView alloc] init];

    self.trackedViewName = @"Tutorial";
  }
  return self;
}

#pragma mark - Override UIViewController

- (void) loadView
{
  [super loadView];
  CGRect frame;
  CGRect screen = [[UIScreen mainScreen] bounds];
  float screenHeight = screen.size.height - 20;
  float screenWidth1 = screen.size.width * 1;
  float screenWidth2 = screen.size.width * 2;
  float screenWidth3 = screen.size.width * 3;
  // Scroll
  scroll = [[UIScrollView alloc] init];
  scroll.backgroundColor = [UIColor blackColor];
  scroll.contentSize = CGSizeMake((screen.size.width * 4), 
    (screen.size.height - 20));
  scroll.delegate = self;
  scroll.frame = screen;
  scroll.pagingEnabled = YES;
  scroll.showsHorizontalScrollIndicator = NO;
  self.view = scroll;

  // Page 1
  page1 = [[UIView alloc] init];
  page1.backgroundColor = [UIColor clearColor];
  page1.frame = CGRectMake((screen.size.width * 0), 0, 
    screen.size.width, screen.size.height);
  [self.view addSubview: page1];

  // Page 2
  page2 = [[UIView alloc] init];
  page2.backgroundColor = [UIColor clearColor];
  page2.frame = CGRectMake((screen.size.width * 1), 0, 
    screen.size.width, screen.size.height);
  [self.view addSubview: page2];

  // Page 3
  page3 = [[UIView alloc] init];
  page3.backgroundColor = [UIColor clearColor];
  page3.frame = CGRectMake((screen.size.width * 2), 0, 
    screen.size.width, screen.size.height);
  [self.view addSubview: page3];

  // Page 4
  page4 = [[UIView alloc] init];
  page4.backgroundColor = [UIColor clearColor];
  page4.frame = CGRectMake((screen.size.width * 3), 0, 
    screen.size.width, screen.size.height);
  [self.view addSubview: page4];

  // Page control
  pageControl = [[UIPageControl alloc] init];
  pageControl.backgroundColor = [UIColor clearColor];
  pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed: (115/255.0)
    green: (202/255.0) blue: (36/255.0) alpha: 0.9];
  pageControl.frame = CGRectMake(0, (screen.size.height - 100), 
    screen.size.width, 50);
  pageControl.numberOfPages = 4;
  pageControl.pageIndicatorTintColor = [UIColor colorWithRed: 255 green: 255
    blue: 255 alpha: 0.9];
  [pageControl addTarget: self action: @selector(changePage)
    forControlEvents: UIControlEventValueChanged];
  [self.view addSubview: pageControl];

  // Choose outline
  // 1
  cursorOutline1 = [[UIView alloc] init];
  cursorOutline1.backgroundColor = [UIColor clearColor];
  cursorOutline1.frame = CGRectMake(0, (screen.size.height - 20), 0, 0);
  cursorOutline1.layer.borderColor = [UIColor red].CGColor;
  cursorOutline1.layer.borderWidth = 1;
  // 2
  cursorOutline2 = [[UIView alloc] init];
  cursorOutline2.backgroundColor = [UIColor clearColor];
  cursorOutline2.frame = CGRectMake(((screen.size.width * 2) - 70), 0, 70, 44);
  cursorOutline2.hidden = YES;
  cursorOutline2.layer.borderColor = [UIColor red].CGColor;
  cursorOutline2.layer.borderWidth = 1;

  // Interest label
  interestLabel = [[UILabel alloc] init];
  interestLabel.backgroundColor = [UIColor clearColor];
  interestLabel.font = [UIFont fontWithName: @"HelveticaNeue" size: 15];
  interestLabel.text = @"Tennis";
  interestLabel.textColor = [UIColor gray: 50];
  [interestLabel sizeToFit];
  frame = interestLabel.frame;
  frame.origin.x = 183;
  frame.origin.y = 91;
  interestLabel.frame = frame;
  // One finter
  oneFinger = [[UIImageView alloc] init];
  oneFinger.frame = CGRectMake((screenWidth1 / 1.5), screenHeight, 60, 60);
  oneFinger.image = [UIImage image: [UIImage imageNamed: @"one_finger.png"]
    size: CGSizeMake(60, 60)];
  // Thumbs up
  thumbsUp = [[UIImageView alloc] init];
  thumbsUp.frame = CGRectMake(screenWidth3, (44 + 15), 60, 60);
  thumbsUp.image = [UIImage image: [UIImage imageNamed: @"thumbs_up.png"]
    size: CGSizeMake(60, 60)];

  // Tutorial start letters (Start Learning)
  // Start
  UIColor *color = [UIColor spadeGreen];
  UIFont *font   = [UIFont fontWithName: @"HelveticaNeue" size: 28];
  // S
  startS = [[UILabel alloc] init];
  startS.backgroundColor = [UIColor clearColor];
  startS.font = font;
  startS.text = @"S";
  startS.textColor = color;
  [startS sizeToFit];
  frame = startS.frame;
  frame.origin.x = screenWidth3 - frame.size.width;
  frame.origin.y = screenHeight;
  startS.frame = frame;
  // t
  startT1 = [[UILabel alloc] init];
  startT1.backgroundColor = [UIColor clearColor];
  startT1.font = font;
  startT1.text = @"t";
  startT1.textColor = color;
  [startT1 sizeToFit];
  frame = startT1.frame;
  frame.origin.x = screenWidth3 - frame.size.width;
  frame.origin.y = -frame.size.height;
  startT1.frame = frame;
  // a
  startA = [[UILabel alloc] init];
  startA.backgroundColor = [UIColor clearColor];
  startA.font = font;
  startA.text = @"a";
  startA.textColor = color;
  [startA sizeToFit];
  frame = startA.frame;
  frame.origin.x = screenWidth2;
  frame.origin.y = -frame.size.height;
  startA.frame = frame;
  // r
  startR = [[UILabel alloc] init];
  startR.backgroundColor = [UIColor clearColor];
  startR.font = font;
  startR.text = @"r";
  startR.textColor = color;
  [startR sizeToFit];
  frame = startR.frame;
  frame.origin.x = screenWidth3;
  frame.origin.y = screenHeight / 3.0;
  startR.frame = frame;
  // t
  startT2 = [[UILabel alloc] init];
  startT2.backgroundColor = [UIColor clearColor];
  startT2.font = font;
  startT2.text = @"t";
  startT2.textColor = color;
  [startT2 sizeToFit];
  frame = startT2.frame;
  frame.origin.x = screenWidth2;
  frame.origin.y = screenHeight;
  startT2.frame = frame;
  // Learning / Teaching
  // L
  learningL = [[UILabel alloc] init];
  learningL.backgroundColor = [UIColor clearColor];
  learningL.font = font;
  learningL.text = @"L";
  if ([User currentUser].tutor)
    learningL.text = @"T";
  learningL.textColor = color;
  [learningL sizeToFit];
  frame = learningL.frame;
  frame.origin.x = screenWidth2 + (screenWidth1 / 2.0);
  frame.origin.y = -learningL.frame.size.height;
  learningL.frame = frame;
  // e
  learningE = [[UILabel alloc] init];
  learningE.backgroundColor = [UIColor clearColor];
  learningE.font = font;
  learningE.text = @"e";
  learningE.textColor = color;
  [learningE sizeToFit];
  frame = learningE.frame;
  frame.origin.x = screenWidth3 + (screenWidth1 / 2.0);
  frame.origin.y = screenHeight;
  learningE.frame = frame;
  // a
  learningA = [[UILabel alloc] init];
  learningA.backgroundColor = [UIColor clearColor];
  learningA.font = font;
  learningA.text = @"a";
  learningA.textColor = color;
  [learningA sizeToFit];
  frame = learningA.frame;
  frame.origin.x = screenWidth3 + (screenWidth1 / 2.0);
  frame.origin.y = -learningA.frame.size.height;
  learningA.frame = frame;
  // r
  learningR = [[UILabel alloc] init];
  learningR.backgroundColor = [UIColor clearColor];
  learningR.font = font;
  learningR.text = @"r";
  if ([User currentUser].tutor)
    learningR.text = @"c";
  learningR.textColor = color;
  [learningR sizeToFit];
  frame = learningR.frame;
  frame.origin.x = screenWidth2 + (screenWidth1 / 2.0);
  frame.origin.y = screenHeight;
  learningR.frame = frame;
  // n
  learningN1 = [[UILabel alloc] init];
  learningN1.backgroundColor = [UIColor clearColor];
  learningN1.font = font;
  learningN1.text = @"n";
  if ([User currentUser].tutor)
    learningN1.text = @"h";
  learningN1.textColor = color;
  [learningN1 sizeToFit];
  frame = learningN1.frame;
  frame.origin.x = screenWidth3 + screenWidth1;
  frame.origin.y = screenHeight / 2.0;
  learningN1.frame = frame;
  // i
  learningI = [[UILabel alloc] init];
  learningI.backgroundColor = [UIColor clearColor];
  learningI.font = font;
  learningI.text = @"i";
  learningI.textColor = color;
  [learningI sizeToFit];
  frame = learningI.frame;
  frame.origin.x = screenWidth3;
  frame.origin.y = screenHeight / 4.0;
  learningI.frame = frame;
  // n
  learningN2 = [[UILabel alloc] init];
  learningN2.backgroundColor = [UIColor clearColor];
  learningN2.font = font;
  learningN2.text = @"n";
  learningN2.textColor = color;
  [learningN2 sizeToFit];
  frame = learningN2.frame;
  frame.origin.x = screenWidth2;
  frame.origin.y = screenHeight;
  learningN2.frame = frame;
  // g
  learningG = [[UILabel alloc] init];
  learningG.backgroundColor = [UIColor clearColor];
  learningG.font = font;
  learningG.text = @"g";
  learningG.textColor = color;
  [learningG sizeToFit];
  frame = learningG.frame;
  frame.origin.x = screenWidth3 + screenWidth1;
  frame.origin.y = screenHeight;
  learningG.frame = frame;
  // Tutorial start letters
  // start
  [self.view addSubview: startS];
  [self.view addSubview: startT1];
  [self.view addSubview: startA];
  [self.view addSubview: startR];
  [self.view addSubview: startT2];
  // learning
  [self.view addSubview: learningL];
  [self.view addSubview: learningE];
  [self.view addSubview: learningA];
  [self.view addSubview: learningR];
  [self.view addSubview: learningN1];
  [self.view addSubview: learningI];
  [self.view addSubview: learningN2];
  [self.view addSubview: learningG];
}

- (void) viewWillAppear: (BOOL) animated
{
  [super viewWillAppear: animated];
  if ([User currentUser].tutee) {
    tuteeSearch.searchField.text = @"Te";
    tuteeSearch.info.text = 
      @"Search skills or activities that interest you and find "
      @"a tutor who shares your passion";
    [page1 addSubview: tuteeSearch];
    [page2 addSubview: tuteeChoose];
    [page3 addSubview: tuteeDatePlace];
    [page4 addSubview: tutorialStart];
    // Cursor
    [self.view addSubview: cursorOutline1];
    [self.view addSubview: cursorOutline2];
    // Animate blinking cursor on tutee search view
    CAKeyframeAnimation *fade = [CAKeyframeAnimation animationWithKeyPath:
      @"opacity"];
    NSNumber *val1   = [NSNumber numberWithFloat: 0.0];
    NSNumber *val2   = [NSNumber numberWithFloat: 0.5];
    NSNumber *val3   = [NSNumber numberWithFloat: 1.0];
    NSNumber *val4   = [NSNumber numberWithFloat: 0.5];
    NSNumber *val5   = [NSNumber numberWithFloat: 0.0];
    fade.duration    = 1.5;
    fade.repeatCount = HUGE_VALF;
    fade.values = [NSArray arrayWithObjects: 
      val1, val2, val3, val4, val5, nil];
    [tuteeSearch.cursor.layer addAnimation: fade forKey: @"fade"];
    // Animate background of interest options
    CABasicAnimation *interest1 = [CABasicAnimation animationWithKeyPath: 
      @"hidden"];
    interest1.duration    = 5;
    interest1.fromValue   = [NSNumber numberWithBool: NO];
    interest1.toValue     = [NSNumber numberWithBool: YES];
    interest1.repeatCount = HUGE_VALF;
    [tuteeSearch.interestView1.layer addAnimation: interest1 
      forKey: @"hidden"];
    CABasicAnimation *interest2 = [CABasicAnimation animationWithKeyPath: 
      @"hidden"];
    interest2.duration    = 5;
    interest2.fromValue   = [NSNumber numberWithBool: YES];
    interest2.toValue     = [NSNumber numberWithBool: NO];
    interest2.repeatCount = HUGE_VALF;
    [tuteeSearch.interestView2.layer addAnimation: interest2
      forKey: @"hidden"];
  }
  else {
    tuteeSearch.info.text = 
      @"Search for others who share the same interests as you";
    tuteeSearch.interestView1.alpha = 0;
    tuteeSearch.interestView1.hidden = NO;
    [page1 addSubview: tutorEditProfile];
    [page2 addSubview: tuteeSearch];
    [page3 addSubview: tutorRequest];
    [page4 addSubview: tutorialStart];
    // Interest label
    [self.view addSubview: interestLabel];
    [self.view addSubview: oneFinger];
    [self.view addSubview: thumbsUp];
  }
}

#pragma mark - Protocol UIScrollViewDelegate

- (void) changePage
{
  CGRect screen = [[UIScreen mainScreen] bounds];
  CGPoint point = CGPointMake((screen.size.width * pageControl.currentPage), 0);
  [scroll setContentOffset: point animated: YES];
}

- (void) scrollViewDidEndDecelerating: (UIScrollView *) scrollView
{
  pageControl.currentPage = (int) 
    scrollView.contentOffset.x / scrollView.frame.size.width;
}

- (void) scrollViewDidScroll: (UIScrollView *) scrollView
{
  CGRect frame;
  CGRect screen = [[UIScreen mainScreen] bounds];
  float screenHeight = screen.size.height - 20;
  float screenWidth1 = screen.size.width * 1;
  float screenWidth2 = screen.size.width * 2;
  float screenWidth3 = screen.size.width * 3;

  float height = scrollView.frame.size.height;
  float width  = scrollView.frame.size.width;
  float x = scrollView.contentOffset.x;
  CGRect pageControlFrame = pageControl.frame;
  pageControlFrame.origin.x = x;
  pageControl.frame = pageControlFrame;

  float percent;
  float height1, height2, width1, width2;
  float endingX, endingY, startingX, startingY;
  // Move the cursor outline up and right
  CGRect cursorFrame1 = cursorOutline1.frame;
  CGRect cursorFrame2 = cursorOutline2.frame;
  // If on the first page and moving to the seond page
  if (x >= 0 && x <= width * 1) {
    percent = x / width;
    if ([User currentUser].tutee) {
      height1 = 0;
      height2 = 44;
      width1  = 0;
      width2  = 70;
      cursorFrame1.size.height = height1 + ((height2 - height1) * percent);
      cursorFrame1.size.width = width1 + ((width2 - width1) * percent);
      cursorFrame1.origin.x = percent * ((width * 2) - 
        cursorOutline1.frame.size.width);
      cursorFrame1.origin.y = (1 - percent) * height;
      cursorOutline2.hidden = YES;
    }
    else {
      // Interest label
      startingX = 183;
      startingY = 91;
      endingX   = screenWidth1 + 10 + 40;
      endingY   = 20 + 12;
      frame = interestLabel.frame;
      frame.origin.x = startingX + ((endingX - startingX) * percent);
      frame.origin.y = startingY + ((endingY - startingY) * percent);
      interestLabel.frame = frame;
      float red   = (50 + ((255 - 50) * percent)) / 255.0;
      float green = (26 + ((26 - 50) * percent)) / 255.0;
      float blue  = (0 + ((0 - 50) * percent)) / 255.0;
      interestLabel.textColor = [UIColor colorWithRed: red green: green
        blue: blue alpha: 1];
      // One finger
      startingX = (screenWidth1 / 1.5);
      startingY = screenHeight;
      endingX   = screenWidth1 + (screenWidth1 / 1.5);
      endingY   = 20 + 44 + 20 + 60 + 30;
      frame = oneFinger.frame;
      frame.origin.x = startingX + ((endingX - startingX) * percent);
      frame.origin.y = startingY + ((endingY - startingY) * percent);
      oneFinger.frame = frame;
      // tutee search interestView1
      tuteeSearch.interestView1.alpha = percent;
    }
  }
  // Show cursor 2 and move both down over text fields
  else if (x > width * 1 && x <= width * 2) {
    percent = (x - width) / width;
    if ([User currentUser].tutee) {
      height1 = 44;
      height2 = 40;
      width1  = 70;
      width2  = scrollView.frame.size.width - 20;
      // Cursor 1
      cursorFrame1.origin.x = (x + width) - 
        (cursorOutline1.frame.size.width + (10 * percent));
      cursorFrame1.origin.y = (44 + 20 + 40 + 10) * percent;
      cursorFrame1.size.height = height1 + ((height2 - height1) * percent);
      cursorFrame1.size.width = width1 + ((width2 - width1) * percent);
      // Cursor 2
      cursorOutline2.hidden = NO;
      cursorFrame2.origin.x = (x + width) - 
        (cursorOutline2.frame.size.width + (10 * percent));
      cursorFrame2.origin.y = (44 + 20 + 40 + 10 + 40 + 20 + 40 + 10) * percent;
      cursorFrame2.size.height = height1 + ((height2 - height1) * percent);
      cursorFrame2.size.width = width1 + ((width2 - width1) * percent);

      UIColor *colorChange = [UIColor colorWithRed: 0 green: 0 blue: 0
        alpha: (1 - percent)];
      tuteeDatePlace.addressTextField.layer.borderColor = colorChange.CGColor;
      tuteeDatePlace.dateButton.layer.borderColor = colorChange.CGColor;
    }
    else {
      startingX = screenWidth3;
      endingX   = screenWidth2 + 10 + (screenWidth1 / 4.0) + 10;
      frame = thumbsUp.frame;
      frame.origin.x = startingX + ((endingX - startingX) * percent);
      thumbsUp.frame = frame;
    }
  }
  // Animate Start Learning letters
  else if (x > width * 2 && x <= width * 3) {
    percent = (x - (width * 2)) / width;
    // Change border color back to black
    UIColor *colorChange1 = [UIColor colorWithRed: 0 green: 0 blue: 0
      alpha: percent];
    tuteeDatePlace.addressTextField.layer.borderColor = colorChange1.CGColor;
    tuteeDatePlace.dateButton.layer.borderColor = colorChange1.CGColor;
    // Change cursor outline border color
    UIColor *colorChange2 = [UIColor colorWithRed: (255/255.0) 
      green: (25/255.0) blue: 0 alpha: (1 - percent)];
    cursorOutline1.layer.borderColor = colorChange2.CGColor;
    cursorOutline2.layer.borderColor = colorChange2.CGColor;
    // S
    float spadeWidth   = 10;
    float firstEndingX = screenWidth3 + (screen.size.width - 177) / 2.0;
    startingX = screenWidth3 - startS.frame.size.width;
    startingY = screenHeight;
    endingX   = screenWidth3 + (screen.size.width - 177) / 2.0;
    endingY   = (screenHeight - 34) / 2.0;
    frame          = startS.frame;
    frame.origin.x = startingX + ((endingX - startingX) * percent);
    frame.origin.y = startingY + ((endingY - startingY) * percent);
    startS.frame   = frame;
    // t
    startingX = screenWidth3 - startT1.frame.size.width;
    startingY = -startT1.frame.size.height;
    endingX   = firstEndingX + startS.frame.size.width;
    frame          = startT1.frame;
    frame.origin.x = startingX + ((endingX - startingX) * percent);
    frame.origin.y = startingY + ((endingY - startingY) * percent);
    startT1.frame  = frame;
    // a
    startingX = screenWidth2;
    startingY = -startA.frame.size.height;
    endingX   = firstEndingX + startS.frame.size.width + 
      startT1.frame.size.width;
    frame          = startA.frame;
    frame.origin.x = startingX + ((endingX - startingX) * percent);
    frame.origin.y = startingY + ((endingY - startingY) * percent);
    startA.frame   = frame;
    // r
    startingX = screenWidth3;
    startingY = screenHeight / 3.0;
    endingX   = firstEndingX + startS.frame.size.width + 
      startT1.frame.size.width + startA.frame.size.width;
    frame          = startR.frame;
    frame.origin.x = startingX + ((endingX - startingX) * percent);
    frame.origin.y = startingY + ((endingY - startingY) * percent);
    startR.frame   = frame;
    // t
    startingX = screenWidth2;
    startingY = screenHeight;
    endingX   = firstEndingX + startS.frame.size.width + 
      startT1.frame.size.width + startA.frame.size.width + 
        startR.frame.size.width;
    frame          = startT2.frame;
    frame.origin.x = startingX + ((endingX - startingX) * percent);
    frame.origin.y = startingY + ((endingY - startingY) * percent);
    startT2.frame  = frame;
    // Learning
    // L
    startingX = screenWidth2 + (screenWidth1 / 2.0);
    startingY = -learningL.frame.size.height;
    endingX   = firstEndingX + startS.frame.size.width + 
      startT1.frame.size.width + startA.frame.size.width + 
        startR.frame.size.width + startT2.frame.size.width + spadeWidth;
    frame           = learningL.frame;
    frame.origin.x  = startingX + ((endingX - startingX) * percent);
    frame.origin.y  = startingY + ((endingY - startingY) * percent);
    learningL.frame = frame;
    // e
    startingX = screenWidth3 + (screenWidth1 / 2.0);
    startingY = screenHeight;
    endingX   = firstEndingX + startS.frame.size.width + 
      startT1.frame.size.width + startA.frame.size.width + 
      startR.frame.size.width + startT2.frame.size.width + spadeWidth + 
      learningL.frame.size.width;
    frame           = learningE.frame;
    frame.origin.x  = startingX + ((endingX - startingX) * percent);
    frame.origin.y  = startingY + ((endingY - startingY) * percent);
    learningE.frame = frame;
    // a
    startingX = screenWidth3 + (screenWidth1 / 2.0);
    startingY = -learningA.frame.size.height;
    endingX   = firstEndingX + startS.frame.size.width + 
      startT1.frame.size.width + startA.frame.size.width + 
      startR.frame.size.width + startT2.frame.size.width + spadeWidth + 
      learningL.frame.size.width + learningE.frame.size.width;
    frame           = learningA.frame;
    frame.origin.x  = startingX + ((endingX - startingX) * percent);
    frame.origin.y  = startingY + ((endingY - startingY) * percent);
    learningA.frame = frame;
    // r
    startingX = screenWidth2 + (screenWidth1 / 2.0);
    startingY = screenHeight;
    endingX   = firstEndingX + startS.frame.size.width + 
      startT1.frame.size.width + startA.frame.size.width + 
      startR.frame.size.width + startT2.frame.size.width + spadeWidth + 
      learningL.frame.size.width + learningE.frame.size.width + 
      learningA.frame.size.width;
    frame           = learningR.frame;
    frame.origin.x  = startingX + ((endingX - startingX) * percent);
    frame.origin.y  = startingY + ((endingY - startingY) * percent);
    learningR.frame = frame;
    // n
    startingX = screenWidth3 + screenWidth1;
    startingY = screenHeight / 2.0;
    endingX   = firstEndingX + startS.frame.size.width + 
      startT1.frame.size.width + startA.frame.size.width + 
      startR.frame.size.width + startT2.frame.size.width + spadeWidth + 
      learningL.frame.size.width + learningE.frame.size.width + 
      learningA.frame.size.width + learningR.frame.size.width;
    frame           = learningN1.frame;
    frame.origin.x  = startingX + ((endingX - startingX) * percent);
    frame.origin.y  = startingY + ((endingY - startingY) * percent);
    learningN1.frame = frame;
    // i
    startingX = screenWidth3;
    startingY = screenHeight / 4.0;
    endingX   = firstEndingX + startS.frame.size.width + 
      startT1.frame.size.width + startA.frame.size.width + 
      startR.frame.size.width + startT2.frame.size.width + spadeWidth + 
      learningL.frame.size.width + learningE.frame.size.width + 
      learningA.frame.size.width + learningR.frame.size.width +
      learningN1.frame.size.width;
    frame           = learningI.frame;
    frame.origin.x  = startingX + ((endingX - startingX) * percent);
    frame.origin.y  = startingY + ((endingY - startingY) * percent);
    learningI.frame = frame;
    // n
    startingX = screenWidth2;
    startingY = screenHeight;
    endingX   = firstEndingX + startS.frame.size.width + 
      startT1.frame.size.width + startA.frame.size.width + 
      startR.frame.size.width + startT2.frame.size.width + spadeWidth + 
      learningL.frame.size.width + learningE.frame.size.width + 
      learningA.frame.size.width + learningR.frame.size.width +
      learningN1.frame.size.width + learningI.frame.size.width;
    frame            = learningN2.frame;
    frame.origin.x   = startingX + ((endingX - startingX) * percent);
    frame.origin.y   = startingY + ((endingY - startingY) * percent);
    learningN2.frame = frame;
    // g
    startingX = screenWidth3 + screenWidth1;
    startingY = screenHeight;
    endingX   = firstEndingX + startS.frame.size.width + 
      startT1.frame.size.width + startA.frame.size.width + 
      startR.frame.size.width + startT2.frame.size.width + spadeWidth + 
      learningL.frame.size.width + learningE.frame.size.width + 
      learningA.frame.size.width + learningR.frame.size.width +
      learningN1.frame.size.width + learningI.frame.size.width +
      learningN2.frame.size.width;
    frame            = learningG.frame;
    frame.origin.x   = startingX + ((endingX - startingX) * percent);
    frame.origin.y   = startingY + ((endingY - startingY) * percent);
    learningG.frame = frame;
  }
  cursorOutline1.frame = cursorFrame1;
  cursorOutline2.frame = cursorFrame2;
}

@end
