//
//  ChoiceDetailViewController.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 8/1/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import "AppDelegate.h"
#import "Choice.h"
#import "ChoiceActionConnection.h"
#import "ChoiceDetailViewController.h"
#import "ChoiceNote.h"
#import "ChoiceNoteCell.h"
#import "ChoiceNotesConnection.h"
#import "City.h"
#import "Day.h"
#import "EditRequestViewController.h"
#import "Hour.h"
#import "Interest.h"
#import "MenuViewController.h"
#import "NewChoiceNoteViewController.h"
#import "RequestsCountConnection.h"
#import "SpadeTreeNavigationController.h"
#import "State.h"
#import "UIColor+Extensions.h"
#import "UIImage+Resize.h"
#import "User.h"
#import "UserDetailViewController.h"

@implementation ChoiceDetailViewController

#pragma mark - Initializer

- (id) initWithChoice: (Choice *) choiceObject
{
  self = [super init];
  if (self) {
    choice = choiceObject;
    if ([User currentUser].tutee) {
      self.title = [choice.tutor fullName];
      editRequestNav = 
        [[SpadeTreeNavigationController alloc] initWithRootViewController: 
          [[EditRequestViewController alloc] initWithChoice: choice]];
    }
    else {
      self.title = [choice.tutee fullName];
    }
    self.title = [choice.interest nameTitle];
    self.trackedViewName = [NSString stringWithFormat: 
      @"Choice Detail %i", choice.uid];
  }
  return self;
}

#pragma mark - Override SpadeTreeTableViewController

