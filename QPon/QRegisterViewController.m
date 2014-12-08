/*
    RegisterAction
        Checks to make sure certain fields have been entered, and if not it displays the proper notification.
        If everything checks out, set the user's info the application delegate in order to simulate a database
        and access the information in later parts of the application. The transitions to the coupon view simulating
        a login in after registration
*/

#import "QRegisterViewController.h"
#import "QAppDelegate.h"

@interface QRegisterViewController ()

@end

@implementation QRegisterViewController

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
    self.tabBarController.navigationItem.title = @"Registration";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)tapReturn:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)registerAction:(id)sender {
    if([self.username_textfield.text isEqualToString:@""]){
        UIAlertView* error = [[UIAlertView alloc] initWithTitle:@"Registration Failed" message:@"Username field is empty." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        
        [error show];
    }else if(![self.password_textfield.text isEqualToString:self.verify_textfield.text]){
        UIAlertView* error = [[UIAlertView alloc] initWithTitle:@"Registration Failed" message:@"Passwords do not match." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        
        [error show];
    }else if([self.email_textfield.text isEqualToString:@""]){
        UIAlertView* error = [[UIAlertView alloc] initWithTitle:@"Registration Failed" message:@"Email field is empty." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        
        [error show];
    }else{
        QAppDelegate* delegate = (QAppDelegate*)[[UIApplication sharedApplication] delegate];
        delegate.username = self.username_textfield.text;
        delegate.password = self.password_textfield.text;
        delegate.email = self.email_textfield.text;
        delegate.postalCode = self.postalcode_textfield.text;
        [self performSegueWithIdentifier:@"register" sender:self];
    }
}
@end
