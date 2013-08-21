//
//  User.m
//  SpadeTree
//
//  Created by Tommy DANGerous on 6/28/13.
//  Copyright (c) 2013 Quantum Ventures. All rights reserved.
//

#import <Parse/Parse.h>
#import "AppDelegate.h"
#import "AllInterestStore.h"
#import "AllUserStore.h"
#import "AppDelegate.h"
#import "City.h"
#import "Day.h"
#import "DayFree.h"
#import "Hour.h"
#import "HourFree.h"
#import "Interest.h"
#import "MenuViewController.h"
#import "PickView.h"
#import "Review.h"
#import "SpadeTreeNavigationController.h"
#import "SpadeTreeTabBarController.h"
#import "State.h"
#import "StateStore.h"
#import "UIImage+Resize.h"
#import "User.h"
#import "UserAuthenticationConnection.h"
#import "UserDetailViewController.h"
#import "UserImageDownloader.h"

NSString *const AppTokenReceivedNotification = 
  @"AppTokenReceivedNotification";

@implementation User

@synthesize about;
@synthesize accessToken;
@synthesize appToken;
@synthesize city;
@synthesize email;
@synthesize facebookId;
@synthesize facebookLink;
@synthesize firstName;
@synthesize lastName;
@synthesize location;
@synthesize phone;
@synthesize readTutorial;
@synthesize tutee;
@synthesize tutor;
@synthesize uid;
// iOS
@synthesize daysFree;
@synthesize friendsTutored;
@synthesize hoursFreeAm;
@synthesize hoursFreePm;
@synthesize image;
@synthesize reviews;
@synthesize skills;
@synthesize state;
@synthesize updated;

#pragma mark - Initializer

- (id) init
{
  self = [super init];
  if (self) {
    self.daysFree       = [NSMutableArray array];
    self.friendsTutored = [NSMutableDictionary dictionary];
    self.hoursFreeAm    = [NSMutableArray array];
    self.hoursFreePm    = [NSMutableArray array];
    self.reviews        = [NSMutableArray array];
    self.skills         = [NSMutableArray array];
  }
  return self;
}

#pragma mark - Override NSObject

- (NSString *) description
{
  NSDictionary *dictionary = @{
    @"city": self.city ? self.city : @"",
    @"email": self.email ? self.email : @"",
    @"facebookId": [NSString stringWithFormat: @"%0.0f", self.facebookId],
    @"facebookLink": self.facebookLink ? self.facebookLink : @"",
    @"firstName": self.firstName ? self.firstName : @"",
    @"lastName": self.lastName ? self.lastName : @"",
    @"phone": [NSString stringWithFormat: @"%0.0f", self.phone],
    @"tutee": self.tutee ? @"Yes" : @"No",
    @"tutor": self.tutor ? @"Yes" : @"No",
    @"uid": [NSString stringWithFormat: @"%i", self.uid],
  };
  return [NSString stringWithFormat: @"%@", dictionary];
}

#pragma mark - Getters

- (NSMutableArray *) daysFree
{
  return [self daysFreeSortedByValue];
}

- (NSMutableArray *) hoursFreeAm
{
  return [self hoursFreeAmSortedByValue];
}

- (NSMutableArray *) hoursFreePm
{
  return [self hoursFreePmSortedByValue];
}

- (NSMutableArray *) reviews
{
  return [self reviewsSortedByCreated];
}

- (NSMutableArray *) skills
{
  return [self skillsSortedByName];
}

#pragma mark - Methods

