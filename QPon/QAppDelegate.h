/*
    This is the class that holds the user's information as well as their favourites selection. Simply is a container class.
    Also holds default IOS functionality not used by us.
*/

#import <UIKit/UIKit.h>

@interface QAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSMutableArray* favouritesSelection;
@property (strong, nonatomic) NSString* username;
@property (strong, nonatomic) NSString* password;
@property (strong, nonatomic) NSString* email;
@property (strong, nonatomic) NSString* postalCode;
@end
