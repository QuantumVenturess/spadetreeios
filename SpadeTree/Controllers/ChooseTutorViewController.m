//
//  ChooseTutorViewController.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/16/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "Choice.h"
#import "ChoiceListStore.h"
#import "ChooseTutorConnection.h"
#import "ChooseTutorViewController.h"
#import "Day.h"
#import "DayBoxButton.h"
#import "DayFree.h"
#import "Hour.h"
#import "HourFree.h"
#import "HourBoxButton.h"
#import "Interest.h"
#import "Message.h"
#import "MessageDetailStore.h"
#import "NewMessageConnection.h"
#import "SkillBoxButton.h"
#import "UIColor+Extensions.h"
#import "User.h"

@implementation ChooseTutorViewController

@synthesize user;

#pragma mark - Initializer

- (id) initWithUser: (User *) userObject
{
  self = [super init];
  if (self) {
    self.user  = userObject;
    self.title = @"Choosing Tutor";
    self.trackedViewName = [NSString stringWithFormat:
      @"Choose Tutor %i", self.user.uid];
    subviews   = [NSMutableArray array];
  }
  return self;
}

#pragma mark - Override UIViewController

- (void) loadView
{
  [super loadView];
  CGRect screen = [[UIScreen mainScreen] bounds];
  // Navigation
  UIFont *font14 = [UIFont fontWithName: @"HelveticaNeue" size: 14];
  CGSize maxSize = CGSizeMake(screen.size.width, 18);
  // cancel
  NSString *cancelString = @"Cancel";
  CGSize textSize = [cancelString sizeWithFont: font14
    constrainedToSize: maxSize];
  UILabel *cancelLabel = [[UILabel alloc] init];
  cancelLabel.backgroundColor = [UIColor clearColor];
  cancelLabel.font = font14;
  cancelLabel.frame = CGRectMake(5, 0, textSize.width, textSize.height);
  cancelLabel.text = cancelString;
  cancelLabel.textColor = [UIColor whiteColor];
  UIButton *cancelButton = [[UIButton alloc] init];
  cancelButton.frame = CGRectMake(0, 0, textSize.width + 5, textSize.height);
  [cancelButton addTarget: self action: @selector(cancel)
    forControlEvents: UIControlEventTouchUpInside];
  [cancelButton addSubview: cancelLabel];
  self.navigationItem.leftBarButtonItem = 
    [[UIBarButtonItem alloc] initWithCustomView: cancelButton];
  // submit
  NSString *submitString = @"Submit";
  textSize = [submitString sizeWithFont: font14
    constrainedToSize: maxSize];
  UILabel *submitLabel = [[UILabel alloc] init];
  submitLabel.backgroundColor = [UIColor clearColor];
  submitLabel.font = font14;
  submitLabel.frame = CGRectMake(0, 0, textSize.width, textSize.height);
  submitLabel.text = submitString;
  submitLabel.textColor = [UIColor whiteColor];
  UIButton *submitButton = [[UIButton alloc] init];
  submitButton.frame = CGRectMake(0, 0, textSize.width + 5, textSize.height);
  [submitButton addTarget: self action: @selector(submit)
    forControlEvents: UIControlEventTouchUpInside];
  [submitButton addSubview: submitLabel];
  self.navigationItem.rightBarButtonItem = 
    [[UIBarButtonItem alloc] initWithCustomView: submitButton];
  // Main
  scroll = [[UIScrollView alloc] init];
  scroll.alwaysBounceVertical = YES;
  scroll.backgroundColor = [UIColor blackColor];
  scroll.frame = screen;
  scroll.showsVerticalScrollIndicator = NO;
  self.view = scroll;

  UIFont *font18 = [UIFont fontWithName: @"HelveticaNeue" size: 18];
  // Choose the skill you want to learn
  UILabel *chooseSkill = [[UILabel alloc] init];
  chooseSkill.backgroundColor = [UIColor clearColor];
  chooseSkill.font = font18;
  chooseSkill.frame = CGRectMake(10, 10, (screen.size.width - 20), 40);
  chooseSkill.text = @"Choose the skill you want to learn";
  chooseSkill.textColor = [UIColor whiteColor];
  UIView *chooseSkillView = [[UIView alloc] init];
  chooseSkillView.frame = CGRectMake(0, 0, screen.size.width, 60);
  [chooseSkillView addSubview: chooseSkill];
  [subviews addObject: chooseSkillView];
  // skill box
  skillBox = [[UIView alloc] init];
  skillBox.backgroundColor = [UIColor whiteColor];
  skillBox.frame = CGRectMake(0, 60, screen.size.width, 0);
  [subviews addObject: skillBox];

  // Choose a day of the week
  UILabel *chooseDay = [[UILabel alloc] init];
  chooseDay.backgroundColor = [UIColor clearColor];
  chooseDay.font = font18;
  chooseDay.frame = CGRectMake(10, 10, (screen.size.width - 20), 40);
  chooseDay.text = @"Choose a day of the week";
  chooseDay.textColor = [UIColor whiteColor];
  chooseDayView = [[UIView alloc] init];
  [chooseDayView addSubview: chooseDay];
  [subviews addObject: chooseDayView];
  // day box
  dayBox = [[UIView alloc] init];
  dayBox.backgroundColor = [UIColor whiteColor];
  [subviews addObject: dayBox];

  // Choose an hour of the day
  UILabel *chooseHour = [[UILabel alloc] init];
  chooseHour.backgroundColor = [UIColor clearColor];
  chooseHour.font = font18;
  chooseHour.frame = CGRectMake(10, 10, (screen.size.width - 20), 40);
  chooseHour.text = @"Choose an hour of the day";
  chooseHour.textColor = [UIColor whiteColor];
  chooseHourView = [[UIView alloc] init];
  [chooseHourView addSubview: chooseHour];
  [subviews addObject: chooseHourView];
  // hour box
  hourBox = [[UIView alloc] init];
  hourBox.backgroundColor = [UIColor whiteColor];
  [subviews addObject: hourBox];
}

