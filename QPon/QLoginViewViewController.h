/*
    This is the class that allows the user to log in.
*/

#import <UIKit/UIKit.h>

@interface QLoginViewViewController : UIViewController <UITextFieldDelegate>
- (IBAction)loginAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *username_textfield;
@property (weak, nonatomic) IBOutlet UITextField *password_textfield;
- (IBAction)tapReturn:(id)sender;


@end
