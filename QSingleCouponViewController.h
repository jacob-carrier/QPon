/*
    Displays a detailed coupon view based on the user's selection. All the proper images and strings are set based
    on the data passed from QAdvancedCouponViewController. Detailed information text is simply dummy text to demonstrate
    functionality.
*/

#import <UIKit/UIKit.h>

@interface QSingleCouponViewController : UIViewController
@property (nonatomic, strong) NSString* couponTitleString;
@property (nonatomic, strong) NSString* couponImageString;
@property (weak, nonatomic) IBOutlet UIImageView *couponImage;
@property (weak, nonatomic) IBOutlet UILabel *couponTitle;

@end
