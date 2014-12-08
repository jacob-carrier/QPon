/*
    Simply displays a QR code with the proper title string based on the user's coupons selection
*/

#import <UIKit/UIKit.h>

@interface QCouponCodeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *couponTitle;
@property (nonatomic, strong) NSString* couponTitleString;
@end