- (void) loadView
{
  [super loadView];
  CGRect screen = [[UIScreen mainScreen] bounds];
  UIFont *font15 = [UIFont fontWithName: @"HelveticaNeue" size: 15];
  UIFont *font20 = [UIFont fontWithName: @"HelveticaNeue" size: 20];
  UIImage *addNoteImage = [UIImage image: [UIImage imageNamed: @"add_note.png"]
    size: CGSizeMake(24, 24)];
  UIButton *addNoteButton = [UIButton buttonWithType: UIButtonTypeCustom];
  addNoteButton.frame = CGRectMake(0, 0, (24 + 12), 24);
  [addNoteButton addTarget: self action: @selector(newNote)
    forControlEvents: UIControlEventTouchUpInside];
  [addNoteButton setImage: addNoteImage forState: UIControlStateNormal];
  // [addNoteButton addSubview: addNoteLabel];
  self.navigationItem.rightBarButtonItem = 
    [[UIBarButtonItem alloc] initWithCustomView: addNoteButton];
  // Table header view
  UIView *headerView = [[UIView alloc] init];
  headerView.backgroundColor = [UIColor clearColor];
  headerView.frame = CGRectMake(0, 0, screen.size.width, 360);
  self.table.tableHeaderView = headerView;
  // Accept button
  acceptButtonLabel = [[UILabel alloc] init];
  acceptButtonLabel.backgroundColor = [UIColor clearColor];
  acceptButtonLabel.font = font15;
  acceptButtonLabel.frame = CGRectMake(0, 0, (screen.size.width / 3.0), 40);
  acceptButtonLabel.textAlignment = NSTextAlignmentCenter;
  acceptButtonLabel.textColor = [UIColor whiteColor];
  acceptButton = [[UIButton alloc] init];
  acceptButton.backgroundColor = [UIColor spadeGreen];
  acceptButton.frame = CGRectMake(10, 20, (screen.size.width / 3.0), 40);
  [acceptButton addSubview: acceptButtonLabel];
  [acceptButton addTarget: self action: @selector(acceptChoice)
    forControlEvents: UIControlEventTouchUpInside];
  [headerView addSubview: acceptButton];
  // Deny button
  denyButtonLabel = [[UILabel alloc] init];
  denyButtonLabel.backgroundColor = [UIColor clearColor];
  denyButtonLabel.font = font15;
  denyButtonLabel.frame = CGRectMake(0, 0, (screen.size.width / 3.0), 40);
  denyButtonLabel.textAlignment = NSTextAlignmentCenter;
  denyButtonLabel.textColor = [UIColor whiteColor];
  denyButton = [[UIButton alloc] init];
  denyButton.backgroundColor = [UIColor gray: 50];
  denyButton.frame = CGRectMake(
    (screen.size.width - ((screen.size.width / 3.0) + 10)), 20, 
      (screen.size.width / 3.0), 40);
  [denyButton addSubview: denyButtonLabel];
  [denyButton addTarget: self action: @selector(denyChoice)
    forControlEvents: UIControlEventTouchUpInside];
  [headerView addSubview: denyButton];
  // Completed label
  completedLabel = [[UILabel alloc] init];
  completedLabel.backgroundColor = [UIColor clearColor];
  completedLabel.font = [UIFont fontWithName: @"HelveticaNeue" size: 20];
  completedLabel.frame = CGRectMake(10, 20, (screen.size.width - 20), 40);
  completedLabel.textAlignment = NSTextAlignmentCenter;
  [headerView addSubview: completedLabel];

  // Day and hour view
  UIView *dayHourView = [[UIView alloc] init];
  dayHourView.backgroundColor = [UIColor clearColor];
  dayHourView.frame = CGRectMake(0, (20 + 40 + 20), screen.size.width, 70);
  [headerView addSubview: dayHourView];
  // image view
  UIImageView *dayHourImageView = [[UIImageView alloc] init];
  dayHourImageView.frame = CGRectMake(10, 11, 18, 18);
  dayHourImageView.image = [UIImage image: 
    [UIImage imageNamed: @"days_user.png"] size: CGSizeMake(18, 18)];
  [dayHourView addSubview: dayHourImageView];
  // label
  UILabel *dayHourLabel = [[UILabel alloc] init];
  dayHourLabel.backgroundColor = [UIColor clearColor];
  dayHourLabel.font = font20;
  dayHourLabel.frame = CGRectMake((10 + 18 + 10), 0, 
    (screen.size.width - (10 + 18 + 10 + 10)), 40);
  dayHourLabel.text = [NSString stringWithFormat: @"%@ at %@",
    [choice.day nameTitle], [choice.hour hourAndAmPm]];
  dayHourLabel.textColor = [UIColor gray: 50];
  [dayHourView addSubview: dayHourLabel];
  // Date label
  dateLabel = [[UILabel alloc] init];
  dateLabel.backgroundColor = [UIColor clearColor];
  dateLabel.font = font15;
  dateLabel.frame = CGRectMake((10 + 18 + 10), 40, 
    (screen.size.width - (10 + 18 + 10 + 10)), 30);
  dateLabel.textColor = [UIColor gray: 50];
  [dayHourView addSubview: dateLabel];

  // Location view
  UIView *locationView = [[UIView alloc] init];
  locationView.backgroundColor = [UIColor clearColor];
  locationView.frame = CGRectMake(0, (20 + 40 + 20 + 70 + 10), 
    screen.size.width, 100);
  [headerView addSubview: locationView];
  // image view
  UIImageView *locationImageView = [[UIImageView alloc] init];
  locationImageView.frame = CGRectMake(10, 11, 18, 18);
  locationImageView.image = [UIImage image: 
    [UIImage imageNamed: @"location.png"] size: CGSizeMake(18, 18)];
  [locationView addSubview: locationImageView];
  // label
  UILabel *locationLabel = [[UILabel alloc] init];
  locationLabel.backgroundColor = [UIColor clearColor];
  locationLabel.font = font20;
  locationLabel.frame = CGRectMake((10 + 18 + 10), 0, 
    (screen.size.width - (10 + 18 + 10 + 10)), 40);
  locationLabel.text = @"Place to meet";
  locationLabel.textColor = [UIColor gray: 50];
  [locationView addSubview: locationLabel];
  // address label
  addressLabel = [[UILabel alloc] init];
  addressLabel.backgroundColor = [UIColor clearColor];
  addressLabel.font = font15;
  addressLabel.frame = CGRectMake((10 + 18 + 10), 40, 
    (screen.size.width - (10 + 18 + 10 + 10)), 30);
  addressLabel.textColor = [UIColor gray: 50];
  [locationView addSubview: addressLabel];
  // city state label
  cityStateLabel = [[UILabel alloc] init];
  cityStateLabel.backgroundColor = [UIColor clearColor];
  cityStateLabel.font = font15;
  cityStateLabel.frame = CGRectMake(addressLabel.frame.origin.x,
    (addressLabel.frame.origin.y + addressLabel.frame.size.height),
      addressLabel.frame.size.width, addressLabel.frame.size.height);
  cityStateLabel.textColor = [UIColor gray: 50];
  [locationView addSubview: cityStateLabel];

  // Phone view
  UIView *phoneView = [[UIView alloc] init];
  phoneView.backgroundColor = [UIColor clearColor];
  phoneView.frame = CGRectMake(0, 
    (locationView.frame.origin.y + locationView.frame.size.height + 10), 
      screen.size.width, 70);
  [headerView addSubview: phoneView];
  // image view
  UIImageView *phoneImageView = [[UIImageView alloc] init];
  phoneImageView.frame = CGRectMake(10, 11, 18, 18);
  phoneImageView.image = [UIImage image: 
    [UIImage imageNamed: @"phone.png"] size: CGSizeMake(18, 18)];
  [phoneView addSubview: phoneImageView];
  // label
  phoneLabel = [[UILabel alloc] init];
  phoneLabel.backgroundColor = [UIColor clearColor];
  phoneLabel.font = font20;
  phoneLabel.frame = CGRectMake((10 + 18 + 10), 0, 
    (screen.size.width - (10 + 18 + 10 + 10)), 40);
  phoneLabel.text = @"Contact number";
  phoneLabel.textColor = [UIColor gray: 50];
  [phoneView addSubview: phoneLabel];
  // phone label
  phoneLabel = [[UILabel alloc] init];
  phoneLabel.backgroundColor = [UIColor clearColor];
  phoneLabel.font = font15;
  phoneLabel.frame = CGRectMake((10 + 18 + 10), 40, 
    (screen.size.width - (10 + 18 + 10 + 10)), 30);
  phoneLabel.hidden = YES;
  phoneLabel.text = @"No contact number yet";
  phoneLabel.textColor = [UIColor gray: 50];
  [phoneView addSubview: phoneLabel];
  // Phone button
  phoneButton = [[UIButton alloc] init];
  phoneButton.backgroundColor = [UIColor clearColor];
  phoneButton.frame = phoneLabel.frame;
  phoneButton.hidden = YES;
  [phoneButton addTarget: self action: @selector(phoneContact)
    forControlEvents: UIControlEventTouchUpInside];
  [phoneView addSubview: phoneButton];
  phoneButtonLabel = [[UILabel alloc] init];
  phoneButtonLabel.backgroundColor = [UIColor clearColor];
  phoneButtonLabel.font = font15;
  phoneButtonLabel.frame = CGRectMake(0, 0, phoneButton.frame.size.width,
    phoneButton.frame.size.height);
  phoneButtonLabel.textColor = [UIColor spadeGreenDark];
  [phoneButton addSubview: phoneButtonLabel];
}

