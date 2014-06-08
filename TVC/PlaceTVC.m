//
//  PlaceTVC.m
//  ShutterBug
//
//  Created by KEVIN on 07/06/2014.
//  Copyright (c) 2014 ___kevinPitolin___. All rights reserved.
//
#import "FlickerFetcherTopPlacesHelper.h"
#import "PlaceTVC.h"
#import "ImageViewController.h"

@interface PlaceTVC ()
@end

@implementation PlaceTVC
#define MAXOFRESULTS 50

- (IBAction)fetchPhotos {
    [self.refreshControl beginRefreshing];
    [FlickerFetcherTopPlacesHelper loadPhotosinPlace:self.place withMaxResults:MAXOFRESULTS OnCompletion:^(NSArray *photos, NSError *error){
        if (!error) {
            self.photos = photos;  // It will call the super method
            [self.refreshControl endRefreshing];

        } else {
            NSLog(@"Error loading Photos of %@: %@", self.place, error); // replace by Alert
        
        }
    }];
    
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Place" forIndexPath:indexPath];
    
    // Configure the cell...
    
    
    NSDictionary *photo = self.photos[indexPath.row];
    if ([photo valueForKeyPath:FLICKR_PHOTO_TITLE] && [photo valueForKeyPath:FLICKR_PHOTO_DESCRIPTION]){
        cell.textLabel.text = [photo valueForKeyPath:FLICKR_PHOTO_TITLE];
        cell.detailTextLabel.text = [photo valueForKeyPath:FLICKR_PHOTO_DESCRIPTION];

    }else if ( [photo valueForKeyPath:FLICKR_PHOTO_DESCRIPTION]){
        cell.textLabel.text = [photo valueForKeyPath:FLICKR_PHOTO_DESCRIPTION];
        
    }else{
        // if the photo have no title nor subtitle
        cell.textLabel.text = @"Unknown";
        cell.detailTextLabel.text = @"Unknown";
    }
    
    
    
    return cell;
}




@end
