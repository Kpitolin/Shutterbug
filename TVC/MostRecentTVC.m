//
//  MostRecentTVC.m
//  ShutterBug
//
//  Created by KEVIN on 08/06/2014.
//  Copyright (c) 2014 ___kevinPitolin___. All rights reserved.
//
#import "ImageViewController.h"
#import "MostRecentTVC.h"
#import "FlickerFetcherTopPlacesHelper.h"

@interface MostRecentTVC ()

@end

@implementation MostRecentTVC

#define MAXOFRECENTPHOTOS 20


- (IBAction)fetchPhotos {
    [self.refreshControl beginRefreshing];
    self.photos = [self allPhotos];
    [self.refreshControl endRefreshing];

    
}
#define RECENT_PHOTOS_KEY @"Recent_Photos_Key"

- (NSArray *)allPhotos
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:RECENT_PHOTOS_KEY];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self fetchPhotos];

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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Flickr Photo Cell" forIndexPath:indexPath];
    
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
