/*
    ViewDidLoad
        Sets the strings and image view to the correct data which was passed in from the transition from
        QAdvancedCouponViewController as well as changing the navigation bar title.
 
    PrepareForSegue
        Again, passes the correct string to the QR code view
*/

#import "QSingleCouponViewController.h"
#import "QCouponCodeViewController.h"

@interface QSingleCouponViewController ()

@end

@implementation QSingleCouponViewController

@synthesize couponTitleString;
@synthesize couponImageString;

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
    self.couponImage.image = [UIImage imageNamed:couponImageString];
    self.navigationItem.title = [couponTitleString stringByAppendingString:@" Coupon"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"CouponCode"]){
        QCouponCodeViewController* controller = segue.destinationViewController;
        controller.couponTitleString = self.couponTitleString;
    }
}

@end
