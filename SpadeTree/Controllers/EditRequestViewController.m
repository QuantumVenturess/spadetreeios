//
//  EditRequestViewController.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 8/2/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "Choice.h"
#import "City.h"
#import "Day.h"
#import "EditRequestConnection.h"
#import "EditRequestViewController.h"
#import "State.h"
#import "StateStore.h"
#import "TextFieldPadding.h"
#import "UIColor+Extensions.h"

@implementation EditRequestViewController

#pragma mark - Initializer

- (id) initWithChoice: (Choice *) choiceObject
{
  self = [super init];
  if (self) {
    choice     = choiceObject;
    dates      = [NSMutableArray array];
    self.title = @"Set Date & Place";
    self.trackedViewName = @"Edit Request";

    // Dates
    NSDate *today        = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // Monday July 25, 2013
    NSDateComponents *components = [calendar components: 
      (NSDayCalendarUnit | NSMonthCalendarUnit | NSWeekdayCalendarUnit | 
        NSYearCalendarUnit) fromDate: today];
    NSInteger day   = [components day];
    NSInteger month = [components month];
    NSInteger year  = [components year];
    for (int i = day; i < 365; i++) {
      NSDateComponents *comps = [[NSDateComponents alloc] init];
      [comps setDay: i];
      [comps setMonth: month];
      [comps setYear: year];
      NSDate *date = [calendar dateFromComponents: comps];
      NSDateComponents *comps1 = [calendar components: 
        (NSDayCalendarUnit | NSMonthCalendarUnit | NSWeekdayCalendarUnit | 
          NSYearCalendarUnit) fromDate: date];
      if ([comps1 weekday] == choice.day.value + 1) {
        [dates addObject: date];
      }
    }
  }
  return self;
}

#pragma mark - Override UIViewController

