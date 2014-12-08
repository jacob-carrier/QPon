/*
    ViewDidLoad
        Creates all the arrays for the restaurants and initialize with the coupon image names.
        
        Initializes the coupon array with all the restaurants as well as the title array to match the same
        index as the coupon array
 
        Creates a search array that contains the index of the restaurant along with a search text comparable key
 
    ViewDidAppear
        Checks to see if there are any favourites selected for the current user if so, update the table
 
    CellForRowAtIndexPath
        This functions creates the individual cell in the table at runtime. Inside the cell, a horizontally scrolling
        scroll view is create based on the number of coupons and their size (arbitrary), and adds a tap gesture to 
        each individual coupon image for the functionality of selection. The tap gesture uses the imageTapped function
        order to complete the transition to the detailed coupon view
 
    textDidChange
        Filters the search keys based on the text that is inputed at runtime. It filters either the favourites selection
        or the total array depending on the current state of the system.

    ImageTapped
        This is the function that calls the performSegue function in order to transition screens, adding the proper
        data in order to fetch and pass on to the detailed view screen the right coupon image and title string
 
    PrepareForSegue
        Completes the transition to the detailed view screen, passing along the right data in order to view
        the correct coupon image as well as correct title
*/

#import "QAdvancedCouponViewController.h"
#import "QSingleCouponViewController.h"
#import "QAppDelegate.h"

@interface QAdvancedCouponViewController ()

@end

@implementation QAdvancedCouponViewController
{
    NSArray* mcd;
    NSArray* bk;
    NSArray* sub;
    NSArray* wendy;
    NSArray* sonic;
    
    NSArray* coupons;
    NSArray* titles;
    
    NSInteger tag;
    NSMutableArray* favourites;
    NSInteger prevCount;
    NSDictionary* search;
    NSArray* results;
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
    mcd = [NSArray arrayWithObjects:@"mcd.jpg", @"mcd2.jpg", @"mcd.jpg", nil];
    bk = [NSArray arrayWithObjects:@"bk.jpg", @"bk2.jpg", @"bk2.jpg", nil];
    sub = [NSArray arrayWithObjects:@"sub.jpg", @"sub2.jpg", @"sub3.jpg", nil];
    wendy = [NSArray arrayWithObjects:@"wendy1.png", @"wendy2.png", @"wendy3.png", nil];
    sonic = [NSArray arrayWithObjects:@"sonic1.jpg", @"sonic2.jpg", @"sonic3.jpg", nil];
    
    coupons = [NSArray arrayWithObjects:mcd, bk, sub, wendy, sonic, nil];
    titles = [NSArray arrayWithObjects:@"McDonalds", @"Burger King", @"Subway", @"Wendy's", @"Sonic", nil];
    NSLog(@"Titles: %@", titles);
    self.tabBarController.navigationItem.hidesBackButton = YES;
    search = @{@"McDonalds" : @0,
               @"Burger King" : @1,
               @"Subway" : @2,
               @"Wendys" : @3,
               @"Sonic" : @4};
    prevCount = 0;
}

