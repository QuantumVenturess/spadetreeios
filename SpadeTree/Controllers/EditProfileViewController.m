//
//  EditProfileViewController.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 7/17/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "AddSkillConnection.h"
#import "AllInterestStore.h"
#import "BrowseInterestStore.h"
#import "City.h"
#import "Day.h"
#import "DayBoxButton.h"
#import "DayFree.h"
#import "DayFreeConnection.h"
#import "DayStore.h"
#import "DeleteSkillConnection.h"
#import "EditInterestSearchResult.h"
#import "EditProfileConnection.h"
#import "EditProfileViewController.h"
#import "Hour.h"
#import "HourBoxButton.h"
#import "HourFree.h"
#import "HourFreeConnection.h"
#import "HourStore.h"
#import "Interest.h"
#import "InterestBrowseSearchConnection.h"
#import "NSString+Extensions.h"
#import "SkillBoxButton.h"
#import "State.h"
#import "StateStore.h"
#import "TextFieldPadding.h"
#import "UIColor+Extensions.h"
#import "UIImage+Resize.h"
#import "User.h"
#import "UserDetailConnection.h"

@implementation EditProfileViewController

@synthesize searchField;

#pragma mark - Initializer

- (id) init
{
  self = [super init];
  if (self) {
    aboutTextViewPlaceholder = @"Tell us about yourself";
    self.title = @"Edit Profile";
    self.trackedViewName = @"Edit Profile";
    interests  = [NSArray array];
    subviews   = [NSMutableArray array];
    keyboardShowing = NO;
  }
  return self;
}

#pragma mark - Override UIViewController