- (void) loadView
{
  [super loadView];
  CGRect screen   = [[UIScreen mainScreen] bounds];
  UIFont *font14  = [UIFont fontWithName: @"HelveticaNeue" size: 14];
  UIFont *font15  = [UIFont fontWithName: @"HelveticaNeue" size: 15];
  UIFont *font20  = [UIFont fontWithName: @"HelveticaNeue" size: 20];
  UIColor *gray50 = [UIColor gray: 50];
  // Navigation
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
  NSString *submitString = @"Save";
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
  [submitButton addTarget: self action: @selector(save)
    forControlEvents: UIControlEventTouchUpInside];
  [submitButton addSubview: submitLabel];
  self.navigationItem.rightBarButtonItem = 
    [[UIBarButtonItem alloc] initWithCustomView: submitButton];
  // Main
  UIView *mainView = [[UIView alloc] init];
  mainView.backgroundColor = [UIColor whiteColor];
  mainView.frame = screen;
  self.view = mainView;
  // Tap
  UITapGestureRecognizer *tapGesture = 
    [[UITapGestureRecognizer alloc] initWithTarget: self 
      action: @selector(hideInputViews)];
  [self.view addGestureRecognizer: tapGesture];

  // Date
  UILabel *dateHeader = [[UILabel alloc] init];
  dateHeader.backgroundColor = [UIColor clearColor];
  dateHeader.font = font20;
  dateHeader.frame = CGRectMake(10, 20, (screen.size.width - 20), 40);
  dateHeader.text = [NSString stringWithFormat: 
    @"Choose a date on %@", [choice.day nameTitle]];
  dateHeader.textColor = gray50;
  [self.view addSubview: dateHeader];
  // button
  UIButton *dateButton = [[UIButton alloc] init];
  dateButton.backgroundColor = [UIColor clearColor];
  dateButton.frame = CGRectMake(10,
    (dateHeader.frame.origin.y + dateHeader.frame.size.height + 10), 
      (screen.size.width - 20), 40);
  dateButton.layer.borderColor = [UIColor blackColor].CGColor;
  dateButton.layer.borderWidth = 1;
  [dateButton addTarget: self action: @selector(showDatePicker)
    forControlEvents: UIControlEventTouchUpInside];
  [self.view addSubview: dateButton];
  // label
  dateLabel = [[UILabel alloc] init];
  dateLabel.backgroundColor = [UIColor clearColor];
  dateLabel.font = font15;
  dateLabel.frame = CGRectMake(10, 10, (dateButton.frame.size.width - 20), 20);
  dateLabel.textColor = [UIColor spadeGreenDark];
  [dateButton addSubview: dateLabel];

  // Place
  UILabel *placeHeader = [[UILabel alloc] init];
  placeHeader.backgroundColor = [UIColor clearColor];
  placeHeader.font = font20;
  placeHeader.frame = CGRectMake(10, 
    (dateButton.frame.origin.y + dateButton.frame.size.height + 20), 
      (screen.size.width - 20), 40);
  placeHeader.text = @"Pick a place to meet";
  placeHeader.textColor = gray50;
  [self.view addSubview: placeHeader];
  // address
  addressTextField = [[TextFieldPadding alloc] init];
  addressTextField.autocapitalizationType = UITextAutocapitalizationTypeWords;
  addressTextField.backgroundColor = [UIColor clearColor];
  addressTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
  addressTextField.delegate = self;
  addressTextField.font = font15;
  addressTextField.frame = CGRectMake(10, 
    (placeHeader.frame.origin.y + placeHeader.frame.size.height + 10),
      (screen.size.width - 20), 40);
  addressTextField.layer.borderColor = [UIColor blackColor].CGColor;
  addressTextField.layer.borderWidth = 1;
  addressTextField.paddingX = 10;
  addressTextField.paddingY = 10;
  addressTextField.placeholder = @"1234 Learning Street";
  addressTextField.returnKeyType = UIReturnKeyDone;
  addressTextField.textColor = gray50;
  [self.view addSubview: addressTextField];
  // city
  cityTextField = [[TextFieldPadding alloc] init];
  cityTextField.autocapitalizationType = UITextAutocapitalizationTypeWords;
  cityTextField.backgroundColor = [UIColor clearColor];
  cityTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
  cityTextField.delegate = self;
  cityTextField.font = font15;
  cityTextField.frame = CGRectMake(10, 
    (addressTextField.frame.origin.y + addressTextField.frame.size.height + 10),
      ((screen.size.width - 30) / 2.0), 40);
  cityTextField.layer.borderColor = [UIColor blackColor].CGColor;
  cityTextField.layer.borderWidth = 1;
  cityTextField.paddingX = 10;
  cityTextField.paddingY = 10;
  cityTextField.placeholder = @"Berkeley";
  cityTextField.returnKeyType = UIReturnKeyDone;
  cityTextField.textColor = gray50;
  [self.view addSubview: cityTextField];
  // state
  stateTextField = [[TextFieldPadding alloc] init];
  stateTextField.autocapitalizationType = UITextAutocapitalizationTypeWords;
  stateTextField.backgroundColor = [UIColor clearColor];
  stateTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
  stateTextField.delegate = self;
  stateTextField.font = font15;
  stateTextField.frame = CGRectMake(
    (cityTextField.frame.origin.x + cityTextField.frame.size.width + 10), 
      (addressTextField.frame.origin.y + addressTextField.frame.size.height + 
        10), ((screen.size.width - 30) / 2.0), 40);
  stateTextField.layer.borderColor = [UIColor blackColor].CGColor;
  stateTextField.layer.borderWidth = 1;
  stateTextField.paddingX = 10;
  stateTextField.paddingY = 10;
  stateTextField.placeholder = @"California";
  stateTextField.returnKeyType = UIReturnKeyDone;
  stateTextField.textColor = gray50;
  [self.view addSubview: stateTextField];

  // Date picker view
  datePickerView = [[UIPickerView alloc] init];
  datePickerView.dataSource = self;
  datePickerView.delegate   = self;
  datePickerView.frame = CGRectMake(0, (screen.size.height - (20 + 44)), 
    screen.size.width, 216);
  datePickerView.showsSelectionIndicator = NO;
  [self.view addSubview: datePickerView];
}

- (void) viewWillAppear: (BOOL) animated
{
  [super viewWillAppear: animated];
  // Date
  if (choice.date) {
    dateLabel.text = [choice dateStringLong];
    // Set selected row for date picker view to the date of choice
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *choiceDate   = [NSDate dateWithTimeIntervalSince1970: choice.date];
    NSDateComponents *choiceDateComps = [calendar components: 
      (NSDayCalendarUnit | NSMonthCalendarUnit | NSWeekdayCalendarUnit | 
        NSYearCalendarUnit) fromDate: choiceDate];
    NSUInteger index = [dates indexOfObjectPassingTest: 
      ^BOOL (id obj, NSUInteger idx, BOOL *stop) {
        NSDateComponents *dateComps = [calendar components: 
          (NSDayCalendarUnit | NSMonthCalendarUnit | NSWeekdayCalendarUnit | 
            NSYearCalendarUnit) fromDate: (NSDate *) obj];
        if ([choiceDateComps day] == [dateComps day] 
          && [choiceDateComps month] == [dateComps month]
            && [choiceDateComps year] == [dateComps year]) {

          return YES;
        }
        return NO;
      }
    ];
    if (index != NSNotFound) {
      [datePickerView selectRow: index inComponent: 0 animated: NO];
    }
  }
  else {
    dateLabel.text = @"Click to select a date";
  }
  // Address
  if ([choice.address length] > 0) {
    addressTextField.text = choice.address;
  }
  else {
    addressTextField.text = @"";
  }
  // City
  if (choice.city) {
    cityTextField.text = [choice.city nameTitle];
  }
  else {
    cityTextField.text = @"";
  }
  // State
  if (choice.city && choice.city.state) {
    stateTextField.text = [choice.city.state nameTitle];
  }
  else {
    stateTextField.text = @"";
  }
}