- (void) viewWillAppear: (BOOL) animated
{
  [super viewWillAppear: animated];
  ChoiceNotesConnection *connection =
    [[ChoiceNotesConnection alloc] initWithChoice: choice];
  connection.completionBlock = ^(NSError *error) {
    [self.table reloadData];
  };
  [connection start];
  [self refreshViews];
  [self.table reloadData];
}

#pragma mark - Protocol UITableViewDataSource

- (UITableViewCell *) tableView: (UITableView *) tableView
cellForRowAtIndexPath: (NSIndexPath *) indexPath
{
  static NSString *identifier = @"ChoiceNoteCell";
  ChoiceNoteCell *cell = [tableView dequeueReusableCellWithIdentifier:
    identifier];
  if (!cell) {
    cell = [[ChoiceNoteCell alloc] initWithStyle: UITableViewCellStyleDefault
      reuseIdentifier: identifier];
  }
  ChoiceNote *choiceNote = [choice.notes objectAtIndex: indexPath.row];
  [cell loadChoiceNoteData: choiceNote];
  return cell;
}

- (NSInteger) numberOfSectionsInTableView: (UITableView *) tableView
{
  return 1;
}

- (NSInteger) tableView: (UITableView *) tableView
numberOfRowsInSection: (NSInteger) section
{
  return choice.notes.count;
}