- (void) loadView
{
  [super loadView];
  CGRect screen = [[UIScreen mainScreen] bounds];
  UIFont *font14 = [UIFont fontWithName: @"HelveticaNeue" size: 14];
  UIFont *font20 = [UIFont fontWithName: @"HelveticaNeue" size: 20];
  CGRect headerFrame = CGRectMake((10 + 18 + 10), 0,
    (screen.size.width - (10 + 18 + 10 + 10)), 40);
  CGRect imageFrame = CGRectMake(10, 10, 18, 18);
  CGSize imageSize = CGSizeMake(18, 18);
  UIColor *gray50 = [UIColor gray: 50];
  // Navigation item
  // left
  self.navigationItem.leftBarButtonItem  = nil;
  // right
  NSString *addButtonString = @"Add";
  CGSize textSize = [addButtonString sizeWithFont: font14];
  UILabel *addLabel = [[UILabel alloc] init];
  addLabel.backgroundColor = [UIColor clearColor];
  addLabel.font = font14;
  addLabel.frame = CGRectMake(10, 0, textSize.width, textSize.height);
  addLabel.text = addButtonString;
  addLabel.textColor = [UIColor whiteColor];
  UIButton *addButton = [[UIButton alloc] init];
  addButton.frame = CGRectMake(0, 0, (textSize.width + 20), textSize.height);
  [addButton addSubview: addLabel];
  [addButton addTarget: self action: @selector(addSkill)
    forControlEvents: UIControlEventTouchUpInside];
  addBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView: addButton];
  self.navigationItem.rightBarButtonItem = addBarButtonItem;
  // done
  NSString *doneButtonString = @"Done";
  textSize = [doneButtonString sizeWithFont: font14];
  UILabel *doneLabel = [[UILabel alloc] init];
  doneLabel.backgroundColor = [UIColor clearColor];
  doneLabel.font = font14;
  doneLabel.frame = CGRectMake(10, 0, textSize.width, textSize.height);
  doneLabel.text = doneButtonString;
  doneLabel.textColor = [UIColor whiteColor];
  UIButton *doneButton = [[UIButton alloc] init];
  doneButton.frame = CGRectMake(0, 0, (textSize.width + 20), textSize.height);
  [doneButton addSubview: doneLabel];
  [doneButton addTarget: self action: @selector(doneEditing)
    forControlEvents: UIControlEventTouchUpInside];
  doneBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView: doneButton];
  // search field
  self.searchField = [[TextFieldPadding alloc] init];
  self.searchField.autocorrectionType = UITextAutocorrectionTypeYes;
  self.searchField.backgroundColor = [UIColor whiteColor];
  self.searchField.clearButtonMode = UITextFieldViewModeWhileEditing;
  self.searchField.delegate = self;
  self.searchField.frame = CGRectMake(0, 8, (screen.size.width - 0), 28);
  self.searchField.font = font14;
  self.searchField.paddingX = 28;
  self.searchField.paddingY = 5;
  self.searchField.placeholder = [NSString stringWithFormat: 
    @"Type your %@ here", [User currentUser].tutor ? @"skills" : @"interests"];
  self.searchField.returnKeyType = UIReturnKeyNext;
  self.searchField.textColor = gray50;
  [self.searchField addTarget: self action: @selector(fetchInterests:)
    forControlEvents: UIControlEventEditingChanged];
  // search field image
  UIImageView *searchImage = [[UIImageView alloc] init];
  searchImage.alpha = 1;
  searchImage.frame = CGRectMake(5, 0, 18, 18);
  searchImage.image = [UIImage image: 
    [UIImage imageNamed: @"search_interest.png"] size: CGSizeMake(18, 18)];
  UIView *searchImageView = [[UIView alloc] init];
  searchImageView.frame = CGRectMake(0, 0, 28, 18);
  [searchImageView addSubview: searchImage];
  self.searchField.leftView = searchImageView;
  self.searchField.leftViewMode = UITextFieldViewModeAlways;
  self.navigationItem.titleView = self.searchField;
  // search results
  searchResults = [[UIView alloc] init];
  searchResults.backgroundColor = [UIColor blackColor];
  searchResults.frame = CGRectMake(0, 0, screen.size.width, 0);
  searchResults.hidden = YES;
  [self.navigationController.navigationBar addSubview: searchResults];
  // Main
  scroll = [[UIScrollView alloc] init];
  scroll.alwaysBounceVertical = YES;
  scroll.backgroundColor = [UIColor whiteColor];
  scroll.delegate = self;
  scroll.frame = screen;
  self.view = scroll;
  // Alert view
  alertView = [[UIAlertView alloc] init];
  alertView.delegate = self;
  [alertView addButtonWithTitle: @"Yes"];
  [alertView addButtonWithTitle: @"No"];
  // Skill header view
  skillHeaderView = [[UIView alloc] init];
  skillHeaderView.backgroundColor = [UIColor clearColor];
  skillHeaderView.frame = CGRectMake(0, 0, screen.size.width, 40);
  UILabel *skillHeaderLabel = [[UILabel alloc] init];
  skillHeaderLabel.backgroundColor = [UIColor clearColor];
  skillHeaderLabel.font = font20;
  skillHeaderLabel.frame = headerFrame;
  skillHeaderLabel.text = [User currentUser].tutor ? @"Skills" : @"Interests";
  skillHeaderLabel.textColor = gray50;
  [skillHeaderView addSubview: skillHeaderLabel];
  UIImageView *skillImageView = [[UIImageView alloc] init];
  skillImageView.frame = CGRectMake(10, 10, 18, 18);
  skillImageView.image = [UIImage image: [UIImage imageNamed: 
    @"skills_user.png"] size: imageSize];
  [skillHeaderView addSubview: skillImageView];
  [subviews addObject: skillHeaderView];
  // Skill box
  skillBox = [[UIView alloc] init];
  skillBox.backgroundColor = [UIColor gray: 240];
  skillBox.frame = CGRectMake(0, 40, screen.size.width, 0);
  [subviews addObject: skillBox];

  // Days view
  daysView = [[UIView alloc] init];
  daysView.backgroundColor = [UIColor clearColor];
  daysView.frame = CGRectMake(0, 40, screen.size.width, 40);
  UILabel *daysLabel = [[UILabel alloc] init];
  daysLabel.backgroundColor = [UIColor clearColor];
  daysLabel.font = font20;
  daysLabel.frame = headerFrame;
  daysLabel.text = @"Days of the week you are free";
  daysLabel.textColor = gray50;
  [daysView addSubview: daysLabel];
  UIImageView *daysImageView = [[UIImageView alloc] init];
  daysImageView.frame = CGRectMake(10, 10, 18, 18);
  daysImageView.image = [UIImage image: [UIImage imageNamed: 
    @"days_user.png"] size: imageSize];
  [daysView addSubview: daysImageView];
  [subviews addObject: daysView];
  dayBox = [[UIView alloc] init];
  dayBox.backgroundColor = [UIColor gray: 240];
  dayBox.frame = CGRectMake(0, (40 + 40), screen.size.width, 0);
  [subviews addObject: dayBox];

  // Hours view
  hoursView = [[UIView alloc] init];
  hoursView.backgroundColor = [UIColor clearColor];
  hoursView.frame = CGRectMake(0, (40 + 40), screen.size.width, (40 + 180));
  UILabel *hoursLabel = [[UILabel alloc] init];
  hoursLabel.backgroundColor = [UIColor clearColor];
  hoursLabel.font = font20;
  hoursLabel.frame = headerFrame;
  hoursLabel.text = @"Hours of the day you are free";
  hoursLabel.textColor = gray50;
  [hoursView addSubview: hoursLabel];
  UIImageView *hoursImageView = [[UIImageView alloc] init];
  hoursImageView.frame = imageFrame;
  hoursImageView.image = [UIImage image: [UIImage imageNamed: 
    @"hours_user.png"] size: imageSize];
  [hoursView addSubview: hoursImageView];
  [subviews addObject: hoursView];
  // hour box
  hourBox = [[UIView alloc] init];
  hourBox.backgroundColor = [UIColor gray: 240];
  hourBox.frame = CGRectMake(0, 40, screen.size.width, 180);
  [hoursView addSubview: hourBox];

  // About view
  aboutView = [[UIView alloc] init];
  aboutView.backgroundColor = [UIColor clearColor];
  aboutView.frame = CGRectMake(0, (40 + 40 + 40 + 180), screen.size.width, 100);
  UILabel *aboutLabel = [[UILabel alloc] init];
  aboutLabel.backgroundColor = [UIColor clearColor];
  aboutLabel.font = font20;
  aboutLabel.frame = headerFrame;
  aboutLabel.text = @"About";
  aboutLabel.textColor = gray50;
  [aboutView addSubview: aboutLabel];
  UIImageView *aboutImageView = [[UIImageView alloc] init];
  aboutImageView.frame = imageFrame;
  aboutImageView.image = [UIImage image: [UIImage imageNamed:
    @"about_user.png"] size: imageSize];
  [aboutView addSubview: aboutImageView];
  [subviews addObject: aboutView];
  // about box
  aboutBox = [[UIView alloc] init];
  aboutBox.backgroundColor = [UIColor clearColor];
  aboutBox.frame = CGRectMake(10, 40, (screen.size.width - 20), 60);
  aboutBox.layer.borderColor = [UIColor blackColor].CGColor;
  aboutBox.layer.borderWidth = 1;
  [aboutView addSubview: aboutBox];
  // about text view
  aboutTextView = [[UITextView alloc] init];
  aboutTextView.backgroundColor = [UIColor clearColor];
  // Top, left, bottom. right
  aboutTextView.contentInset = UIEdgeInsetsMake(-8, -8, -8, -8);
  aboutTextView.delegate = self;
  aboutTextView.frame = CGRectMake(10, 10, 
    (aboutBox.frame.size.width - 20), 40);
  aboutTextView.font = [UIFont fontWithName: @"HelveticaNeue" size: 15];
  aboutTextView.scrollEnabled = NO;
  if ([User currentUser].about) {
    aboutTextView.text = [User currentUser].about;
    aboutTextView.textColor = gray50;
  }
  else {
    aboutTextView.text = aboutTextViewPlaceholder;
    aboutTextView.textColor = [UIColor gray: 150];
  }
  [aboutBox addSubview: aboutTextView];

  // Location view
  locationView = [[UIView alloc] init];
  locationView.backgroundColor = [UIColor whiteColor];
  locationView.frame = CGRectMake(0, (40 + 40 + 40 + 180 + 100), 
    screen.size.width, (40 + 40 + 10 + 40));
  [subviews addObject: locationView];
  UILabel *locationLabel = [[UILabel alloc] init];
  locationLabel.backgroundColor = [UIColor clearColor];
  locationLabel.font = font20;
  locationLabel.frame = headerFrame;
  locationLabel.text = @"Location";
  locationLabel.textColor = gray50;
  [locationView addSubview: locationLabel];
  UIImageView *locationImageView = [[UIImageView alloc] init];
  locationImageView.frame = imageFrame;
  locationImageView.image = [UIImage image: [UIImage imageNamed:
    @"location.png"] size: imageSize];
  [locationView addSubview: locationImageView];
  // city field
  locationCityField = [[TextFieldPadding alloc] init];
  locationCityField.autocapitalizationType = UITextAutocapitalizationTypeWords;
  locationCityField.autocorrectionType = UITextAutocorrectionTypeYes;
  locationCityField.backgroundColor = [UIColor clearColor];
  locationCityField.clearButtonMode = UITextFieldViewModeWhileEditing;
  locationCityField.delegate = self;
  locationCityField.font = font14;
  locationCityField.frame = CGRectMake(10, 40, (screen.size.width - 20), 40);
  locationCityField.layer.borderColor = [UIColor blackColor].CGColor;
  locationCityField.layer.borderWidth = 1;
  locationCityField.paddingX = 10;
  locationCityField.paddingY = 10;
  locationCityField.placeholder = @"City";
  locationCityField.returnKeyType = UIReturnKeyDone;
  if ([User currentUser].city) {
    locationCityField.text = [[User currentUser].city nameTitle];
  }
  locationCityField.textColor = gray50;
  [locationView addSubview: locationCityField];
  // state field
  locationStateField = [[TextFieldPadding alloc] init];
  locationStateField.autocapitalizationType = UITextAutocapitalizationTypeWords;
  locationStateField.autocorrectionType = UITextAutocorrectionTypeYes;
  locationStateField.backgroundColor = [UIColor clearColor];
  locationStateField.clearButtonMode = UITextFieldViewModeWhileEditing;
  locationStateField.delegate = self;
  locationStateField.font = font14;
  locationStateField.frame = CGRectMake(10, (40 + 40 + 10), 
    (screen.size.width - 20), 40);
  locationStateField.layer.borderColor = [UIColor blackColor].CGColor;
  locationStateField.layer.borderWidth = 1;
  locationStateField.paddingX = 10;
  locationStateField.paddingY = 10;
  locationStateField.placeholder = @"State";
  locationStateField.returnKeyType = UIReturnKeyDone;
  if ([User currentUser].state) {
    locationStateField.text = [[User currentUser].state nameTitle];
  }
  locationStateField.textColor = gray50;
  [locationView addSubview: locationStateField];

  // Phone view
  phoneView = [[UIView alloc] init];
  phoneView.backgroundColor = [UIColor clearColor];
  phoneView.frame = CGRectMake(0, (40 + 40 + 40 + 180 + 100 + 130), 
    screen.size.width, (40 + 40 + 10));
  [subviews addObject: phoneView];
  UILabel *phoneLabel = [[UILabel alloc] init];
  phoneLabel.backgroundColor = [UIColor clearColor];
  phoneLabel.font = font20;
  phoneLabel.frame = headerFrame;
  if ([User currentUser].tutee) {
    phoneLabel.text = @"Parent's contact number";
  }
  else if ([User currentUser].tutor) {
    phoneLabel.text = @"Contact number";
  }
  phoneLabel.textColor = gray50;
  [phoneView addSubview: phoneLabel];
  UIImageView *phoneImageView = [[UIImageView alloc] init];
  phoneImageView.frame = imageFrame;
  phoneImageView.image = [UIImage image: [UIImage imageNamed:
    @"phone.png"] size: imageSize];
  [phoneView addSubview: phoneImageView];
  // phone field
  phoneField = [[TextFieldPadding alloc] init];
  phoneField.backgroundColor = [UIColor clearColor];
  phoneField.clearButtonMode = UITextFieldViewModeWhileEditing;
  phoneField.delegate = self;
  phoneField.font = font14;
  phoneField.frame = CGRectMake(10, 40, (screen.size.width - 20), 40);
  phoneField.keyboardType = UIKeyboardTypeNumberPad;
  phoneField.layer.borderColor = [UIColor blackColor].CGColor;
  phoneField.layer.borderWidth = 1;
  phoneField.paddingX = 10;
  phoneField.paddingY = 10;
  phoneField.placeholder = @"4081234567";
  if ([User currentUser].phone) {
    phoneField.text = [NSString stringWithFormat: 
      @"%0.0f", [User currentUser].phone];
  }
  phoneField.textColor = gray50;
  [phoneView addSubview: phoneField];
}

