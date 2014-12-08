/*
    This class implements the functionality that the user can change or view their account settings, as well as logout
*/

#import <UIKit/UIKit.h>

@interface QAccountViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *password_field;
@property (weak, nonatomic) IBOutlet UITextField *verify_field;
@property (weak, nonatomic) IBOutlet UITextField *email_field;
@property (weak, nonatomic) IBOutlet UITextField *postalCode_field;
- (IBAction)tapAction:(id)sender;
- (IBAction)Logout:(id)sender;
-(void)UpdateAction:(id)sender;
@end
