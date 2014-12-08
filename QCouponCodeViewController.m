/*
 ViewDidLoad
    Simply makes sure the correct title string was passed in and this view renders the QR code
*/

#import "QCouponCodeViewController.h"

@interface QCouponCodeViewController ()

@end

@implementation QCouponCodeViewController
@synthesize couponTitleString;

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
    self.couponTitle.text = couponTitleString;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