- (void) viewWillDisappear: (BOOL) animated
{
  [super viewWillDisappear: animated];
  [self hideInputViews];
}

#pragma mark - Protocol UIPickerViewDataSource

- (NSInteger) numberOfComponentsInPickerView: (UIPickerView *) pickerView
{
  return 1;
}

- (NSInteger) pickerView: (UIPickerView *) pickerView 
numberOfRowsInComponent: (NSInteger) component
{
  return dates.count;
}

#pragma mark - Protocol UIPickerViewDelegate

- (void) pickerView: (UIPickerView *) pickerView didSelectRow: (NSInteger) row
inComponent: (NSInteger) component
{
  NSDate *date = [dates objectAtIndex: row];
  NSDateFormatter *df = [[NSDateFormatter alloc] init];
  df.dateFormat  = @"EEE MMMM d, yyyy";
  dateLabel.text = [df stringFromDate: date];
}

- (CGFloat) pickerView: (UIPickerView *) pickerView 
rowHeightForComponent: (NSInteger) component
{
  return 60;
}

- (UIView *) pickerView: (UIPickerView *) pickerView viewForRow: (NSInteger) row
forComponent: (NSInteger) component reusingView: (UIView *) view
{
  UIFont *font = [UIFont fontWithName: @"HelveticaNeue" size: 20];
  NSDate *date = [dates objectAtIndex: row];
  NSDateFormatter *weekday = [[NSDateFormatter alloc] init];
  NSDateFormatter *month   = [[NSDateFormatter alloc] init];
  NSDateFormatter *day     = [[NSDateFormatter alloc] init];
  NSDateFormatter *year    = [[NSDateFormatter alloc] init];
  weekday.dateFormat = @"EEE";
  month.dateFormat   = @"MMMM";
  day.dateFormat     = @"d";
  year.dateFormat    = @"yyyy";
  // Main view
  UIView *mainView = [[UIView alloc] init];
  mainView.backgroundColor = [UIColor clearColor];
  // Weekday label
  UILabel *weekDayLabel = [[UILabel alloc] init];
  weekDayLabel.backgroundColor = [UIColor clearColor];
  weekDayLabel.font = font;
  weekDayLabel.frame = CGRectMake(10, 0, 50, 60);
  weekDayLabel.text  = [weekday stringFromDate: date];
  weekDayLabel.textColor = [UIColor gray: 150];
  [mainView addSubview: weekDayLabel];
  UILabel *monthLabel = [[UILabel alloc] init];
  monthLabel.backgroundColor = [UIColor clearColor];
  monthLabel.font = font;
  monthLabel.frame = CGRectMake(
    (weekDayLabel.frame.origin.x + weekDayLabel.frame.size.width), 0, 110, 60);
  monthLabel.text  = [month stringFromDate: date];
  monthLabel.textColor = [UIColor gray: 50];
  [mainView addSubview: monthLabel];
  // Day label
  UILabel *dayLabel = [[UILabel alloc] init];
  dayLabel.backgroundColor = [UIColor clearColor];
  dayLabel.font = font;
  dayLabel.frame = CGRectMake(
    (monthLabel.frame.origin.x + monthLabel.frame.size.width), 0, 40, 60);
  dayLabel.text = [day stringFromDate: date];
  dayLabel.textAlignment = NSTextAlignmentCenter;
  dayLabel.textColor = [UIColor gray: 50];
  [mainView addSubview: dayLabel];
  // Year label
  UILabel *yearLabel = [[UILabel alloc] init];
  yearLabel.backgroundColor = [UIColor clearColor];
  yearLabel.font = font;
  yearLabel.frame = CGRectMake(
    (dayLabel.frame.origin.x + dayLabel.frame.size.width), 0, 76, 60);
  yearLabel.text = [year stringFromDate: date];
  yearLabel.textAlignment = NSTextAlignmentCenter;
  yearLabel.textColor = [UIColor gray: 50];
  [mainView addSubview: yearLabel];
  return mainView;
}

