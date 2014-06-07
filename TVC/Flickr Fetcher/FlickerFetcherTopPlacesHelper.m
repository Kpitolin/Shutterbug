//
//  FlickerFetcherTopPlacesHelper.m
//  ShutterBug
//
//  Created by Kevin on 06/06/2014.
//  Copyright (c) 2014 ___kevinPitolin___. All rights reserved.
//

#import "FlickerFetcherTopPlacesHelper.h"

@implementation FlickerFetcherTopPlacesHelper


+ (void)loadTopPlacesOnCompletion:(void (^)(NSArray *photos, NSError *error))completionHandler
 
{
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration]];
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:[FlickrFetcher URLforTopPlaces]
                                                completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
                                                    NSArray *places;
                                                    if (!error) {
                                                        places = [[NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:location]
                                                                                                  options:0
                                                                                                    error:&error] valueForKeyPath:FLICKR_RESULTS_PLACES];
                                                    }
                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                        completionHandler(places, error); // when we call this method, we could do what we want in this block (sort by country or whatever)
                                                    });
                                                }];
    [task resume];
}

+ (void)loadPhotosinPlace:(NSDictionary *) place withMaxResults:(int)results OnCompletion:(void (^)(NSArray *photos, NSError *error))completionHandler

{
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration]];
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:[FlickrFetcher URLforPhotosInPlace:[place valueForKeyPath:FLICKR_PLACE_ID] maxResults:results]
                                                completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
                                                    NSArray *photos;
                                                    if (!error) {
                                                        photos = [[NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:location]
                                                                                                  options:0
                                                                                                    error:&error] valueForKeyPath:FLICKR_RESULTS_PHOTOS];
                                                    }
                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                        completionHandler(photos, error); // when we call this method, we could do what we want in this block (sort by country or whatever)
                                                    });
                                                }];
    [task resume];
}

+ (NSString *)countryOfPlace:(NSDictionary *)place{

    
    return [[[place valueForKeyPath:FLICKR_PLACE_NAME]
             componentsSeparatedByString:@", "] lastObject];
}



+ (NSString *)titleOfPlace:(NSDictionary *)place{
    return [[[place valueForKeyPath:FLICKR_PLACE_NAME]
             componentsSeparatedByString:@", "] firstObject];  // it's the city first value of the array
}


+ (NSString *)subtitleOfPlace:(NSDictionary *)place
{
    NSMutableArray * components =  [NSMutableArray arrayWithArray:[[place valueForKeyPath:FLICKR_PLACE_NAME]
                                    componentsSeparatedByString:@", "]];
  
    NSString * region= components[1];
    NSString * country = components[2];
                             
   return  [NSString stringWithFormat:@"%@ , %@",region,country];
                             
}



// To sort the places by alphabetical order
+ (NSArray *)sortPlaces:(NSArray *)places{
    
        return [places sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSString *name1 = [obj1 valueForKeyPath:FLICKR_PLACE_NAME];
        NSString *name2 = [obj2 valueForKeyPath:FLICKR_PLACE_NAME];
        return [name1 localizedCompare:name2];
    }];
}



// To sort the places by country
+ (NSDictionary *)placesByCountries:(NSArray *)places{
    NSMutableDictionary * placesDictionnary = [[NSMutableDictionary alloc] init];
    for (NSDictionary * place in places) {
        
        NSMutableArray* placesOfCountry;
        if ( ![placesDictionnary objectForKey:[self countryOfPlace:place]] ){ // if this country is not yet in the dictionnary
            
             NSMutableArray* placesOfCountry= [NSMutableArray arrayWithObject:place];
            [placesDictionnary setObject:placesOfCountry forKey:[self countryOfPlace:place]];

        } else{
            [placesOfCountry addObject:place];
        }

    }
    

    return placesDictionnary;
}

// To get all the countries
+ (NSArray *)countriesFromPlacesByCountry:(NSDictionary *)placesByCountry{
    
    
    NSArray * countriesByContry  = [placesByCountry allKeys];
    countriesByContry = [countriesByContry sortedArrayUsingComparator:^(id a, id b) {  // sort the countries
        return [a compare:b options:NSCaseInsensitiveSearch];
    }];
    return countriesByContry;
}
@end