- (void) viewDidDisappear: (BOOL) animated
{
  [super viewDidDisappear: animated];
  [self resetBoxes];
}

- (void) viewWillAppear: (BOOL) animated
{
  [super viewWillAppear: animated];
  UserDetailConnection *connection = 
    [[UserDetailConnection alloc] initWithUser: [User currentUser]];
  connection.completionBlock = ^(NSError *error) {
    [self resetBoxes];
    [self refreshViews];
  };
  [connection start];
  [self refreshViews];
}

- (void) viewWillDisappear: (BOOL) animated
{
  [super viewWillDisappear: animated];
  [self doneEditing];
  [[[EditProfileConnection alloc] init] start];
}

#pragma mark - Protocol UIAlertViewDelegate

- (void) alertView: (UIAlertView *) alert
clickedButtonAtIndex: (NSInteger) buttonIndex
{
  if (buttonIndex == 0) {
    DeleteSkillConnection *connection = 
      [[DeleteSkillConnection alloc] initWithInterest: skillToRemove];
    [connection start];
    [[User currentUser] removeSkill: skillToRemove];
    [self resetBoxes];
    [self refreshViews];
  }
  else if (buttonIndex == 1) {
    [alertView dismissWithClickedButtonIndex: 1 animated: YES];
  }
  skillToRemove = nil;
}