- (void) viewDidDisappear: (BOOL) animated
{
  [super viewDidDisappear: animated];
  [self resetButtonsAndData];
}

- (void) viewWillAppear: (BOOL) animated
{
  [super viewWillAppear: animated];
  [self refreshViews];
}

#pragma mark - Methods

- (void) cancel
{
  [self dismissViewControllerAnimated: YES completion: nil];
}

- (void) refreshViews
{
  CGRect screen = [[UIScreen mainScreen] bounds];
  int padding = 10;
  int lineHeight = 20;
  int row = 0;
  int rowHeight = 40;
  float rowWidth = screen.size.width - 20; // 300
  float rowLength = 10;
  CGSize maxBoxButtonSize = CGSizeMake(rowWidth, lineHeight);
  // Position all skill box buttons
  if (self.user.skills) {
    for (Interest *interestObject in self.user.skills) {
      SkillBoxButton *button = 
        [[SkillBoxButton alloc] initWithInterest: interestObject];
      CGSize nameTextSize = [button.nameLabel.text sizeWithFont: 
        button.nameLabel.font constrainedToSize: maxBoxButtonSize];
      float boxButtonWidthAndPadding = nameTextSize.width + (padding * 2);
      if (rowLength + boxButtonWidthAndPadding > screen.size.width - 10) {
        row += 1;
        rowLength = 10;
      }
      button.nameLabel.frame = CGRectMake(padding, padding, nameTextSize.width,
        lineHeight);
      button.frame = CGRectMake(rowLength, ((row * rowHeight) + padding),
        boxButtonWidthAndPadding, rowHeight);
      [button addTarget: self action: @selector(selectSkill:)
        forControlEvents: UIControlEventTouchUpInside];
      [skillBox addSubview: button];
      rowLength += boxButtonWidthAndPadding;
    }
    CGRect skillBoxFrame = skillBox.frame;
    skillBoxFrame.size.height = ((row + 1) * rowHeight) + (padding * 2);
    skillBox.frame = skillBoxFrame;
  }
  // Set the position of the label "Select a day of the week"
  chooseDayView.frame = CGRectMake(0, 
    (skillBox.frame.origin.y + skillBox.frame.size.height), 
      screen.size.width, 60);
  if (self.user.daysFree) {
    row = 0;
    rowLength = 10;
    float dayBoxButtonWidth = (screen.size.width - 20) / 3.0;
    for (DayFree *dayFreeObject in self.user.daysFree) {
      DayBoxButton *button = [[DayBoxButton alloc] initWithDayFree: 
        dayFreeObject];
      if (rowLength + dayBoxButtonWidth > screen.size.width) {
        row += 1;
        rowLength = 10;
      }
      button.frame = CGRectMake(rowLength, ((row * rowHeight) + padding),
        dayBoxButtonWidth, rowHeight);
      button.nameLabel.frame = CGRectMake(0, 0, button.frame.size.width,
        rowHeight);
      [dayBox addSubview: button];
      rowLength += dayBoxButtonWidth;
      [button addTarget: self action: @selector(selectDayFree:)
        forControlEvents: UIControlEventTouchUpInside];
    }
    dayBox.frame = CGRectMake(0, 
      (chooseDayView.frame.origin.y + chooseDayView.frame.size.height),
        screen.size.width, ((row + 1) * rowHeight) + (padding * 2));
  }
  // Set the position of the label for the hour of the day
  // int paddingX = 15;
  int paddingY = 10;
  chooseHourView.frame = CGRectMake(0,
    (dayBox.frame.origin.y + dayBox.frame.size.height), screen.size.width, 60);
  if (self.user.hoursFreeAm || self.user.hoursFreePm) {
    row = 0;
    rowLength = 10;
    float hourBoxButtonWidth = (screen.size.width - 20) / 6.0;
    // Hours AM
    for (HourFree *hourFreeObject in self.user.hoursFreeAm) {
      HourBoxButton *button = [[HourBoxButton alloc] initWithHourFree:
        hourFreeObject];
      if ([self.user.hoursFreeAm indexOfObject: hourFreeObject] == 0) {
        button.nameLabel.text = [NSString stringWithFormat: @"%@am", 
          button.nameLabel.text];
      }
      if (rowLength + hourBoxButtonWidth > screen.size.width) {
        row += 1;
        rowLength = 10;
      }
      button.frame = CGRectMake(rowLength, ((row * rowHeight) + padding),
        hourBoxButtonWidth, rowHeight);
      button.nameLabel.frame = CGRectMake(0, 0, button.frame.size.width,
        rowHeight);
      [hourBox addSubview: button];
      rowLength += hourBoxButtonWidth;
      [button addTarget: self action: @selector(selectHourFree:)
        forControlEvents: UIControlEventTouchUpInside];
    }
    // Hours PM
    for (HourFree *hourFreeObject in self.user.hoursFreePm) {
      HourBoxButton *button = [[HourBoxButton alloc] initWithHourFree:
        hourFreeObject];
      if ([self.user.hoursFreePm indexOfObject: hourFreeObject] == 0) {
        button.nameLabel.text = [NSString stringWithFormat: @"%@pm", 
          button.nameLabel.text];
      }
      if (rowLength + hourBoxButtonWidth > screen.size.width) {
        row += 1;
        rowLength = 10;
      }
      button.frame = CGRectMake(rowLength, ((row * rowHeight) + padding),
        hourBoxButtonWidth, rowHeight);
      button.nameLabel.frame = CGRectMake(0, 0, button.frame.size.width,
        rowHeight);
      [hourBox addSubview: button];
      rowLength += hourBoxButtonWidth;
      [button addTarget: self action: @selector(selectHourFree:)
        forControlEvents: UIControlEventTouchUpInside];    }
    hourBox.frame = CGRectMake(0,
      (chooseHourView.frame.origin.y + chooseHourView.frame.size.height),
        screen.size.width, ((row + 1) * rowHeight) + (paddingY * 2));
  }

  float totalHeightSize = 0;
  // Add all views to scroll view
  for (UIView *v in subviews) {
    totalHeightSize += v.frame.size.height;
    [scroll addSubview: v];
  }
  // Set scroll view's content size
  scroll.contentSize = CGSizeMake(scroll.frame.size.width, totalHeightSize);
}

