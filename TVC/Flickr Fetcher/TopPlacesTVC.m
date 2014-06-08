//
//  TopPlacesTVC.m
//  ShutterBug
//
//  Created by Kevin on 06/06/2014.
//  Copyright (c) 2014 ___kevinPitolin___. All rights reserved.
//
#import "PlaceTVC.h"
#import "TopPlacesTVC.h"
#import "FlickerFetcherTopPlacesHelper.h"

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
    [self.tableView setContentOffset:CGPointMake(0, -self.refreshControl.frame.size.height) animated:YES];

    [FlickerFetcherTopPlacesHelper loadTopPlacesOnCompletion:^(NSArray *places, NSError *error) {
        if (!error) {
            self.places = places;
            [self.refreshControl endRefreshing];
        } else {
            NSLog(@"Error loading TopPlaces: %@", error);
        }
    }];
    
    
    
}

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
}

#pragma mark - Navigation

-(void) preparePlaceController:(PlaceTVC *)ptvc toDisplayPlace:(NSDictionary* )place
{
    
    ptvc.place = place;
    ptvc.title = [FlickerFetcherTopPlacesHelper titleOfPlace:place];

}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        
        if (indexPath){
            
            if ([segue.identifier isEqualToString:@"Display_place" ]  ) {
                if ([segue.destinationViewController isKindOfClass:[PlaceTVC class]]){
                    
                    [self preparePlaceController:segue.destinationViewController toDisplayPlace:self.placesByCountry[self.countries[indexPath.section]][indexPath.row]];
                }
                
            }
            
        }
        
        
    
    
    
}


@end