#pragma mark - Protocol UIScrollViewDelegate

- (void) scrollViewDidScroll: (UIScrollView *) scrollView
{
  float y = scrollView.contentOffset.y;
  CGRect newFrame = searchResults.frame;
  if (y > 0) {
    newFrame.origin.y = y;
  }
  else {
    newFrame.origin.y = 0;
  }
  searchResults.frame = newFrame;
}

- (void) scrollViewWillBeginDragging: (UIScrollView *) scrollView
{
  [self.searchField resignFirstResponder];
  searchResults.hidden = YES;
  if ([locationCityField isFirstResponder] 
    || [locationStateField isFirstResponder]
      || [phoneField isFirstResponder]) {

    [self doneEditing];
  }
}

#pragma mark - UITextFieldDelegate

- (BOOL) textField: (UITextField *) textField 
shouldChangeCharactersInRange: (NSRange) range
replacementString: (NSString *) string
{
  if (textField == phoneField) {
    if ([textField.text length] > 10) {
      textField.text = [textField.text substringToIndex: 10];
      return NO;
    }
  }
  return YES;
}

- (void) textFieldDidBeginEditing: (UITextField *) textField
{
  if (textField == locationCityField 
    || textField == locationStateField
      || textField == phoneField) {

    if (!keyboardShowing) {
      [self toggleKeyboard];
      [self toggleSearchField];
    }
    else {
      [self scrollToBottom];
    }
    // Change the border color of the text field
    [self resetTextBorderColors];
    textField.layer.borderColor = [UIColor spadeGreen].CGColor;
  }
}

