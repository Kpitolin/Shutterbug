//
//  PlaceTVC.m
//  ShutterBug
//
//  Created by KEVIN on 07/06/2014.
//  Copyright (c) 2014 ___kevinPitolin___. All rights reserved.
//
#import "FlickerFetcherTopPlacesHelper.h"
#import "PlaceTVC.h"

@interface PlaceTVC ()
@property (weak, nonatomic) IBOutlet UIRefreshControl *refreshItem;
@end

@implementation PlaceTVC
#define MAXOFRESULTS 50

- (IBAction)fetchPhotos {
    [self.refreshItem beginRefreshing];
    [FlickerFetcherTopPlacesHelper loadPhotosinPlace:self.place withMaxResults:MAXOFRESULTS OnCompletion:^(NSArray *photos, NSError *error){
        if (!error) {
            self.photos = photos;  // It will call the super method
        } else {
            NSLog(@"Error loading Photos of %@: %@", self.place, error); // replace by Alert
        
        }
    }];
    
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
    [self fetchPhotos];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return [self.photos count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Photo" forIndexPath:indexPath];
    
    // Configure the cell...
    
    
    
    
    
    
    return cell;
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
