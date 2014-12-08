/*
    Displays the collection of possible restaurant selections, as well as displays and updates the selection based on what
    the user has chosen. It then saves this information for later use in order to update the coupon view.
*/

#import <UIKit/UIKit.h>

@interface QFavouritesViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;

@end