- (void) textFieldDidEndEditing: (UITextField *) textField
{
  // City and state
  if (textField == locationCityField || textField == locationStateField) {
    NSString *cityName  = [locationCityField.text lowercaseString];
    NSString *stateName = [locationStateField.text lowercaseString];
    State *state = [[StateStore sharedStore].states objectForKey: stateName];
    if (!state) {
      state = [[State alloc] init];
      state.name = stateName;
    }
    City *city = [state.cities objectForKey: cityName];
    if (!city) {
      city = [[City alloc] init];
      city.name = cityName;
    }
    [state addCity: city];
    if ([cityName length] > 0 && [stateName length] > 0) {
      [User currentUser].city  = city;
      [User currentUser].state = state;
      [[StateStore sharedStore] addState: state];
    }
  }
  // Phone
  else if (textField == phoneField) {
    if ([textField.text length] > 10) {
      textField.text = [textField.text substringToIndex: 10];
    }
    [User currentUser].phone = [textField.text doubleValue];
  }
  [User currentUser].updated = [[NSDate date] timeIntervalSince1970];
}

- (BOOL) textFieldShouldReturn: (UITextField *) textField
{
  if (textField == self.searchField) {
    [self addSkill];
  }
  else if (textField == locationCityField || textField == locationStateField) {
    [self doneEditing];
  }
  return NO;
}

#pragma mark - UITextViewDelegate

- (void) textViewDidBeginEditing: (UITextView *) textView
{
  if (!searchField.hidden) {
    [self toggleSearchField];
  }
  // Change the border color of the text view
  [self resetTextBorderColors];
  aboutBox.layer.borderColor = [UIColor spadeGreen].CGColor;
}

- (void) textViewDidChange: (UITextView *) textView
{
  [self refreshBottomViews];
}

- (void) textViewDidEndEditing: (UITextView *) textView
{
  if (textView == aboutTextView) {
    [User currentUser].about = textView.text;
    if (textView.text.length == 0) {
      textView.text      = aboutTextViewPlaceholder;
      textView.textColor = [UIColor gray: 150];
    }
  }
  [User currentUser].updated = [[NSDate date] timeIntervalSince1970];
}

- (BOOL) textViewShouldBeginEditing: (UITextView *) textView
{
  if ([aboutTextView.text isEqualToString: aboutTextViewPlaceholder]) {
    aboutTextView.text = @"";
    aboutTextView.textColor = [UIColor gray: 50];
  }
  return YES;
}

#pragma mark - Methods