+ (User *) currentUser
{
  static User *user = nil;
  if (!user) {
    user = [[User alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver: user
      selector: @selector(sessionStateChanged:)
        name: FBSessionStateChangedNotification object: nil];
  }
  return user;
}

- (void) addDayFree: (DayFree *) dayFree
{
  NSPredicate *predicate = [NSPredicate predicateWithFormat:
    @"%K == %i", @"value", dayFree.value];
  NSArray *array = [daysFree filteredArrayUsingPredicate: predicate];
  if (array.count == 0) {
    [daysFree addObject: dayFree];
  }
}

- (void) addFreeDay: (Day *) day
{
  DayFree *dayFree = [[DayFree alloc] init];
  dayFree.day      = day;
  dayFree.value    = day.value;
  [self addDayFree: dayFree];
}

- (void) addFreeHour: (Hour *) hour
{
  HourFree *hourFree = [[HourFree alloc] init];
  hourFree.hour      = hour;
  hourFree.value     = hour.value;
  if (hour.value < 12) {
    [self addHourFreeAm: hourFree];
  }
  else {
    [self addHourFreePm: hourFree];
  }
}

- (void) addHourFreeAm: (HourFree *) hourFree
{
  NSPredicate *predicate = [NSPredicate predicateWithFormat:
    @"%K == %i", @"value", hourFree.hour.value];
  NSArray *array = [hoursFreeAm filteredArrayUsingPredicate: predicate];
  if (array.count == 0) {
    [hoursFreeAm addObject: hourFree];
  }
}

- (void) addHourFreePm: (HourFree *) hourFree
{
  NSPredicate *predicate = [NSPredicate predicateWithFormat:
    @"%K == %i", @"value", hourFree.hour.value];
  NSArray *array = [hoursFreePm filteredArrayUsingPredicate: predicate];
  if (array.count == 0) {
    [hoursFreePm addObject: hourFree];
  }
}

- (void) addNewReview: (Review *) review
{
  [reviews insertObject: review atIndex: 0];
}

- (void) addReview: (Review *) review
{
  NSPredicate *predicate = [NSPredicate predicateWithFormat:
    @"%K == %i", @"uid", review.uid];
  NSArray *array = [reviews filteredArrayUsingPredicate: predicate];
  if (array.count == 0) {
    [reviews addObject: review];
  }
}

- (void) addSkill: (Interest *) interest
{
  NSPredicate *predicate = [NSPredicate predicateWithFormat: 
    @"%K == %@", @"name", interest.name];
  NSArray *array = [skills filteredArrayUsingPredicate: predicate];
  if (array.count == 0) {
    [skills addObject: interest];
  }
}

- (void) authenticateWithServer: (void (^) (NSError *error)) block
{
  UserAuthenticationConnection *connection = 
    [[UserAuthenticationConnection alloc] initWithUser: self];
  connection.completionBlock = block;
  [connection start];
  NSLog(@"Authenticate with server");
}

- (NSMutableArray *) daysFreeSortedByValue
{
  NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey: @"value"
    ascending: YES];
  return (NSMutableArray *) [daysFree sortedArrayUsingDescriptors:
    [NSArray arrayWithObject: sort]];
}

- (void) downloadImage: (void (^) (NSError *error)) block
{
  UserImageDownloader *downloader = 
    [[UserImageDownloader alloc] initWithUser: self];
  downloader.completionBlock = block;
  [downloader startDownload];
}

- (NSArray *) friendsTutoredSortedByName
{
  // [@{user, interests}, @{user, interests}]
  NSMutableArray *array = [NSMutableArray arrayWithArray: 
    [self.friendsTutored allValues]];
  [array sortUsingComparator: ^(id obj1, id obj2) {
    NSDictionary *obj1Dict = (NSDictionary *) obj1;
    NSDictionary *obj2Dict = (NSDictionary *) obj2;
    User *user1 = [obj1Dict objectForKey: @"user"];
    User *user2 = [obj2Dict objectForKey: @"user"];
    return [user1.firstName compare: user2.firstName];
  }];
  return array;
}

- (NSString *) fullName
{
  return [NSString stringWithFormat: @"%@ %@", 
    [self.firstName capitalizedString], [self.lastName substringToIndex: 1]];
}

- (void) getAccessToken: (NSDictionary *) dictionary
{
  if ([dictionary objectForKey: @"spadetree_token"]) {
    AppDelegate *appDelegate = (AppDelegate *)
      [UIApplication sharedApplication].delegate;
    self.appToken  = [dictionary objectForKey: @"spadetree_token"];
    [self readFromDictionary: [dictionary objectForKey: @"user"]];
    [self readFromDictionaryDaysAndHours: dictionary];
    // Alert all controllers of receiving app token
    [[NSNotificationCenter defaultCenter] postNotificationName:
      AppTokenReceivedNotification object: nil];
    // If user is not a tutee or a tutor, show pick view
    if (self.tutee || self.tutor) {
      appDelegate.pickView.hidden = YES;
      // If user has not read tutorial, show it
      if (!self.readTutorial) {
        [appDelegate.tabBarController showTutorial];
      }
      // If user is a tutor, subscribe them to their own choices channel
      if (self.tutor) {
        [self subscribeToChoicesChannel];
      }
    }
    else {
      appDelegate.pickView.hidden = NO;
      void (^animations) (void) = ^(void) {
        appDelegate.pickView.alpha = 1;
      };
      [UIView animateWithDuration: 0.1 delay: 0
        options: UIViewAnimationOptionCurveLinear animations: animations
          completion: nil];
    }
    // Download image
    [self downloadImage: ^(NSError *error) {
      MenuViewController *menu = (MenuViewController *) appDelegate.menu;
      menu.profileImageView.image = [self imageWithSize: CGSizeMake(30, 30)];
    }];
    // Load user data into profile view controller
    UserDetailViewController *userDetail = (UserDetailViewController *)
      [appDelegate.tabBarController.userDetailNav.viewControllers objectAtIndex:
        0];
    [userDetail loadUserData: self];
    // Add to all user store
    [[AllUserStore sharedStore] addUser: self];
    NSLog(@"App token received");
  }
  else {
    [[NSNotificationCenter defaultCenter] postNotificationName: 
      CurrentUserSignOut object: nil];
  } 
}

