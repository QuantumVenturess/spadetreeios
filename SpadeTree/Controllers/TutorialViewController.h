//
//  TutorialViewController.h
//  SpadeTree
//
//  Created by Tommy DANGerous on 8/6/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "SpadeTreeViewController.h"

@class TuteeChooseTutorialView;
@class TuteeDatePlaceTutorialView;
@class TuteeSearchTutorialView;
@class TutorEditProfileTutorialView;
@class TutorRequestTutorialView;
@class TutorialStartView;

@interface TutorialViewController : SpadeTreeViewController
<UIScrollViewDelegate>
{
  UIView *page1;
  UIView *page2;
  UIView *page3;
  UIView *page4;
  UIPageControl *pageControl;

  // Cursor outlines
  UIView *cursorOutline1;
  UIView *cursorOutline2;
  // Interest label
  UILabel *interestLabel;
  UIImageView *oneFinger;
  UIImageView *thumbsUp;

  // Tutee views
  TuteeChooseTutorialView *tuteeChoose;
  TuteeDatePlaceTutorialView *tuteeDatePlace;
  TuteeSearchTutorialView *tuteeSearch;
  TutorialStartView *tutorialStart;
  // Tutor views
  TutorEditProfileTutorialView *tutorEditProfile;
  TutorRequestTutorialView *tutorRequest;

  // Start letters
  UILabel *startS;
  UILabel *startT1;
  UILabel *startA;
  UILabel *startR;
  UILabel *startT2;
  // Learning letters
  UILabel *learningL;
  UILabel *learningE;
  UILabel *learningA;
  UILabel *learningR;
  UILabel *learningN1;
  UILabel *learningI;
  UILabel *learningN2;
  UILabel *learningG;
}

@property (nonatomic, strong) UIScrollView *scroll;

@end
