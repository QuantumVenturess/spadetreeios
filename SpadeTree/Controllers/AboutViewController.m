//
//  AboutViewController.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 8/6/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "AboutViewController.h"
#import "AppDelegate.h"
#import "SpadeTreeTabBarController.h"
#import "UIColor+Extensions.h"
#import "UIImage+Resize.h"

@implementation AboutViewController

#pragma mark - Initializer

- (id) init
{
  self = [super init];
  if (self) {
    subviews = [NSMutableArray array];
    self.trackedViewName = @"About";
  }
  return self;
}

#pragma mark - Override UIViewController

- (void) loadView
{
  [super loadView];
  CGSize size;
  CGRect frame;
  CGRect screen   = [[UIScreen mainScreen] bounds];
  CGSize imageSize = CGSizeMake(60, 60);
  UIFont *font14  = [UIFont fontWithName: @"HelveticaNeue" size: 14];
  UIFont *font18  = [UIFont fontWithName: @"HelveticaNeue" size: 18];
  UIFont *font20  = [UIFont fontWithName: @"HelveticaNeue" size: 20];
  UIColor *headerColor = [UIColor spadeGreenDark];
  UIColor *gray50 = [UIColor gray: 50];
  float viewWidth = screen.size.width - 20;
  // Navigation
  self.navigationItem.leftBarButtonItem = [[MenuBarButtonItem alloc] init];
  // Scroll
  scroll = [[UIScrollView alloc] init];
  scroll.alwaysBounceVertical = YES;
  scroll.backgroundColor = [UIColor whiteColor];
  scroll.delegate = self;
  scroll.frame = screen;
  self.view = scroll;

  // Knowledge for everyone
  UIView *mantraView = [[UIView alloc] init];
  mantraView.backgroundColor = [UIColor clearColor];
  mantraView.frame = CGRectMake(0, 0, screen.size.width, 60);
  [subviews addObject: mantraView];
  UILabel *mantraLabel = [[UILabel alloc] init];
  mantraLabel.backgroundColor = [UIColor clearColor];
  mantraLabel.font = font20;
  mantraLabel.frame = CGRectMake(10, 10, viewWidth, 40);
  mantraLabel.text = @"Knowledge for everyone";
  mantraLabel.textColor = gray50;
  [mantraView addSubview: mantraLabel];
  // We connect...
  UILabel *weConnect = [[UILabel alloc] init];
  weConnect.backgroundColor = [UIColor clearColor];
  weConnect.font = font14;
  weConnect.frame = CGRectMake(10, (mantraLabel.frame.origin.y + 
    mantraLabel.frame.size.height), viewWidth, 0);
  weConnect.numberOfLines = 0;
  weConnect.text = @"SpadeTree connects passionate people with youth who are "
    @"eager to learn new skills that are not typically taught in school.";
  weConnect.textColor = gray50;
  size = [weConnect.text sizeWithFont: weConnect.font
    constrainedToSize: CGSizeMake(viewWidth, 1000)];
  frame = weConnect.frame;
  frame.size.height = size.height;
  weConnect.frame = frame;
  [mantraView addSubview: weConnect];
  // Resize
  frame = mantraView.frame;
  frame.size.height = 10 + mantraLabel.frame.size.height + 
    weConnect.frame.size.height + 10;
  mantraView.frame = frame;

  // Tutee and Tutors
  UIView *tuteeTutorView = [[UIView alloc] init];
  tuteeTutorView.backgroundColor = [UIColor clearColor];
  tuteeTutorView.frame = CGRectMake(0, (mantraView.frame.origin.y +
    mantraView.frame.size.height), screen.size.width, 100);
  [subviews addObject: tuteeTutorView];
  // Tutee
  UILabel *tuteeHeader = [[UILabel alloc] init];
  tuteeHeader.backgroundColor = [UIColor clearColor];
  tuteeHeader.font = font18;
  tuteeHeader.frame = CGRectMake(10, 10, viewWidth, 30);
  tuteeHeader.text = @"Tutees";
  tuteeHeader.textColor = headerColor;
  [tuteeTutorView addSubview: tuteeHeader];
  UILabel *tuteeInfo = [[UILabel alloc] init];
  tuteeInfo.backgroundColor = [UIColor clearColor];
  tuteeInfo.font = font14;
  tuteeInfo.frame = CGRectMake(10, (tuteeHeader.frame.origin.y + 
    tuteeHeader.frame.size.height), viewWidth, 0);
  tuteeInfo.numberOfLines = 0;
  tuteeInfo.text = @"If you love doing anything but do not have the "
    @"resources or knowledge to grow, become a tutee and join us so that "
      @"we can help you learn what you love.";
  tuteeInfo.textColor = gray50;
  size = [tuteeInfo.text sizeWithFont: tuteeInfo.font
    constrainedToSize: CGSizeMake(viewWidth, 1000)];
  frame = tuteeInfo.frame;
  frame.size.height = size.height;
  tuteeInfo.frame = frame;
  [tuteeTutorView addSubview: tuteeInfo];
  // Tutor
  UILabel *tutorHeader = [[UILabel alloc] init];
  tutorHeader.backgroundColor = [UIColor clearColor];
  tutorHeader.font = font18;
  tutorHeader.frame = CGRectMake(10, (tuteeInfo.frame.origin.y + 
    tuteeInfo.frame.size.height + 10), viewWidth, 30);
  tutorHeader.text = @"Tutors";
  tutorHeader.textColor = headerColor;
  [tuteeTutorView addSubview: tutorHeader];
  UILabel *tutorInfo = [[UILabel alloc] init];
  tutorInfo.backgroundColor = [UIColor clearColor];
  tutorInfo.font = font14;
  tutorInfo.frame = CGRectMake(10, (tutorHeader.frame.origin.y + 
    tutorHeader.frame.size.height), viewWidth, 0);
  tutorInfo.numberOfLines = 0;
  tutorInfo.text = @"If you have a passion and would like to teach your "
    @"skill to a youth, become a tutor and join us in our mission to spread " 
      @"knowledge like leaves in the wind.";
  tutorInfo.textColor = gray50;
  size = [tutorInfo.text sizeWithFont: tutorInfo.font
    constrainedToSize: CGSizeMake(viewWidth, 1000)];
  frame = tutorInfo.frame;
  frame.size.height = size.height;
  tutorInfo.frame = frame;
  [tuteeTutorView addSubview: tutorInfo];
  // Resize
  frame = tuteeTutorView.frame;
  frame.size.height = 10 + tuteeHeader.frame.size.height + 
    tuteeInfo.frame.size.height + 10 + tutorHeader.frame.size.height +
      tutorInfo.frame.size.height + 10;
  tuteeTutorView.frame = frame;

  // How tutee
  UIView *howTuteeView = [[UIView alloc] init];
  howTuteeView.backgroundColor = [UIColor clearColor];
  howTuteeView.frame = CGRectMake(0, (tuteeTutorView.frame.origin.y + 
    tuteeTutorView.frame.size.height), screen.size.width, 260);
  [subviews addObject: howTuteeView];
  // header
  UILabel *howTuteeHeader = [[UILabel alloc] init];
  howTuteeHeader.backgroundColor = [UIColor clearColor];
  howTuteeHeader.font = font18;
  howTuteeHeader.frame = CGRectMake(10, 10, viewWidth, 30);
  howTuteeHeader.text = @"How it works for Tutees";
  howTuteeHeader.textColor = headerColor;
  [howTuteeView addSubview: howTuteeHeader];
  // 1 view
  UIView *howTuteeView1 = [[UIView alloc] init];
  howTuteeView1.backgroundColor = [UIColor clearColor];
  howTuteeView1.frame = CGRectMake(0, (howTuteeHeader.frame.origin.y + 
    howTuteeHeader.frame.size.height + 10), screen.size.width, 60);
  [howTuteeView addSubview: howTuteeView1];
  // image
  UIImageView *howTuteeImageView1 = [[UIImageView alloc] init];
  howTuteeImageView1.frame = CGRectMake(10, 0, 60, 60);
  howTuteeImageView1.image = [UIImage image: 
    [UIImage imageNamed: @"interests.png"] size: imageSize];
  [howTuteeView1 addSubview: howTuteeImageView1];
  // label
  UILabel *howTuteeLabel1 = [[UILabel alloc] init];
  howTuteeLabel1.backgroundColor = [UIColor clearColor];
  howTuteeLabel1.font = font14;
  howTuteeLabel1.frame = CGRectMake((howTuteeImageView1.frame.origin.x + 
    howTuteeImageView1.frame.size.width + 10), 0, (viewWidth - (60 + 10)), 60);
  howTuteeLabel1.numberOfLines = 0;
  howTuteeLabel1.text = @"Tell us what you are interested in and what you "
    @"want to learn, from sports to art or DJing to Starcraft";
  howTuteeLabel1.textColor = gray50;
  [howTuteeView1 addSubview: howTuteeLabel1];
  // 2 view
  UIView *howTuteeView2 = [[UIView alloc] init];
  howTuteeView2.backgroundColor = [UIColor clearColor];
  howTuteeView2.frame = CGRectMake(0, (howTuteeView1.frame.origin.y + 
    howTuteeView1.frame.size.height + 10), screen.size.width, 60);
  [howTuteeView addSubview: howTuteeView2];
  // image
  UIImageView *howTuteeImageView2 = [[UIImageView alloc] init];
  howTuteeImageView2.frame = CGRectMake((screen.size.width - 70), 0, 60, 60);
  howTuteeImageView2.image = [UIImage image: 
    [UIImage imageNamed: @"search.png"] size: imageSize];
  [howTuteeView2 addSubview: howTuteeImageView2];
  // label
  UILabel *howTuteeLabel2 = [[UILabel alloc] init];
  howTuteeLabel2.backgroundColor = [UIColor clearColor];
  howTuteeLabel2.font = font14;
  howTuteeLabel2.frame = CGRectMake(10, 0, (viewWidth - (60 + 10)), 60);
  howTuteeLabel2.numberOfLines = 0;
  howTuteeLabel2.text = @"Search for a tutor who is passionate about the "
    @"topic you are interested in";
  howTuteeLabel2.textColor = gray50;
  [howTuteeView2 addSubview: howTuteeLabel2];
  // 3 view
  UIView *howTuteeView3 = [[UIView alloc] init];
  howTuteeView3.backgroundColor = [UIColor clearColor];
  howTuteeView3.frame = CGRectMake(0, (howTuteeView2.frame.origin.y + 
    howTuteeView2.frame.size.height + 10), screen.size.width, 60);
  [howTuteeView addSubview: howTuteeView3];
  // image
  UIImageView *howTuteeImageView3 = [[UIImageView alloc] init];
  howTuteeImageView3.frame = CGRectMake(10, 0, 60, 60);
  howTuteeImageView3.image = [UIImage image: 
    [UIImage imageNamed: @"environment.png"] size: imageSize];
  [howTuteeView3 addSubview: howTuteeImageView3];
  // label
  UILabel *howTuteeLabel3 = [[UILabel alloc] init];
  howTuteeLabel3.backgroundColor = [UIColor clearColor];
  howTuteeLabel3.font = font14;
  howTuteeLabel3.frame = CGRectMake((howTuteeImageView3.frame.origin.x + 
    howTuteeImageView3.frame.size.width + 10), 0, (viewWidth - (60 + 10)), 60);
  howTuteeLabel3.numberOfLines = 0;
  howTuteeLabel3.text = @"Have your parent or guardian arrange a safe "
    @"learning environment for you and your tutor";
  howTuteeLabel3.textColor = gray50;
  [howTuteeView3 addSubview: howTuteeLabel3];

  // How Tutor
  UIView *howTutorView = [[UIView alloc] init];
  howTutorView.backgroundColor = [UIColor clearColor];
  howTutorView.frame = CGRectMake(0, (howTuteeView.frame.origin.y + 
    howTuteeView.frame.size.height), screen.size.width, 260);
  [subviews addObject: howTutorView];
  // header
  UILabel *howTutorHeader = [[UILabel alloc] init];
  howTutorHeader.backgroundColor = [UIColor clearColor];
  howTutorHeader.font = font18;
  howTutorHeader.frame = CGRectMake(10, 10, viewWidth, 30);
  howTutorHeader.text = @"How it works for Tutors";
  howTutorHeader.textColor = headerColor;
  [howTutorView addSubview: howTutorHeader];
  // 1 view
  UIView *howTutorView1 = [[UIView alloc] init];
  howTutorView1.backgroundColor = [UIColor clearColor];
  howTutorView1.frame = CGRectMake(0, (howTutorHeader.frame.origin.y + 
    howTutorHeader.frame.size.height + 10), screen.size.width, 60);
  [howTutorView addSubview: howTutorView1];
  // image
  UIImageView *howTutorImageView1 = [[UIImageView alloc] init];
  howTutorImageView1.frame = CGRectMake(10, 0, 60, 60);
  howTutorImageView1.image = [UIImage image: 
    [UIImage imageNamed: @"skills.png"] size: imageSize];
  [howTutorView1 addSubview: howTutorImageView1];
  // label
  UILabel *howTutorLabel1 = [[UILabel alloc] init];
  howTutorLabel1.backgroundColor = [UIColor clearColor];
  howTutorLabel1.font = font14;
  howTutorLabel1.frame = CGRectMake((howTutorImageView1.frame.origin.x + 
    howTutorImageView1.frame.size.width + 10), 0, (viewWidth - (60 + 10)), 60);
  howTutorLabel1.numberOfLines = 0;
  howTutorLabel1.text = @"Tell us what you are passionate about and "
    @"what skills you would like to teach";
  howTutorLabel1.textColor = gray50;
  [howTutorView1 addSubview: howTutorLabel1];
  // 2 view
  UIView *howTutorView2 = [[UIView alloc] init];
  howTutorView2.backgroundColor = [UIColor clearColor];
  howTutorView2.frame = CGRectMake(0, (howTutorView1.frame.origin.y + 
    howTutorView1.frame.size.height + 10), screen.size.width, 60);
  [howTutorView addSubview: howTutorView2];
  // image
  UIImageView *howTutorImageView2 = [[UIImageView alloc] init];
  howTutorImageView2.frame = CGRectMake((screen.size.width - 70), 0, 60, 60);
  howTutorImageView2.image = [UIImage image: 
    [UIImage imageNamed: @"pick.png"] size: imageSize];
  [howTutorView2 addSubview: howTutorImageView2];
  // label
  UILabel *howTutorLabel2 = [[UILabel alloc] init];
  howTutorLabel2.backgroundColor = [UIColor clearColor];
  howTutorLabel2.font = font14;
  howTutorLabel2.frame = CGRectMake(10, 0, (viewWidth - (60 + 10)), 60);
  howTutorLabel2.numberOfLines = 0;
  howTutorLabel2.text = @"Once selected as a tutor, choosing whether "
    @"you want to teach once a year or everyday is your decision";
  howTutorLabel2.textColor = gray50;
  [howTutorView2 addSubview: howTutorLabel2];
  // 3 view
  UIView *howTutorView3 = [[UIView alloc] init];
  howTutorView3.backgroundColor = [UIColor clearColor];
  howTutorView3.frame = CGRectMake(0, (howTutorView2.frame.origin.y + 
    howTutorView2.frame.size.height + 10), screen.size.width, 60);
  [howTutorView addSubview: howTutorView3];
  // image
  UIImageView *howTutorImageView3 = [[UIImageView alloc] init];
  howTutorImageView3.frame = CGRectMake(10, 0, 60, 60);
  howTutorImageView3.image = [UIImage image: 
    [UIImage imageNamed: @"setup.png"] size: imageSize];
  [howTutorView3 addSubview: howTutorImageView3];
  // label
  UILabel *howTutorLabel3 = [[UILabel alloc] init];
  howTutorLabel3.backgroundColor = [UIColor clearColor];
  howTutorLabel3.font = font14;
  howTutorLabel3.frame = CGRectMake((howTutorImageView3.frame.origin.x + 
    howTutorImageView3.frame.size.width + 10), 0, (viewWidth - (60 + 10)), 60);
  howTutorLabel3.numberOfLines = 0;
  howTutorLabel3.text = @"Work with their parent or guardian to set up a "
    @"time and place for you to start teaching your skills";
  howTutorLabel3.textColor = gray50;
  [howTutorView3 addSubview: howTutorLabel3];

  // Mission
  UIView *missionView = [[UIView alloc] init];
  missionView.backgroundColor = [UIColor clearColor];
  missionView.frame = CGRectMake(0, (howTutorView.frame.origin.y + 
    howTutorView.frame.size.height), screen.size.width, 
      (40 + 100 + 80 + 20 + 40 + 40));
  [subviews addObject: missionView];
  // image
  UIImageView *missionImageView = [[UIImageView alloc] init];
  missionImageView.frame = CGRectMake(((viewWidth - 100) / 2.0), 40, 100, 100);
  missionImageView.image = [UIImage image: 
    [UIImage imageNamed: @"world_semi_green.png"] size: CGSizeMake(100, 100)];
  [missionView addSubview: missionImageView];
  // label
  UILabel *missionLabel = [[UILabel alloc] init];
  missionLabel.backgroundColor = [UIColor clearColor];
  missionLabel.font = font14;
  missionLabel.frame = CGRectMake(10, (missionImageView.frame.origin.y + 
    missionImageView.frame.size.height + 10), viewWidth, 80);
  missionLabel.numberOfLines = 0;
  missionLabel.text = @"Whether you want to learn something new or have a "
    @"passion to share, becoming a part of the family will help grow our "
      @"community and spread knowledge around the world.";
  missionLabel.textColor = gray50;
  [missionView addSubview: missionLabel];
  // button
  UILabel *viewIntroLabel = [[UILabel alloc] init];
  viewIntroLabel.backgroundColor = [UIColor clearColor];
  viewIntroLabel.font = font18;
  viewIntroLabel.text = @"View Intro";
  viewIntroLabel.textAlignment = NSTextAlignmentCenter;
  viewIntroLabel.textColor = [UIColor whiteColor];
  [viewIntroLabel sizeToFit];
  frame = viewIntroLabel.frame;
  frame.size.height = 40;
  frame.size.width += 80;
  frame.origin.x = 0;
  frame.origin.y = 0;
  viewIntroLabel.frame = frame;
  UIButton *viewIntro = [[UIButton alloc] init];
  viewIntro.backgroundColor = [UIColor spadeGreen];
  viewIntro.frame = CGRectMake(((screen.size.width - 
    viewIntroLabel.frame.size.width) / 2.0), (missionLabel.frame.origin.y +
      missionLabel.frame.size.height + 20), viewIntroLabel.frame.size.width,
        viewIntroLabel.frame.size.height);
  [viewIntro addSubview: viewIntroLabel];
  [viewIntro addTarget: self action: @selector(showTutorial) 
    forControlEvents: UIControlEventTouchUpInside];
  [missionView addSubview: viewIntro];

  // Add all views to scroll view
  float totalHeightSize = 0;
  for (UIView *v in subviews) {
    totalHeightSize += v.frame.size.height;
    [scroll addSubview: v];
  }
  scroll.contentSize = CGSizeMake(scroll.frame.size.width, totalHeightSize);
}

#pragma mark - Methods

- (void) showTutorial
{
  AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
  SpadeTreeTabBarController *tab = appDelegate.tabBarController;
  [tab showTutorial];
}

@end