- (void) addSkill
{
  NSArray *array = [self.searchField.text componentsSeparatedByString: @","];
  NSMutableArray *words = [NSMutableArray array];
  // Remove white space and lower case all the words
  for (NSString *string in array) {
    // Trim white space from beginning and end
    NSString *word = [string stringByTrimmingCharactersInSet: 
      [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    // Remove all non alpha numeric characters
    NSMutableCharacterSet *charactersToRemove = (NSMutableCharacterSet *)
      [[NSMutableCharacterSet alphanumericCharacterSet] invertedSet];
    // Except a hyphen
    [charactersToRemove removeCharactersInString: @" -"];
    word = [[word componentsSeparatedByCharactersInSet: 
      charactersToRemove] componentsJoinedByString: @""];
    // Trim white space from beginning and end again
    word = [word stringByTrimmingCharactersInSet:
      [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([word length]) {
      [words addObject: [word lowercaseString]];
    }
  }
  for (NSString *word in words) {
    Interest *interest = [[AllInterestStore sharedStore].interests objectForKey:
      word];
    if (!interest) {
      interest = [[Interest alloc] init];
      interest.name = word;
    }
    // Add skill
    [[[AddSkillConnection alloc] initWithInterest: interest] start];
    // Add interest/skill to user's skills
    [[User currentUser] addSkill: interest];
    // Add user to interest's tutees/tutors array
    if ([User currentUser].tutor) {
      [interest addUserToTutors: [User currentUser]];
    }
    else {
      [interest addUserToTutees: [User currentUser]];
    }
    // Add interest to browse interest store
    // [[BrowseInterestStore sharedStore] addInterest: interest];
  }
  self.searchField.text = @"";
  [self resetBoxes];
  [self refreshViews];
}

- (void) addSkillFromSearchResult: (id) sender
{
  if ([sender isKindOfClass: [EditInterestSearchResult class]]) {
    EditInterestSearchResult *button = (EditInterestSearchResult *) sender;
    self.searchField.text = button.nameLabel.text;
    [self addSkill];
    interests = nil;
    [self refreshSearchResults];
  }
}

- (void) doneEditing
{
  [aboutTextView resignFirstResponder];
  if (keyboardShowing) {
    [locationCityField resignFirstResponder];
    [locationStateField resignFirstResponder];
    [phoneField resignFirstResponder];
    [self toggleKeyboard];
  }
  if (self.searchField.hidden) {
    [self toggleSearchField];
  }
  [self resetTextBorderColors];
}

- (void) fetchInterests: (id) sender
{
  UITextField *textField = (UITextField *) sender;
  [self searchInterests: textField.text];
  InterestBrowseSearchConnection *connection = 
    [[InterestBrowseSearchConnection alloc] initWithTerm: textField.text];
  connection.completionBlock = ^(NSError *error) {
    [self searchInterests: self.searchField.text];
  };
  [connection start];
}

- (void) refreshSearchResults
{
  [searchResults removeFromSuperview];
  [scroll addSubview: searchResults];
  [scroll bringSubviewToFront: searchResults];
  [searchResults.subviews makeObjectsPerformSelector: 
    @selector(removeFromSuperview)];
  CGRect screen = [[UIScreen mainScreen] bounds];
  int row = 0;
  int rowHeight = 40;
  for (Interest *interest in interests) {
    EditInterestSearchResult *button = [[EditInterestSearchResult alloc] init];
    button.frame = CGRectMake(0, (row * rowHeight), screen.size.width, 
      rowHeight);
    button.nameLabel.text = [interest nameTitle];
    [button addTarget: self action: @selector(addSkillFromSearchResult:)
      forControlEvents: UIControlEventTouchUpInside];
    [searchResults addSubview: button];
    row += 1;
  }
  CGRect newFrame = searchResults.frame;
  newFrame.size.height = (interests.count * rowHeight) + 8;
  searchResults.frame = newFrame;
  if (interests.count > 0) {
    searchResults.hidden = NO;
  }
  else {
    searchResults.hidden = YES;
  }
}

- (void) refreshBottomViews
{
  // Position about
  // resize about text view
  CGSize textViewSize = [aboutTextView.text sizeWithFont: aboutTextView.font
    constrainedToSize: CGSizeMake(aboutTextView.frame.size.width - 16, 5000)
      lineBreakMode: NSLineBreakByWordWrapping];
  if (textViewSize.height < 20) {
    textViewSize.height = 20;
  }
  CGRect newAboutTextViewFrame = aboutTextView.frame;
  newAboutTextViewFrame.size.height = textViewSize.height;
  aboutTextView.frame = newAboutTextViewFrame;
  // resize about box
  CGRect newAboutBoxFrame = aboutBox.frame;
  newAboutBoxFrame.size.height = 20 + aboutTextView.frame.size.height;
  aboutBox.frame = newAboutBoxFrame;
  // resize about view
  CGRect newAboutViewFrame = aboutView.frame;
  newAboutViewFrame.origin.y = hoursView.frame.origin.y + 
    hoursView.frame.size.height;
  newAboutViewFrame.size.height = 40 + aboutBox.frame.size.height;
  aboutView.frame = newAboutViewFrame;

  // Position location
  CGRect locationFrame = locationView.frame;
  locationFrame.origin.y = aboutView.frame.origin.y + 
    aboutView.frame.size.height;
  locationView.frame = locationFrame;

  // Position phone
  CGRect phoneFrame = phoneView.frame;
  phoneFrame.origin.y = locationView.frame.origin.y + 
    locationView.frame.size.height;
  phoneView.frame = phoneFrame;

  // Add all views to scroll view
  float totalHeightSize = 0;
  for (UIView *v in subviews) {
    totalHeightSize += v.frame.size.height;
    [scroll addSubview: v];
  }
  // Set scroll view's content size
  if (keyboardShowing) {
    totalHeightSize += 216;
  }
  scroll.contentSize = CGSizeMake(scroll.frame.size.width, totalHeightSize);
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
  if ([User currentUser].skills) {
    for (Interest *interestObject in [User currentUser].skills) {
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
      [button addTarget: self action: @selector(removeSkill:)
        forControlEvents: UIControlEventTouchUpInside];
      [skillBox addSubview: button];
      rowLength += boxButtonWidthAndPadding;
    }
    CGRect skillBoxFrame = skillBox.frame;
    skillBoxFrame.size.height = ((row + 1) * rowHeight) + (padding * 2);
    skillBox.frame = skillBoxFrame;
  }

  // Position days
  CGRect newDaysViewFrame = daysView.frame;
  newDaysViewFrame.origin.y = 
    skillBox.frame.origin.y + skillBox.frame.size.height;
  daysView.frame = newDaysViewFrame;
  row = 0;
  rowLength = 10;
  float dayBoxButtonWidth = (screen.size.width - 20) / 3.0;
  for (Day *dayObject in [DayStore sharedStore].days) {
    DayBoxButton *button = [[DayBoxButton alloc] initWithDay: dayObject];
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
    [button addTarget: self action: @selector(toggleDayFree:)
      forControlEvents: UIControlEventTouchUpInside];
    // If user has the day free, select the button
    NSMutableArray *daysFree = [NSMutableArray array];
    for (DayFree *dayFree in [User currentUser].daysFree) {
      [daysFree addObject: [NSNumber numberWithInteger: dayFree.day.value]];
    }
    if ([daysFree containsObject: 
      [NSNumber numberWithInteger: dayObject.value]]) {

      [button select];
    }
    else {
      [button unselect];
    }
  }
  CGRect dayBoxFrame = dayBox.frame;
  dayBoxFrame.origin.y = daysView.frame.origin.y + daysView.frame.size.height;
  dayBoxFrame.size.height = ((row + 1) * rowHeight) + (padding * 2);
  dayBox.frame = dayBoxFrame;

  // Position hours
  CGRect newHoursViewFrame = hoursView.frame;
  newHoursViewFrame.origin.y = 
    dayBox.frame.origin.y + dayBox.frame.size.height;
  hoursView.frame = newHoursViewFrame;
  row = 0;
  rowLength = 10;
  float hourBoxButtonWidth = (screen.size.width - 20) / 6.0;
  for (Hour *hourObject in [HourStore sharedStore].hours) {
    HourBoxButton *button = [[HourBoxButton alloc] initWithHour: hourObject];
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
    if (hourObject.value == 0 || hourObject.value == 11) {
      button.nameLabel.text = [NSString stringWithFormat: 
        @"%@am", button.nameLabel.text];
    }
    else if (hourObject.value == 12 || hourObject.value == 23) {
      button.nameLabel.text = [NSString stringWithFormat: 
        @"%@pm", button.nameLabel.text];
    }
    [button addTarget: self action: @selector(toggleHourFree:)
      forControlEvents: UIControlEventTouchUpInside];
    // If user has the hour free, select the button
    NSMutableArray *hoursFree = [NSMutableArray array];
    NSMutableArray *allHours = [NSMutableArray arrayWithArray:
      [User currentUser].hoursFreeAm];
    [allHours addObjectsFromArray: [User currentUser].hoursFreePm];
    for (HourFree *hourFree in allHours) {
      [hoursFree addObject: [NSNumber numberWithInteger: hourFree.hour.value]];
    }
    if ([hoursFree containsObject: 
      [NSNumber numberWithInteger: hourObject.value]]) {

      [button select];
    }
    else {
      [button unselect];
    }
  }
  [self refreshBottomViews];
}

- (void) removeSkill: (id) sender
{
  [self.searchField resignFirstResponder];
  SkillBoxButton *button = (SkillBoxButton *) sender;
  skillToRemove = button.interest;
  alertView.title = [NSString stringWithFormat: @"Remove %@?", 
    [skillToRemove nameTitle]];
  [alertView show];
}

- (void) resetBoxes
{
  searchResults.hidden = YES;
  [skillBox.subviews makeObjectsPerformSelector: 
    @selector(removeFromSuperview)];
  [dayBox.subviews makeObjectsPerformSelector:
    @selector(removeFromSuperview)];
  [hourBox.subviews makeObjectsPerformSelector:
    @selector(removeFromSuperview)];
}

- (void) resetTextBorderColors
{
  aboutBox.layer.borderColor           = [UIColor blackColor].CGColor;
  locationCityField.layer.borderColor  = [UIColor blackColor].CGColor;
  locationStateField.layer.borderColor = [UIColor blackColor].CGColor;
  phoneField.layer.borderColor         = [UIColor blackColor].CGColor;
}

- (void) scrollToBottom
{
  CGRect screen = [[UIScreen mainScreen] bounds];
  scroll.contentOffset = CGPointMake(0, 
    scroll.contentSize.height - (screen.size.height - (20 + 44)));
}

- (void) searchInterests: (NSString *) string
{
  NSMutableArray *subpredicates = [NSMutableArray array];
  NSArray *words = [string componentsSeparatedByString: @","];
  for (NSString *word in words) {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:
      @"(%K BEGINSWITH %@) OR (%K CONTAINS %@)",
      @"name", [NSString stripLower: word],
      @"name", [NSString stripLower: word]
    ];
    [subpredicates addObject: predicate];
  }
  NSPredicate *allPredicates = 
    [NSCompoundPredicate orPredicateWithSubpredicates: subpredicates];
  NSArray *array = [[AllInterestStore sharedStore].interests allValues];
  NSArray *filteredArray = [array filteredArrayUsingPredicate: 
    allPredicates];
  NSSortDescriptor *sortName = [NSSortDescriptor sortDescriptorWithKey: @"name"
    ascending: YES];
  NSArray *sortedArray = [filteredArray sortedArrayUsingDescriptors:
    [NSArray arrayWithObject: sortName]];
  if (sortedArray.count > 5) {
    sortedArray = [sortedArray subarrayWithRange: NSMakeRange(0, 5)];
  }
  interests = sortedArray;
  [self refreshSearchResults];
}

- (void) toggleDayFree: (id) sender
{
  DayBoxButton *button = (DayBoxButton *) sender;
  // Remove free day
  if (button.selected) {
    [button unselect];
    [[User currentUser] removeFreeDay: button.day];
  }
  // Add free day
  else {
    [button select];
    [[User currentUser] addFreeDay: button.day];
  }
  [[[DayFreeConnection alloc] initWithDay: button.day] start];
}

- (void) toggleHourFree: (id) sender
{
  HourBoxButton *button = (HourBoxButton *) sender;
  if (button.selected) {
    [button unselect];
    [[User currentUser] removeFreeHour: button.hour];
  }
  else {
    [button select];
    [[User currentUser] addFreeHour: button.hour];
  }
  [[[HourFreeConnection alloc] initWithHour: button.hour] start];
}

- (void) toggleKeyboard
{
  int keyboardHeight = 216;
  CGSize size = scroll.contentSize;
  if (keyboardShowing) {
    size.height -= keyboardHeight;
    keyboardShowing = NO;
  }
  else {
    size.height += keyboardHeight;
    keyboardShowing = YES;
  }
  void (^animations) (void) = ^(void) {
    scroll.contentSize = CGSizeMake(size.width, size.height);
    [self scrollToBottom];
  };
  [UIView animateWithDuration: 0.2 delay: 0
    options: UIViewAnimationOptionCurveLinear animations: animations
      completion: nil];
}

- (void) toggleSearchField
{
  if (searchField.hidden) {
    self.navigationItem.rightBarButtonItem = addBarButtonItem;
    searchField.hidden = NO;
  }
  else {
    self.navigationItem.rightBarButtonItem = doneBarButtonItem;
    searchField.hidden = YES;
  }
}

@end