#pragma mark - Protocol UITableViewDelegate

- (void) tableView: (UITableView *) tableView
didSelectRowAtIndexPath: (NSIndexPath *) indexPath
{
  ChoiceNote *choiceNote = [choice.notes objectAtIndex: indexPath.row];
  [self.navigationController pushViewController: 
    [[UserDetailViewController alloc] initWithUser: choiceNote.user] 
      animated: YES];
}

- (CGFloat) tableView: (UITableView *) tableView
heightForHeaderInSection: (NSInteger) section
{
  return 40;
}

- (CGFloat) tableView: (UITableView *) tableView
heightForRowAtIndexPath: (NSIndexPath *) indexPath
{
  ChoiceNote *choiceNote = [choice.notes objectAtIndex: indexPath.row];
  CGSize textSize = [choiceNote.content sizeWithFont: 
    [UIFont fontWithName: @"HelveticaNeue" size: 14] 
      constrainedToSize: CGSizeMake(tableView.frame.size.width - 20, 1000)];
  return 10 + 40 + 10 + textSize.height + 10;
}

- (UIView *) tableView: (UITableView *) tableView
viewForHeaderInSection: (NSInteger) section
{
  int imageSize = 18;
  UIView *header = [[UIView alloc] init];
  header.backgroundColor = [UIColor colorWithRed: 255 green: 255 blue: 255
    alpha: 0.7];
  header.frame = CGRectMake(0, 0, tableView.frame.size.width, 40);
  UILabel *label = [[UILabel alloc] init];
  label.backgroundColor = [UIColor clearColor];
  label.font = [UIFont fontWithName: @"HelveticaNeue" size: 20];
  label.frame = CGRectMake((10 + imageSize + 10), 0, 
    (tableView.frame.size.width - (10 + imageSize + 10 + 10)), 40);
  label.text = @"Notes";
  label.textColor = [UIColor gray: 50];
  [header addSubview: label];
  UIImageView *imageView = [[UIImageView alloc] init];
  imageView.frame = CGRectMake(10, 10, imageSize, imageSize);
  imageView.image = [UIImage image: [UIImage imageNamed: @"notes.png"]
    size: CGSizeMake(imageSize, imageSize)];
  [header addSubview: imageView];
  return header;
}

#pragma mark - Methods

- (void) acceptChoice
{
  if ([User currentUser].tutee) {
    [self presentViewController: editRequestNav animated: YES completion: nil];
  }
  else if ([User currentUser].tutor) {
    choice.accepted = YES;
    choice.denied   = NO;
    ChoiceActionConnection *connection = 
      [[ChoiceActionConnection alloc] initWithChoice: choice];
    connection.completionBlock = ^(NSError *error) {
      [[[RequestsCountConnection alloc] init] start];
    };
    [connection start];
  }
  [self refreshViews];
}

- (void) denyChoice
{
  if ([User currentUser].tutee) {
    choice.completed     = YES;
    choice.dateCompleted = [[NSDate date] timeIntervalSince1970];
  }
  else if ([User currentUser].tutor) {
    choice.accepted = NO;
    choice.denied   = YES;
  }
  ChoiceActionConnection *connection = 
    [[ChoiceActionConnection alloc] initWithChoice: choice];
  connection.completionBlock = ^(NSError *error) {
    [[[RequestsCountConnection alloc] init] start];
  };
  [connection start];
  [self refreshViews];
}

