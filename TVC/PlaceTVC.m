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

@end

@implementation PlaceTVC
#define MAXOFRESULTS 50

- (IBAction)fetchPhotos:(id)sender {
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
}

- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    
    [self.tableView reloadData];

 //   NSURL * urlPhotos = [FlickerFetcherTopPlacesHelper URLforPhotosInPlace: maxResults:MAXOFRESULTS];


    
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
