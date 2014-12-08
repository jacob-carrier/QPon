/*
    This is the class that creates and updates the view for the coupons. The coupon view can be changed based on the
    search filter, or the favourites selection that is set in the favourites tab. It creates horizontal scroll view for the
    coupon images, as well as their functionality for coupon selection.
*/

#import <UIKit/UIKit.h>

@interface QAdvancedCouponViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)hideKeyboard:(id)sender;
-(void)imageTapped:(UITapGestureRecognizer*)gesture;
@end