- (NSMutableArray *) hoursFreeAmSortedByValue
{
  NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey: @"value"
    ascending: YES];
  return (NSMutableArray *) [hoursFreeAm sortedArrayUsingDescriptors:
    [NSArray arrayWithObject: sort]];
}

- (NSMutableArray *) hoursFreePmSortedByValue
{
  NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey: @"value"
    ascending: YES];
  return (NSMutableArray *) [hoursFreePm sortedArrayUsingDescriptors:
    [NSArray arrayWithObject: sort]];
}

- (UIImage *) imageWithSize: (CGSize) size
{
  UIImage *img = self.image ? self.image : [UIImage imageNamed: 
    @"placeholder.png"];
  float newHeight, newWidth;
  if (img.size.width < img.size.height) {
    newWidth  = size.width;
    newHeight = (newWidth / img.size.width) * img.size.height;
  }
  else {
    newHeight = size.height;
    newWidth  = (newHeight / img.size.height) * img.size.width;
  }
  return [UIImage image: img size: CGSizeMake(newWidth, newHeight)];
}

- (NSURL *) imageURL
{
  NSString *string = [NSString stringWithFormat: 
    @"http://graph.facebook.com/%0.0f/picture?type=large", self.facebookId];
  return [NSURL URLWithString: string];
}

- (NSString *) locationString
{
  NSString *string = @"The World";
  if (self.tutor && self.city && self.state) {
    string = [NSString stringWithFormat: @"%@, %@", [self.city nameTitle], 
      [self.state nameTitle]];
  }
  else if (self.tutee && self.state) {
    string = [self.state nameTitle];
  }
  return string;
}

- (NSString *) pushNotificationChannelForAllChoices
{
  return [NSString stringWithFormat: @"all_choices_user_%i", self.uid];
}

- (void) readFromDictionary: (NSDictionary *) dictionary
{
  self.about = [dictionary objectForKey: @"about"];
  if ([dictionary objectForKey: @"state"] != [NSNull null]) {
    NSDictionary *stateDict = [dictionary objectForKey: @"state"];
    State *stateObject = [[StateStore sharedStore].states objectForKey:
      [stateDict objectForKey: @"name"]];
    if (!stateObject) {
      stateObject = [[State alloc] init];
      [stateObject readFromDictionary: stateDict];
    }
    self.state = stateObject;
    NSDictionary *cityDict = [dictionary objectForKey: @"city"];
    if (cityDict) {
      City *cityObject = [self.state.cities objectForKey: 
        [cityDict objectForKey: @"name"]];
      if (!cityObject) {
        cityObject = [[City alloc] init];
        [cityObject readFromDictionary: cityDict];
      }
      self.city = cityObject;
    }
  }
  if ([dictionary objectForKey: @"email"]) {
    self.email = [dictionary objectForKey: @"email"];
  }
  self.facebookId = [[dictionary objectForKey: @"facebook_id"] doubleValue];
  if ([dictionary objectForKey: @"facebook_link"]) {
    self.facebookLink = [dictionary objectForKey: @"facebook_link"];
  }
  self.firstName = [dictionary objectForKey: @"first_name"];
  self.lastName = [dictionary objectForKey: @"last_name"];
  if ([dictionary objectForKey: @"phone"]) {
    self.phone = [[dictionary objectForKey: @"phone"] doubleValue];
  }
  int userReadTutorial = [[dictionary objectForKey: 
    @"read_tutorial"] integerValue];
  if (userReadTutorial) {
    self.readTutorial = YES;
  }
  else {
    self.readTutorial = NO;
  }
  int tuteeValue = [[dictionary objectForKey: @"tutee"] integerValue];
  int tutorValue = [[dictionary objectForKey: @"tutor"] integerValue];
  if (tuteeValue) {
    self.tutee = YES;
    self.tutor = NO;
  }
  else if (tutorValue) {
    self.tutee = NO;
    self.tutor = YES;
  }
  else {
    self.tutee = NO;
    self.tutor = NO;
  }
  self.uid = [[dictionary objectForKey: @"id"] integerValue];
  [[AllUserStore sharedStore] addUser: self];
}