#pragma mark - Protocol UITextFieldDelegate

- (void) textFieldDidBeginEditing: (UITextField *) textField
{
  [self showKeyboard];
}

- (BOOL) textFieldShouldReturn: (UITextField *) textField
{
  [self hideKeyboard];
  return YES;
}

#pragma mark - Methods

- (void) cancel
{
  [self dismissViewControllerAnimated: YES completion: nil];
}

- (void) hideDatePicker
{
  CGRect screen = [[UIScreen mainScreen] bounds];
  if (datePickerView.frame.origin.y < (screen.size.height - (20 + 44))) {
    CGRect frame = datePickerView.frame;
    frame.origin.y += datePickerView.frame.size.height;
    [UIView animateWithDuration: 0.15 delay: 0
      options: UIViewAnimationOptionCurveLinear animations: ^(void) {
        datePickerView.frame = frame;
      }
    completion: nil];
  }
}

- (void) hideKeyboard
{
  if ([addressTextField isFirstResponder] || [cityTextField isFirstResponder]
    || [stateTextField isFirstResponder]) {

    if (self.view.frame.origin.y < 0) {
      CGRect frame = self.view.frame;
      frame.origin.y = 0;
      void (^animations) (void) = ^(void) {
        self.view.frame = frame;
      };
      [UIView animateWithDuration: 0.15 delay: 0
        options: UIViewAnimationOptionCurveLinear animations: animations
          completion: nil];
    }
    [addressTextField resignFirstResponder];
    [cityTextField resignFirstResponder];
    [stateTextField resignFirstResponder];
  }
}

- (void) hideInputViews
{
  [self hideDatePicker];
  [self hideKeyboard];
}

- (void) showDatePicker
{
  CGRect frame = datePickerView.frame;
  frame.origin.y -= datePickerView.frame.size.height;
  // Hide keyboard if any of the text fields are first responders
  if ([addressTextField isFirstResponder] || [cityTextField isFirstResponder]
    || [stateTextField isFirstResponder]) {

    [self hideKeyboard];
    [UIView animateWithDuration: 0.15 delay: 0.15
      options: UIViewAnimationOptionCurveLinear animations: ^(void) {
        datePickerView.frame = frame;
      }
    completion: nil];
  }
  else {
    [UIView animateWithDuration: 0.15 delay: 0
      options: UIViewAnimationOptionCurveLinear animations: ^(void) {
        datePickerView.frame = frame;
      }
    completion: nil];
  }
}

- (void) showKeyboard
{
  CGRect screen = [[UIScreen mainScreen] bounds];
  float screenHeight = screen.size.height - (20 + 44);
  float diff = screenHeight - (cityTextField.frame.origin.y + 
    cityTextField.frame.size.height + 10 + 216);
  if (diff < 0 && self.view.frame.origin.y == 0) {
    CGRect frame = self.view.frame;
    frame.origin.y = diff;
    void (^animations) (void) = ^(void) {
      self.view.frame = frame;
    };
    // Hide date picker if its showing
    if (datePickerView.frame.origin.y < (screen.size.height - (20 + 44))) {
      [self hideDatePicker];
      [UIView animateWithDuration: 0.15 delay: 0.15
        options: UIViewAnimationOptionCurveLinear animations: animations
          completion: nil];
    }
    else {
      [UIView animateWithDuration: 0.15 delay: 0
        options: UIViewAnimationOptionCurveLinear animations: animations
          completion: nil];
    }
  }
}

- (void) save
{
  NSString *address = [addressTextField.text lowercaseString];
  if ([address length] > 0) {
    choice.address = address;
  }
  NSString *cityName  = [cityTextField.text lowercaseString];
  NSString *stateName = [stateTextField.text lowercaseString];
  if ([cityName length] > 0 && [stateName length] > 0) {
    State *state = [[StateStore sharedStore].states objectForKey: stateName];
    if (!state) {
      state      = [[State alloc] init];
      state.name = stateName;
      [[StateStore sharedStore] addState: state];
    }
    City *city = [state.cities objectForKey: cityName];
    if (!city) {
      city       = [[City alloc] init];
      city.name  = cityName;
      city.state = state;
      [state addCity: city];
    }
    choice.city = city;
  }
  NSDate *date = [dates objectAtIndex: 
    [datePickerView selectedRowInComponent: 0]];
  choice.date = [date timeIntervalSince1970];
  [[[EditRequestConnection alloc] initWithChoice: choice] start];
  [self cancel];
}

@end
