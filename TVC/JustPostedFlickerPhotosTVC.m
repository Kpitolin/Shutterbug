//
//  JustPostedFlickerPhotosTVC.m
//  ShutterBug
//
//  Created by Kevin on 02/06/2014.
//  Copyright (c) 2014 ___kevinPitolin___. All rights reserved.
//

#import "JustPostedFlickerPhotosTVC.h"
#import "FlickrFetcher.h"


@implementation JustPostedFlickerPhotosTVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self fetchPhotos];

}


-(IBAction)fetchPhotos{
    
    [self.refreshControl beginRefreshing];
    NSURL * url = [FlickrFetcher URLforRecentGeoreferencedPhotos];
    dispatch_queue_t fetchQueue = dispatch_queue_create("flickr fetcher", NULL);
    dispatch_async(fetchQueue, ^{
        NSData * jsonResults = [NSData dataWithContentsOfURL: url];
        NSDictionary * propertyListResults =  [NSJSONSerialization JSONObjectWithData:jsonResults options:0 error:NULL]; // Transform the JSON data into a dictionnary
        NSArray *photos = [ propertyListResults valueForKeyPath:FLICKR_RESULTS_PHOTOS];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.refreshControl endRefreshing]; // We finished the download here so the refresh thing could end

            self.photos = photos;}); // We go back to the main thread because it's a UI thing

    });
    
    

    
}



@end
