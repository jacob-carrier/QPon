//
//  QCouponViewController.m
//  QPon
//
//  Created by Jacob Lemelin-Carrier on 3/9/2014.
//  Copyright (c) 2014 Jacob Lemelin-Carrier. All rights reserved.
//

#import "QCouponViewController.h"
#import "QSingleCouponViewController.h"
#import "QAppDelegate.h"

@interface QCouponViewController ()

@end

@implementation QCouponViewController
{
    //NSArray* couponImages;
    NSMutableDictionary* couponImages;
    NSMutableDictionary* couponTitles;
    NSMutableArray* favourites;
    NSArray* imageKeys;
    NSArray* imageValues;
    NSArray* titleKeys;
    NSArray* titleValues;
    NSInteger numCoupons;
    //NSArray* couponTitles;
    NSMutableArray* imageToPass;
    NSMutableArray* titleToPass;
    NSInteger tracker;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tabBarController.navigationItem.hidesBackButton = YES;
    
    //couponImages = [NSArray arrayWithObjects:@"mcd.jpg", @"bk.jpg", @"sub.jpg", nil];
    
    couponImages = [[NSMutableDictionary alloc] init];
    couponTitles = [[NSMutableDictionary alloc] init];
    
    [couponImages setValue:@"bk.jpg" forKey:@"bk"];
    [couponImages setValue:@"mcd.jpg" forKey:@"mcd"];
    [couponImages setValue:@"sub.jpg" forKey:@"subway"];
    [couponImages setValue:@"bk2.jpg" forKey:@"bk"];
    
    [couponTitles setValue:@"Burger King - 2 Can Dine" forKey:@"bk"];
    [couponTitles setValue:@"McDonalds" forKey:@"mcd"];
    [couponTitles setValue:@"Subway" forKey:@"subway"];
    [couponTitles setValue:@"Burger King - Buy 1 Get 1" forKey:@"bk"];
    
    imageKeys = [NSArray arrayWithObjects:@"bk", @"mcd", @"subway", @"bk", nil];
    imageValues = [NSArray arrayWithObjects:@"bk.jpg", @"mcd.jpg", @"sub.jpg", @"bk2.jpg", nil];
    
    titleKeys = [NSArray arrayWithObjects:@"mcd", @"bk", @"subway", @"bk", nil];
    titleValues = [NSArray arrayWithObjects:@"Burger King - 2 Can Dine", @"McDonalds", @"Subway", @"Burger King - Buy 1 Get 1", nil];
    
    numCoupons = 0;
    tracker = 0;
    
    imageToPass = [[NSMutableArray alloc] initWithCapacity:imageValues.count];
    titleToPass = [[NSMutableArray alloc] initWithCapacity:titleValues.count];
    
    //couponTitles = [NSArray arrayWithObjects:@"McDonalds", @"Burger King", @"Subway", nil];
}

-(void)viewDidAppear:(BOOL)animated{
    QAppDelegate* delegate = (QAppDelegate*)[[UIApplication sharedApplication] delegate];
    favourites = delegate.favouritesSelection;
    numCoupons = 0;
    imageToPass = [[NSMutableArray alloc] init];
    titleToPass = [[NSMutableArray alloc] init];
    
    for(int i = 0; i < imageValues.count; i++){
        imageToPass[i] = @"";
        titleToPass[i] = @"";
        
    }
    
    //NSLog(@"size of imagetopass: %d", imageToPass.count);
    if(favourites.count > 0){
        
        for (int i = 0; i < favourites.count; i++) {
            NSString* expression = [NSString stringWithFormat:@"SELF contains '%@'", [favourites objectAtIndex:i]];
            NSPredicate* pred = [NSPredicate predicateWithFormat:expression];
            NSMutableArray* filteredArray = [[titleKeys filteredArrayUsingPredicate:pred] copy];
            NSLog(@"%d", filteredArray.count);
            numCoupons += filteredArray.count;
        }
        //NSLog(@"%d", numCoupons);
        tracker = 0;
    }else{
        numCoupons = titleValues.count;
        NSLog(@"%d", numCoupons);
    }
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return numCoupons;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    /*
    UIImageView* cimage = (UIImageView*)[cell viewWithTag:100];
    cimage.image = [UIImage imageNamed:[couponImages objectAtIndex:indexPath.row]];
    UILabel* ctitle = (UILabel*)[cell viewWithTag:101];
    ctitle.text = [couponTitles objectAtIndex:indexPath.row];
     */
    if(favourites.count > 0){
        for(int i = tracker; i < imageKeys.count; i++){
            NSString* imageKey = [imageKeys objectAtIndex:i];
            for(int j = 0; j < favourites.count; j++){
                if([imageKey isEqualToString:[favourites objectAtIndex:j]]){
                    tracker = i+1;
                    UIImageView* cimage = (UIImageView*)[cell viewWithTag:100];
                    cimage.image = [UIImage imageNamed:[imageValues objectAtIndex:i]];
                    UILabel* ctitle = (UILabel*)[cell viewWithTag:101];
                    ctitle.text = [titleValues objectAtIndex:i];
                    titleToPass[indexPath.row] = [titleValues objectAtIndex:i];
                    imageToPass[indexPath.row] = [imageValues objectAtIndex:i];
                    return cell;
                }
            }
        }
    }else{
         UIImageView* cimage = (UIImageView*)[cell viewWithTag:100];
         cimage.image = [UIImage imageNamed:[imageValues objectAtIndex:indexPath.row]];
         UILabel* ctitle = (UILabel*)[cell viewWithTag:101];
         ctitle.text = [titleValues objectAtIndex:indexPath.row];
         //titleToPass[indexPath.row] = [titleValues objectAtIndex:indexPath.row];
         //imageToPass[indexPath.row] = [imageValues objectAtIndex:indexPath.row];
    }
    
    return cell;
}

#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"rowSelection"]){
        NSIndexPath* indexPath = [self.tableView indexPathForSelectedRow];
        QSingleCouponViewController* controller = segue.destinationViewController;
        if(favourites.count > 0){
            controller.couponImageString = [imageToPass objectAtIndex:indexPath.row];
            controller.couponTitleString = [titleToPass objectAtIndex:indexPath.row];
        }else{
            controller.couponTitleString = [titleValues objectAtIndex:indexPath.row];
            controller.couponImageString = [imageValues objectAtIndex:indexPath.row];
        }
    }else{
        NSLog(@"Didn't segue");
    }
}

@end
