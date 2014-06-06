//
//  MyTableViewController.h
//  TVC
//
//  Created by Kevin on 02/06/2014.
//  Copyright (c) 2014 ___kevinPitolin___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTableViewController : UITableViewController
@property (nonatomic, strong) NSArray * photos; // of Flickr photo Dictionnary
@property (nonatomic, strong) NSArray * places;
@property (nonatomic, strong) NSArray * countries;
@property (nonatomic, strong) NSDictionary *placesByCountry;

@end
