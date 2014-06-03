//
//  MyTableViewController.m
//  TVC
//
//  Created by Kevin on 02/06/2014.
//  Copyright (c) 2014 ___kevinPitolin___. All rights reserved.
//
#import "ImageViewController.h"
#import "MyTableViewController.h"
#import "FlickrFetcher.h"

@interface MyTableViewController ()
@end

@implementation MyTableViewController

- (void )setPhotos:(NSArray *)photos
{
    _photos = photos;
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;   // It's the default value
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [ self.photos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Flickr Photo Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSDictionary * photo = self.photos[indexPath.row];
    cell.textLabel.text = [photo valueForKey:FLICKR_PHOTO_TITLE];
    cell.detailTextLabel.text = [photo valueForKey:FLICKR_PHOTO_DESCRIPTION];
    return cell;
}



#pragma mark - UITAbleViewDelegate


-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id detail = self.splitViewController.viewControllers[1]; // on an iPhone this is gonna be nil
    
    if ([detail isKindOfClass:[ImageViewController class]])
    {
        [self prepareImageViewController:detail toDisplayPhoto:self.photos[indexPath.row]];
    }
    
}


#pragma mark - Navigation



-(void) prepareImageViewController:(ImageViewController *)ivc toDisplayPhoto:(NSDictionary* )photo
{
    
    
    ivc.imageURL = [ FlickrFetcher URLforPhoto:photo format:FlickrPhotoFormatLarge];
    ivc.title = [photo valueForKey:FLICKR_PHOTO_TITLE];

}


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isKindOfClass:[UITableView class]]){
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        
        if (indexPath){
            
            if ([segue.identifier isEqualToString:@"Display_photo" ]  ) {
                if ([segue.destinationViewController isKindOfClass:[ImageViewController class]]){
                    
                    [self prepareImageViewController:segue.destinationViewController toDisplayPhoto:self.photos[indexPath.row]];
                }
                
            }
            
        }
        
        
    }
    
    
}


@end
