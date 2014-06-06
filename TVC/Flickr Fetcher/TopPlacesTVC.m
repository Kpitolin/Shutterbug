//
//  TopPlacesTVC.m
//  ShutterBug
//
//  Created by Kevin on 06/06/2014.
//  Copyright (c) 2014 ___kevinPitolin___. All rights reserved.
//

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
