//
//  WeatherService.m
//  GSL
//
//  Created by William Lyons on 2016-12-02.
//  Copyright © 2016 William Lyons. All rights reserved.
//

#import "WeatherService.h"


@implementation WeatherService
{
    NSURLSession *session;
    CLLocationManager *locationManager;
    NSDate *locationLastUpdated;
}

-(id)init {
    
    self = [super init];
    if(self != nil)
    {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        session = [NSURLSession sessionWithConfiguration:configuration];
        self.weatherManager = [WeatherManager new];
        self.forcastManager = [ForcastManager new];
    }
    
    return self;
    
}

+ (WeatherService*)sharedInstance
{
    static dispatch_once_t once;
    static id sharedInstance;
    
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}


-(void)requestForcast
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@lat=%3.3lf&lon=%3.3lf&APPID=%@&cnt=3", forcastUrl, self.currentCoordinates.latitude, self.currentCoordinates.longitude, apiKey]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(!error) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            NSAssert(dict != nil, @"Forcast JSON is nill");
            [self.forcastManager processData:dict];

            [[NSNotificationCenter defaultCenter] postNotificationName:notifyForcastUpated object:nil];
        }
        else {
            NSLog(@"%@", error);
        }
    }];
    [task resume];
    
}

-(void)requestWeather
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@lat=%3.3lf&lon=%3.3lf&APPID=%@", weatherUrl, self.currentCoordinates.latitude, self.currentCoordinates.longitude, apiKey]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(!error) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            NSAssert(dict != nil, @"Weather JSON is nill");
            [self.weatherManager processData:dict];

            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:notifyWeatherUpated object:nil];
            });
        }
        else {
            NSLog(@"%@", error);
        }
    }];
    [task resume];

}

-(void)stopLocationManager
{
    NSLog(@"stopLocationManager");
    [locationManager stopUpdatingLocation];
    locationManager.delegate = nil;
}

-(void)startLocationManager
{
    NSLog(@"startLocationManager");
    locationManager = [[CLLocationManager alloc] init];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
    {
        [locationManager requestWhenInUseAuthorization];
    }
    else
    {
        // No such method on this device - do something else as needed
    }
#endif
    
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    locationManager.distanceFilter = 1000;
    locationManager.delegate = self;
    
    if((self.locationAvailable = [CLLocationManager locationServicesEnabled]) == YES)
    {
        [locationManager startUpdatingLocation];
    }
    else
    {
        NSLog(@"Location not available");
        self.locationAvailable = NO;
    }

}


#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    self.currentCoordinates = location.coordinate;
    

    NSTimeInterval locationAge = -[location.timestamp timeIntervalSinceNow];
    if (locationAge > 5.0) return;
    
    if (location.horizontalAccuracy < 0) return;

    
    NSTimeInterval t = locationLastUpdated.timeIntervalSinceNow;
    NSLog(@"Interval %f", t);
    if(locationLastUpdated == nil || t < -10.0)
    {
        locationLastUpdated = [NSDate date];
        NSLog(@"Location UPDATED %f %f", location.coordinate.latitude, location.coordinate.longitude);
        [[NSNotificationCenter defaultCenter] postNotificationName:notifyLocationUpdated object:nil];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Core Location error %@", error);
    self.locationAvailable = NO;
    
}

@end
