//
//  MyTableViewController.m
//  TVC
//
//  Created by Kevin on 02/06/2014.
//  Copyright (c) 2014 ___kevinPitolin___. All rights reserved.
//
#import "ImageViewController.h"
#import "MyTableViewController.h"
#import "FlickerFetcherTopPlacesHelper.h"
#import "PlaceTVC.h"

@interface MyTableViewController ()
@end

@implementation MyTableViewController

- (void )setPhotos:(NSArray *)photos
{
    _photos = photos;
    [self.tableView reloadData];
}


- (void)setPlaces:(NSArray *)places
{
    if (_places != places) {
        _places = [FlickerFetcherTopPlacesHelper sortPlaces:places];
        self.placesByCountry = [FlickerFetcherTopPlacesHelper placesByCountries:_places];
        self.countries = [FlickerFetcherTopPlacesHelper countriesFromPlacesByCountry:self.placesByCountry];
        [self.tableView reloadData];
    }
   
}
/*
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return [self.countries count];   // It's the default value
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.placesByCountry[self.countries[section]] count];
}


- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section
{
    return self.countries[section];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Flickr Photo Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSDictionary *place = self.placesByCountry[self.countries[indexPath.section]][indexPath.row];
    // we find the section then the place of the place in the array of place of this country
    cell.textLabel.text = [FlickerFetcherTopPlacesHelper titleOfPlace:place];
    cell.detailTextLabel.text = [FlickerFetcherTopPlacesHelper subtitleOfPlace:place];

        return cell;
}*/



#pragma mark - UITAbleViewDelegate


//-(void)tableView:(UITableView *)tableView  didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    id detail = self.splitViewController.viewControllers[1]; // on an iPhone this is gonna be nil
//    if ( [detail isKindOfClass:[UINavigationController class]] ){
//        detail = [((UINavigationController *)detail).viewControllers firstObject];
//        [self prepareImageViewController:detail toDisplayPhoto:self.photos[indexPath.row]];
//
//    }
//    if ([detail isKindOfClass:[ImageViewController class]])
//    {
//        [self prepareImageViewController:detail toDisplayPhoto:self.photos[indexPath.row]];
//    }
//    
//}

#define MAXOFRECENTPHOTOS 20

#define RECENT_PHOTOS_KEY @"Recent_Photos_Key"
+ (NSArray *)allPhotos
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:RECENT_PHOTOS_KEY];
}
//For saving the photos in the NSUserDefaults
- (void)addPhotoInRecentDictionnary:(NSDictionary *)photos_dictionnary{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    //I create an array to put the recent photos in it and I store it in the NSUserDefaults
    
    NSMutableArray *photos = [[defaults objectForKey:RECENT_PHOTOS_KEY] mutableCopy];
    if (!photos) photos = [NSMutableArray array];
    NSUInteger key = [photos indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
     return [[FlickerFetcherTopPlacesHelper IDforPhoto:photos_dictionnary] isEqualToString:[FlickerFetcherTopPlacesHelper IDforPhoto:obj]];
    }]; // It's a rare way to compare see what's the recent photos, could do that with the system date
    if (key != NSNotFound) [photos removeObjectAtIndex:key];
    [photos insertObject:photos_dictionnary atIndex:0];
    
    
    
    
    while ([photos count] > MAXOFRECENTPHOTOS) {
        [photos removeLastObject];
    }
    [defaults setObject:photos forKey:RECENT_PHOTOS_KEY];
    [defaults synchronize];
}


#pragma mark - Navigation


-(void) prepareImageViewController:(ImageViewController *)ivc toDisplayPhoto:(NSDictionary* )photo
{
    
    
    ivc.imageURL = [ FlickrFetcher URLforPhoto:photo format:FlickrPhotoFormatLarge];
    [photo valueForKey:FLICKR_PHOTO_TITLE]? (ivc.title = [photo valueForKey:FLICKR_PHOTO_TITLE]) :
    (ivc.title = [photo valueForKey:FLICKR_PHOTO_DESCRIPTION]);
    [self addPhotoInRecentDictionnary:photo];
    
    
}

//In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isKindOfClass:[UITableViewCell class]]){
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        
        if (indexPath){
            
            if ([segue.identifier isEqualToString:@"Display_photo" ]  ) {
                if ([segue.destinationViewController isKindOfClass:[ImageViewController class]]){
                    
                    dispatch_queue_t load = dispatch_queue_create("load", NULL);
                    dispatch_async(load, ^{
                    [self prepareImageViewController:segue.destinationViewController toDisplayPhoto:self.photos[indexPath.row]];
                    });
                    
                }
                
            }
            
        }
        
        
    }
    
    
}



// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([sender isKindOfClass:[UITableView class]]){
//        // Get the new view controller using [segue destinationViewController].
//        // Pass the selected object to the new view controller.
//        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
//        
//        if (indexPath){
//            
//            if ([segue.identifier isEqualToString:@"Display_photo" ]  ) {
//                if ([segue.destinationViewController isKindOfClass:[PlaceTVC class]]){
//                    
//                    [self preparePlaceController:segue.destinationViewController toDisplayPlace:self.placesByCountry[self.countries[indexPath.section]][indexPath.row]];
//                }
//                
//            }
//            
//        }
//        
//        
//    }
//    
//    
//}

// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([sender isKindOfClass:[UITableView class]]){
//        // Get the new view controller using [segue destinationViewController].
//        // Pass the selected object to the new view controller.
//        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
//        
//        if (indexPath){
//            
//            if ([segue.identifier isEqualToString:@"Display_photo" ]  ) {
//                if ([segue.destinationViewController isKindOfClass:[ImageViewController class]]){
//                    
//                    [self prepareImageViewController:segue.destinationViewController toDisplayPhoto:self.photos[indexPath.row]];
//                }
//                
//            }
//            
//        }
//        
//        
//    }
//    
//    
//}



//#pragma mark - UITAbleViewDelegate
//
//
//-(void)tableView:(UITableView *)tableView  didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    id detail = self.splitViewController.viewControllers[1]; // on an iPhone this is gonna be nil
//    if ( [detail isKindOfClass:[UINavigationController class]] ){
//        detail = [((UINavigationController *)detail).viewControllers firstObject];
//        [self prepareImageViewController:detail toDisplayPhoto:self.photos[indexPath.row]];
//        
//    }
//    if ([detail isKindOfClass:[ImageViewController class]])
//    {
//        [self prepareImageViewController:detail toDisplayPhoto:self.photos[indexPath.row]];
//    }
//    
//}




@end