- (void) readFromDictionaryDaysAndHours: (NSDictionary *) dictionary
{
  // Days free
  NSArray *days = [dictionary objectForKey: @"days_free"];
  for (NSDictionary *dict in days) {
    DayFree *dayFree = [[DayFree alloc] init];
    [dayFree readFromDictionary: dict];
    [self addDayFree: dayFree];
  }
  // Hours free am
  NSArray *hoursAm = [dictionary objectForKey: @"hours_free_am"];
  for (NSDictionary *dict in hoursAm) {
    HourFree *hourFree = [[HourFree alloc] init];
    [hourFree readFromDictionary: dict];
    [self addHourFreeAm: hourFree];
  }
  // Hours free pm
  NSArray *hoursPm = [dictionary objectForKey: @"hours_free_pm"];
  for (NSDictionary *dict in hoursPm) {
    HourFree *hourFree = [[HourFree alloc] init];
    [hourFree readFromDictionary: dict];
    [self addHourFreePm: hourFree];
  }
}

- (void) readFromDictionaryFriendsTutored: (NSDictionary *) dictionary
{
  NSArray *groups = [dictionary objectForKey: @"groups"];
  if (groups.count > 0) {
    for (NSDictionary *dict in groups) {
      // User
      NSDictionary *userDict = [dict objectForKey: @"user"];
      int userId = [[userDict objectForKey: @"id"] integerValue];
      NSString *userIdString = [NSString stringWithFormat: @"%i", userId];
      User *userObject = [[AllUserStore sharedStore].users objectForKey: 
        userIdString];
      if (!userObject) {
        userObject = [[User alloc] init];
        [userObject readFromDictionary: userDict];
      }
      // Interests
      NSMutableArray *interests = [NSMutableArray array];
      NSArray *userInterests = [dict objectForKey: @"interests"];
      for (NSDictionary *interestDict in userInterests) {
        NSString *interestName = [interestDict objectForKey: @"name"];
        Interest *interest = 
          [[AllInterestStore sharedStore].interests objectForKey: interestName];
        if (!interest) {
          interest = [[Interest alloc] init];
          [interest readFromDictionary: interestDict];
        }
        [interests addObject: interest];
      }
      NSDictionary *groupDict = @{
        @"interests": interests,
        @"user"     : userObject
      };
      [self.friendsTutored setObject: groupDict forKey: userIdString];
    }
  }
}

- (void) readFromDictionaryReviews: (NSDictionary *) dictionary
{
  NSDictionary *array = [dictionary objectForKey: @"reviews"];
  if (array) {
    for (NSDictionary *dict in array) {
      Review *review = [[Review alloc] init];
      [review readFromDictionary: dict];
      [self addReview: review];
    }
  }
}

- (void) readFromDictionarySkills: (NSDictionary *) dictionary
{
  NSDictionary *array = [dictionary objectForKey: @"skills"];
  if (array) {
    for (NSDictionary *dict in array) {
      NSString *interestName = [dict objectForKey: @"name"];
      Interest *interest = 
        [[AllInterestStore sharedStore].interests objectForKey: interestName];
      if (!interest) {
        interest = [[Interest alloc] init];
        [interest readFromDictionary: dict];
      }
      [self addSkill: interest];
    }
  }
}

- (BOOL) recentlyUpdated
{
  if (self.updated + 60 > [[NSDate date] timeIntervalSince1970]) {
    return YES;
  }
  return NO;
}

- (void) removeFreeDay: (Day *) day
{
  NSPredicate *predicate = [NSPredicate predicateWithFormat:
    @"%K != %i", @"value", day.value];
  daysFree = [NSMutableArray arrayWithArray:
    [daysFree filteredArrayUsingPredicate: predicate]];
}

- (void) removeFreeHour: (Hour *) hour
{
  NSPredicate *predicate = [NSPredicate predicateWithFormat:
    @"%K != %i", @"value", hour.value];
  if (hour.value < 12) {
    hoursFreeAm = [NSMutableArray arrayWithArray:
      [hoursFreeAm filteredArrayUsingPredicate: predicate]];
  }
  else {
    hoursFreePm = [NSMutableArray arrayWithArray:
      [hoursFreePm filteredArrayUsingPredicate: predicate]];
  }
}

