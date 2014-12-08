/*
    LoginAction
        Checks to make sure the username and password fields are not empty, else return a notification.
        If there are not empty set the current user's settings in the application delegate to simulate database
        functionality for later user, and then transition to the coupon view.
*/

#import "QLoginViewViewController.h"
#import "QAppDelegate.h"

@interface QLoginViewViewController ()

@end

@implementation QLoginViewViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.username_textfield setDelegate:self];
    [self.password_textfield setDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginAction:(id)sender {
    if([self.username_textfield.text isEqualToString:@""] || [self.password_textfield.text isEqualToString:@""]){
        UIAlertView* error = [[UIAlertView alloc] initWithTitle:@"Login Failed" message:@"One of the fields is empty." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        
        [error show];
    }else{
        QAppDelegate* delegate = (QAppDelegate*)[[UIApplication sharedApplication] delegate];
        delegate.password = self.password_textfield.text;
        delegate.email = @"generic613@email.com";
        delegate.postalCode = @"K4A 4K4";
        [self performSegueWithIdentifier:@"login" sender:self];
    }
}
- (IBAction)tapReturn:(id)sender {
    [self.view endEditing:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
@end
