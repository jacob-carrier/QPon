
/*
 ViewDidAppear
    Makes the update button appear in the navigation bar, and sets the fields to the current user's account settings

 Logout
    Reset the user's settings to simulate a user being logged on in a database system as well as transition them back
    to the login screen.
 
 Update
    Checks to make sure the password and verification fields are identical, send a notification if they are not
    Otherwise update the current user's state in the application delegate and return to the coupon view (tab: 0)
*/

#import "QAccountViewController.h"
#import "QAppDelegate.h"

@interface QAccountViewController ()

@end

@implementation QAccountViewController

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
    [self.password_field setDelegate:self];
    [self.verify_field setDelegate:self];
    [self.email_field setDelegate:self];
    [self.postalCode_field setDelegate:self];
}

-(void)viewDidAppear:(BOOL)animated{
    UIBarButtonItem* updateButton = [[UIBarButtonItem alloc] initWithTitle:@"Update" style:UIBarButtonItemStylePlain target:self action:@selector(UpdateAction:)];
    self.tabBarController.navigationItem.rightBarButtonItem = updateButton;
    
    self.tabBarController.navigationItem.title = @"Account Settings";
    
    QAppDelegate* delegate = (QAppDelegate*)[[UIApplication sharedApplication] delegate];
    self.password_field.text = delegate.password;
    self.verify_field.text = delegate.password;
    self.email_field.text = delegate.email;
    self.postalCode_field.text = delegate.postalCode;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)tapAction:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)Logout:(id)sender {
    QAppDelegate* delegate = (QAppDelegate*)[[UIApplication sharedApplication] delegate];
    delegate.password = nil;
    delegate.email = nil;
    delegate.postalCode = nil;
}

-(void)UpdateAction:(id)sender{
    if(![self.password_field.text isEqualToString:self.verify_field.text]){
        UIAlertView* error = [[UIAlertView alloc] initWithTitle:@"Password Mismatch" message:@"Please make sure both passwords are the same." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        
        [error show];
    }else{
        QAppDelegate* delegate = (QAppDelegate*)[[UIApplication sharedApplication] delegate];
        delegate.password = self.password_field.text;
        delegate.email = self.email_field.text;
        delegate.postalCode = self.postalCode_field.text;
        
        self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:0];
        self.tabBarController.navigationItem.rightBarButtonItems = nil;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
