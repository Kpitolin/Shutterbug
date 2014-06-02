//
//  JustPostedFlickerPhotosTVC.m
//  ShutterBug
//
//  Created by Kevin on 02/06/2014.
//  Copyright (c) 2014 ___kevinPitolin___. All rights reserved.
//

#import "JustPostedFlickerPhotosTVC.h"
#import "FlickrFetcher.h"
@interface JustPostedFlickerPhotosTVC ()

@end

@implementation JustPostedFlickerPhotosTVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self fetchPhotos];

}


-(void)fetchPhotos{
    NSURL * url = [FlickrFetcher URLforRecentGeoreferencedPhotos];
    
    #warning  BLOCK MAIN THREAD
    
    
    NSData * jsonResults = [NSData dataWithContentsOfURL: url];
    NSDictionary * propertyListResults =  [NSJSONSerialization JSONObjectWithData:jsonResults options:0 error:NULL]; // Transform the JSON data into a dictionnary
    NSArray *photos = [ propertyListResults valueForKeyPath:FLICKR_RESULTS_PHOTOS];
    self.photos = photos;

    
}



@end