-(void)viewDidAppear:(BOOL)animated{
    self.tabBarController.navigationItem.title = @"Coupons";
    QAppDelegate* delegate = (QAppDelegate*)[[UIApplication sharedApplication] delegate];
    favourites = delegate.favouritesSelection;
    
    if(favourites.count != prevCount){
        prevCount = favourites.count;
        [self.tableView reloadData];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    NSPredicate* pred = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@", searchText];
    NSLog(@"Search Text: %@", searchText);
    NSArray* keys = [search allKeys];
    NSArray* filteredArray  = [keys filteredArrayUsingPredicate:pred];
    if(favourites.count > 0){
        NSArray* values = [search objectsForKeys:filteredArray notFoundMarker:@"!"];
        
        for(id value in values){
            NSUInteger position = [favourites indexOfObject:value];
            
            if (position == NSNotFound) {
                results = [NSArray array];
            }else{
                results = values;
            }
        }
        if([searchText isEqualToString:@""]){
            results = favourites;
        }
        NSLog(@"%@", results);
        [self.tableView reloadData];
    }else{
        results = [search objectsForKeys:filteredArray notFoundMarker:@"!"];
        NSLog(@"%@", results);
        [self.tableView reloadData];
    }
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self.view endEditing:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(results.count == 0){
        if(favourites.count > 0){
            return favourites.count;
        }else{
            return coupons.count;
        }
    }else{
        return results.count;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* identifier = @"Cell";
    UITableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    for(UIView* views in [cell.contentView subviews]){
        if([views isKindOfClass:[UIScrollView class]]){
            [views removeFromSuperview];
        }
    }
    
    UIScrollView* scrollView = (UIScrollView*)[cell viewWithTag:101];
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, 320, 130)];
    scrollView.showsHorizontalScrollIndicator = YES;
    scrollView.userInteractionEnabled = YES;
    scrollView.scrollEnabled = YES;
    scrollView.delegate = self;
    
    NSArray* tempArr = [[NSArray alloc] init];
    NSNumber* i;
    if(results.count == 0){
        if(favourites.count > 0){
            i = [favourites objectAtIndex:indexPath.row];
            tempArr = [coupons objectAtIndex:[i intValue]];
        }else{
            i = [NSNumber numberWithInt:indexPath.row];
            tempArr = [coupons objectAtIndex:indexPath.row];
        }
    }else{
        i = [results objectAtIndex:indexPath.row];
        tempArr = [coupons objectAtIndex:[i intValue]];
    }
    
    scrollView.contentSize = CGSizeMake(tempArr.count * 270, 110);
    [cell.contentView addSubview:scrollView];
    
    for(int i = 0; i < tempArr.count; i++){
        UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*270, 0, 250, 110)];
        imageView.image = [UIImage imageNamed:[tempArr objectAtIndex:i]];
        
        UITapGestureRecognizer* tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapped:)];
        tapRecognizer.cancelsTouchesInView = YES;
        tapRecognizer.numberOfTapsRequired = 1;
        tapRecognizer.delegate = (id)self;
        [imageView addGestureRecognizer:tapRecognizer];
        imageView.userInteractionEnabled = YES;
        imageView.tag = i;
        
        [scrollView addSubview:imageView];
    }
    
    UILabel* title = (UILabel*)[cell viewWithTag:100];
    title.text = [titles objectAtIndex:[i intValue]];
    
    return cell;
}

- (IBAction)hideKeyboard:(id)sender {
    [self.view endEditing:YES];
}

-(void)imageTapped:(UITapGestureRecognizer*)gesture{
    tag = [gesture.view tag];
    UIImageView* imageView = (UIImageView*)gesture.view;
    UIView* superView =  imageView.superview;
    while(![superView isKindOfClass:[UITableViewCell class]]){
        superView = superView.superview;
    }
    NSIndexPath* indexPath = [self.tableView indexPathForCell:(UITableViewCell*)superView];
    NSLog(@"PATH: %@", indexPath);
    
    [self performSegueWithIdentifier:@"rowSelection" sender:indexPath];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"rowSelection"]){
        
        NSIndexPath* indexPath = (NSIndexPath*)sender;
        QSingleCouponViewController* controller = segue.destinationViewController;
        if(results.count == 0){
            if(favourites.count > 0){
                NSNumber* i = [favourites objectAtIndex:indexPath.row];
                
                controller.couponTitleString = [titles objectAtIndex:[i intValue]];
                controller.couponImageString = [[coupons objectAtIndex:[i intValue]] objectAtIndex:tag];
            }else{
                
                controller.couponTitleString = [titles objectAtIndex:indexPath.row];
                controller.couponImageString = [[coupons objectAtIndex:indexPath.row] objectAtIndex:tag];
            }
        }else{
            NSNumber *i = [results objectAtIndex:indexPath.row];
            controller.couponTitleString = [titles objectAtIndex:[i intValue]];
            controller.couponImageString = [[coupons objectAtIndex:[i intValue]] objectAtIndex:tag];
        }
    }else{
        NSLog(@"Didn't segue");
    }
}

@end
