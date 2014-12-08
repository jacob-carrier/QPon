/*
    viewDidLoad
        Creates an array of logo images to be used in the collection view to represent the restaurants. It also
        creates an array of keys which is based on the same keys as in the QAdvancedCouponViewController in order to be
        able to manipulate data easily.
 
    viewDidAppear
        Creates the update button with the corresponding update action
 
    cellForItemAtIndexPath
        Creates each individual cell in the collection view and attaches the corresponding image to it
 
    didSelectItemAtIndexPath & didDeselectItemAtIndexPath
        These functions implement the selection functionality which sets the selectedRestaurants array to the current selection
        which is an index number associated with the correct positions for the coupons array in QAdvancedCouponViewController.
 
    UpdateAction
        Sets the users favourites selection array in the application delegate to what the selectedRestaurant index array returns
        and then transitions to the coupon view updating it with only the selected restaurants.
*/

#import "QFavouritesViewController.h"
#import "QFavouritesCustomCell.h"
#import "QAppDelegate.h"

@interface QFavouritesViewController ()

@end

@implementation QFavouritesViewController{
    NSArray* logoImages;
    NSArray* restaurantKeys;
    NSMutableArray* selectedRestaurants;
}

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
    self.tabBarController.navigationItem.hidesBackButton = YES;
    
    logoImages = [NSArray arrayWithObjects:@"mcd_logo.jpg", @"bk_logo.jpg", @"subway_logo.jpg", @"wendy_logo.jpg", @"sonic_logo.jpg", nil];
    /*
     Key List
     0 = McDonalds
     1 = Burger King
     2 = Subway
     3 = Wendy's
     4 = Sonic
     */
    restaurantKeys = [NSArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:1], [NSNumber numberWithInt:2],[NSNumber numberWithInt:3], [NSNumber numberWithInt:4], nil];
    selectedRestaurants = [NSMutableArray array];
    
    [self.myCollectionView registerClass:[QFavouritesCustomCell class] forCellWithReuseIdentifier:@"Cell"];
    self.myCollectionView.allowsMultipleSelection = YES;
    self.tabBarController.navigationItem.title = @"Favourites";
}

-(void) viewDidAppear:(BOOL)animated{
    UIBarButtonItem* updateButton = [[UIBarButtonItem alloc] initWithTitle:@"Update" style:UIBarButtonItemStylePlain target:self action:@selector(UpdateAction:)];
    self.tabBarController.navigationItem.rightBarButtonItem = updateButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return restaurantKeys.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* identifier = @"Cell";
    
    QFavouritesCustomCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    cell.restaurantLogo.image = [UIImage imageNamed:[logoImages objectAtIndex:indexPath.row]];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString* selectedItem = [restaurantKeys objectAtIndex:indexPath.row];
    
    [selectedRestaurants addObject:selectedItem];
    NSLog(@"Selection: %@", selectedRestaurants);
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString* deselectedItem = [restaurantKeys objectAtIndex:indexPath.row];
    [selectedRestaurants removeObject:deselectedItem];
    NSLog(@"Selection: %@", selectedRestaurants);
}

-(void)UpdateAction:(id)sender{
    QAppDelegate* delegate = (QAppDelegate*)[[UIApplication sharedApplication] delegate];
    delegate.favouritesSelection = selectedRestaurants;
    self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:0];
    self.tabBarController.navigationItem.rightBarButtonItems = nil;
}

@end