- (void) removeSkill: (Interest *) interest
{
  NSPredicate *predicate = [NSPredicate predicateWithFormat:
    @"%K != %@", @"name", interest.name];
  skills = [NSMutableArray arrayWithArray: 
    [skills filteredArrayUsingPredicate: predicate]];
}

- (NSMutableArray *) reviewsSortedByCreated
{
  NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey: @"created"
    ascending: NO];
  return (NSMutableArray *) [reviews sortedArrayUsingDescriptors:
    [NSArray arrayWithObject: sort]];
}

- (void) sessionStateChanged: (NSNotification *) notification
{
  void (^completion) (FBRequestConnection * connection, id <FBGraphUser> user,
    NSError *error) = ^(FBRequestConnection * connection, 
      id <FBGraphUser> user, NSError *error) {

    if (!error) {
      User *currentUser = [User currentUser];
      currentUser.about = [user objectForKey: @"bio"];
      currentUser.accessToken = 
        [[[FBSession activeSession] accessTokenData] accessToken];
      currentUser.email = [user objectForKey: @"email"];
      currentUser.facebookId = [[user objectForKey: @"id"] doubleValue];
      currentUser.facebookLink = user.link;
      currentUser.firstName = user.first_name;
      currentUser.lastName = user.last_name;
      currentUser.location = user.location.name;
      NSArray *locations = [user.location.name componentsSeparatedByString: 
        @","];
      if (locations.count >= 2) {
        NSString *cityName = [locations objectAtIndex: 0];
        NSString *stateName = [locations objectAtIndex: 1];
        cityName = [cityName stringByTrimmingCharactersInSet: 
          [NSCharacterSet whitespaceCharacterSet]];
        cityName = [cityName lowercaseString];
        stateName = [stateName stringByTrimmingCharactersInSet:
          [NSCharacterSet whitespaceCharacterSet]];
        stateName = [stateName lowercaseString];
        State *stateObject = [[StateStore sharedStore].states objectForKey:
          stateName];
        if (!stateObject) {
          stateObject = [[State alloc] init];
          stateObject.name = stateName;
          stateObject.slug = 
            [stateObject.name stringByReplacingOccurrencesOfString: @" " 
              withString: @"-"];
          [[StateStore sharedStore] addState: stateObject];
        }
        City *cityObject = [stateObject.cities objectForKey: cityName];
        if (!cityObject) {
          cityObject = [[City alloc] init];
          cityObject.name = cityName;
          cityObject.slug = 
            [cityObject.name stringByReplacingOccurrencesOfString: @" "
              withString: @"-"];
          cityObject.state = stateObject;
          [stateObject addCity: cityObject];
        }
        self.city = cityObject;
      }
      NSLog(@"Facebook active session is open");
      [self authenticateWithServer: nil];
    }
    else {
      AppDelegate *appDelegate = (AppDelegate *) 
        [UIApplication sharedApplication].delegate;
      UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: @"Facebook"
        message: @"Facebook authentication failed" delegate: appDelegate
          cancelButtonTitle: @"Try again" otherButtonTitles: nil];
      [alertView show];
    }
  };
  if (FBSession.activeSession.isOpen) {
    [FBRequestConnection startForMeWithCompletionHandler: completion];
  }
}

- (void) signOut
{
  self.about        = nil;
  self.accessToken  = nil;
  self.appToken     = nil;
  self.city         = nil;
  self.email        = nil;
  self.facebookId   = 0;
  self.facebookLink = nil;
  self.firstName    = nil;
  self.lastName     = nil;
  self.location     = nil;
  self.phone        = 0;
  self.tutee        = NO;
  self.tutor        = NO;
  self.uid          = 0;
  // iOS
  [daysFree removeAllObjects];
  [friendsTutored removeAllObjects];
  [hoursFreeAm removeAllObjects];
  [hoursFreePm removeAllObjects];
  self.image = nil;
  [reviews removeAllObjects];
  [skills removeAllObjects];
  self.state = nil;
}

- (NSMutableArray *) skillsSortedByName
{
  NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey: @"name"
    ascending: YES];
  return (NSMutableArray *) [skills sortedArrayUsingDescriptors:
    [NSArray arrayWithObject: sort]];
}

- (NSString *) slug
{
  return [NSString stringWithFormat: @"%@-%i", 
    [self.firstName lowercaseString], self.uid];
}

- (void) subscribeToChoicesChannel
{
  PFInstallation *currentInstallation = [PFInstallation currentInstallation];
  [currentInstallation addUniqueObject: 
    [self pushNotificationChannelForAllChoices] forKey: @"channels"];
  [currentInstallation saveInBackground];
}

@end
