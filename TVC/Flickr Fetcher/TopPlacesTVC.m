//
//  TopPlacesTVC.m
//  ShutterBug
//
//  Created by Kevin on 06/06/2014.
//  Copyright (c) 2014 ___kevinPitolin___. All rights reserved.
//

#import "TopPlacesTVC.h"
#import "FlickrFetcher.h"

@interface TopPlacesTVC ()

@end

@implementation TopPlacesTVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self fetchPlaces];
    
}


-(IBAction)fetchPlaces{
    
    [self.refreshControl beginRefreshing];
    NSURL * url = [FlickrFetcher URLforTopPlaces];
    dispatch_queue_t fetchQueue = dispatch_queue_create("flickr fetcher", NULL);
    dispatch_async(fetchQueue, ^{
        NSData * jsonResults = [NSData dataWithContentsOfURL: url];
        NSDictionary * propertyListResults =  [NSJSONSerialization JSONObjectWithData:jsonResults options:0 error:NULL]; // Transform the JSON data into a dictionnary
        NSArray *places = [propertyListResults valueForKeyPath:@"places.place"]; // I only take the places from Flickr
        
        
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.refreshControl endRefreshing]; // We finished the download here so the refresh thing could end
            
            self.places = places;}); // We go back to the main thread because it's a UI thing
        
    });
    
    
    
    
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
