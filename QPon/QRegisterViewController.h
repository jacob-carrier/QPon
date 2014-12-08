/*
    Displays all the registration information as well as makes sure fields are not empty and passwords are matching.
    Transitions the user to the coupon view if all the details are set.
*/

#import <UIKit/UIKit.h>

@interface QRegisterViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *postalcode_textfield;
@property (weak, nonatomic) IBOutlet UITextField *email_textfield;
@property (weak, nonatomic) IBOutlet UITextField *verify_textfield;
@property (weak, nonatomic) IBOutlet UITextField *password_textfield;
@property (weak, nonatomic) IBOutlet UITextField *username_textfield;
- (IBAction)tapReturn:(id)sender;
- (IBAction)registerAction:(id)sender;

@end