- (void) resetButtonsAndData
{
  dayFree  = nil;
  hourFree = nil;
  interest = nil;
  [self unselectDayFree];
  [self unselectHourFree];
  [self unselectSkill];
  [dayBox.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
  [hourBox.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
  [skillBox.subviews makeObjectsPerformSelector: 
    @selector(removeFromSuperview)];
}

- (void) selectDayFree: (id) sender
{
  [self unselectDayFree];
  DayBoxButton *button = (DayBoxButton *) sender;
  button.backgroundColor = [UIColor spadeGreen];
  button.nameLabel.textColor = [UIColor whiteColor];
  dayFree = button.dayFree;
}

- (void) selectHourFree: (id) sender
{
  [self unselectHourFree];
  HourBoxButton *button = (HourBoxButton *) sender;
  button.backgroundColor = [UIColor spadeGreen];
  button.nameLabel.textColor = [UIColor whiteColor];
  hourFree = button.hourFree;
}

- (void) selectSkill: (id) sender
{
  [self unselectSkill];
  SkillBoxButton *button = (SkillBoxButton *) sender;
  button.backgroundColor = [UIColor spadeGreen];
  button.nameLabel.textColor = [UIColor whiteColor];
  interest = button.interest;
}

- (void) submit
{
  // Create choice
  Choice *choice = [[Choice alloc] init];
  choice.created = [[NSDate date] timeIntervalSince1970];
  choice.content = [NSString stringWithFormat: 
    @"I really want to learn %@, will you tutor me please?", 
      [interest nameTitle]];
  choice.day = dayFree.day;
  choice.hour = hourFree.hour;
  choice.interest = interest;
  choice.tutee = [User currentUser];
  choice.tuteeViewed = YES;
  choice.tutor = self.user;
  choice.uid = 0;
  [[ChoiceListStore sharedStore] addChoice: choice];
  ChooseTutorConnection *connection = 
    [[ChooseTutorConnection alloc] initWithDayFree: dayFree hourFree: hourFree
      choice: choice];
  [connection start];
  // Create message
  // Message *message  = [[Message alloc] init];
  // message.content   = choice.content;
  // message.created   = choice.created;
  // message.recipient = choice.tutor;
  // message.sender    = [User currentUser];
  // message.uid       = 0;
  // message.viewed    = YES;
  // [[MessageDetailStore sharedStore] addMessage: message];
  // [[[NewMessageConnection alloc] initWithMessage: message] start];
  [self cancel];
}

- (void) unselectDayFree
{
  for (DayBoxButton *button in dayBox.subviews) {
    button.backgroundColor = [UIColor clearColor];
    button.nameLabel.textColor = [UIColor gray: 50];
  }
}

- (void) unselectHourFree
{
  for (HourBoxButton *button in hourBox.subviews) {
    button.backgroundColor = [UIColor clearColor];
    button.nameLabel.textColor = [UIColor gray: 50];
  }
}

- (void) unselectSkill
{
  for (SkillBoxButton *button in skillBox.subviews) {
    button.backgroundColor = [UIColor clearColor];
    button.nameLabel.textColor = [UIColor gray: 50];
  }
}

@end
