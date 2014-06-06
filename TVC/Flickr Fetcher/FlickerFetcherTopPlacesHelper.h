//
//  FlickerFetcherTopPlacesHelper.h
//  ShutterBug
//
//  Created by Kevin on 06/06/2014.
//  Copyright (c) 2014 ___kevinPitolin___. All rights reserved.
//

#import "FlickrFetcher.h"

@interface FlickerFetcherTopPlacesHelper : FlickrFetcher
+ (void)loadTopPlacesOnCompletion:(void (^)(NSArray *photos, NSError *error))completionHandler;
+ (NSString *)countryOfPlace:(NSDictionary *)place;
+ (NSString *)titleOfPlace:(NSDictionary *)place;
+ (NSString *)subtitleOfPlace:(NSDictionary *)place;
+ (NSArray *)sortPlaces:(NSArray *)places;
+ (NSDictionary *)placesByCountries:(NSArray *)places;
+ (NSArray *)countriesFromPlacesByCountry:(NSDictionary *)placesByCountry;
@end