- (void) newNote
{
  [self presentViewController: 
    [[SpadeTreeNavigationController alloc] initWithRootViewController: 
      [[NewChoiceNoteViewController alloc] initWithChoice: choice]] 
        animated: YES completion: nil];
}

- (void) phoneContact
{
  NSString *phoneNumber;
  if ([User currentUser].tutee) {
    phoneNumber = [NSString stringWithFormat: @"%0.0f", choice.tutorPhone];
  }
  else {
    phoneNumber = [NSString stringWithFormat: @"%0.0f", choice.tuteePhone];
  }
  NSString *string = [@"telprompt:" stringByAppendingString: phoneNumber];
  [[UIApplication sharedApplication] openURL: [NSURL URLWithString: string]];
}

- (void) refreshViews
{
  // Accept / Deny buttons
  completedLabel.hidden = YES;
  if ([User currentUser].tutee) {
    acceptButtonLabel.text = @"Edit Request";
    denyButtonLabel.text   = @"Completed";
    denyButton.hidden = YES;
    if (choice.accepted) {
      denyButton.hidden = NO;
    }
    if (choice.denied) {
      acceptButton.hidden      = YES;
      denyButton.hidden        = YES;
      completedLabel.hidden    = NO;
      completedLabel.text      = @"Request Denied";
      completedLabel.textColor = [UIColor red];
    }
  }
  else {
    acceptButtonLabel.text = @"Accept";
    denyButtonLabel.text   = @"Deny";
    acceptButton.hidden = NO;
    denyButton.hidden   = NO;
    if (choice.accepted) {
      acceptButton.hidden = YES;
      denyButton.hidden   = NO;
    }
    if (choice.denied) {
      acceptButton.hidden = NO;
      denyButton.hidden   = YES;
    }
  }
  if (choice.completed) {
    acceptButton.hidden      = YES;
    denyButton.hidden        = YES;
    completedLabel.hidden    = NO;
    completedLabel.text      = @"Tutoring Completed";
    completedLabel.textColor = [UIColor spadeGreen];
  }
  UIColor *gray50  = [UIColor gray: 50];
  UIColor *gray150 = [UIColor gray: 150];
  // Date
  if (choice.date) {
    dateLabel.text = [choice dateStringLong];
    dateLabel.textColor = gray50;
  }
  else {
    dateLabel.text = @"Exact date has not been specified";
    dateLabel.textColor = gray150;
  }
  // Address
  if ([choice.address length] > 0) {
    addressLabel.text = [choice.address capitalizedString];
    addressLabel.textColor = gray50;
  }
  else {
    addressLabel.text = @"Waiting for address";
    addressLabel.textColor = gray150;
  }
  // City
  if (choice.city && choice.city.state) {
    cityStateLabel.text = [NSString stringWithFormat: @"%@, %@",
      [choice.city nameTitle], [choice.city.state nameTitle]];
    cityStateLabel.textColor = gray50;
  }
  else {
    cityStateLabel.text = @"Somewhere in the world";
    cityStateLabel.textColor = gray150;
  }
  // Phone
  NSString *phoneNumber;
  if ([User currentUser].tutee) {
    phoneNumber = [NSString stringWithFormat: @"%0.0f", choice.tutorPhone];
  }
  else {
    phoneNumber = [NSString stringWithFormat: @"%0.0f", choice.tuteePhone];
  }
  if ([phoneNumber length] >= 10) {
    phoneNumber = [NSString stringWithFormat: @"(%@) %@-%@",
      [phoneNumber substringWithRange: NSMakeRange(0, 3)],
        [phoneNumber substringWithRange: NSMakeRange(3, 3)],
          [phoneNumber substringWithRange: NSMakeRange(6, 4)]];
    phoneButtonLabel.text = phoneNumber;
    phoneButton.hidden    = NO;
    phoneLabel.hidden     = YES;
  }
  else {
    phoneButton.hidden = YES;
    phoneLabel.hidden  = NO;
  }
}

@end
