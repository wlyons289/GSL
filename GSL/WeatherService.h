//
//  WeatherService.h
//  GSL
//
//  Created by William Lyons on 2016-12-02.
//  Copyright © 2016 William Lyons. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WeatherManager.h"
#import "ForcastManager.h"

@import CoreLocation;

// base urls used for requests
static const NSString *weatherUrl = @"http://api.openweathermap.org/data/2.5/weather?";
static const NSString *forcastUrl = @"http://api.openweathermap.org/data/2.5/forecast?";

// API key
static const NSString *apiKey = @"30cd047ae5ed7b3f99b563ff25762952";

// notifications
static NSString *notifyWeatherUpated = @"weatherUpdated";
static NSString *notifyForcastUpated = @"forcastUpdated";
static NSString *notifyLocationUpdated = @"locationUpdated";
static NSString *notifyNetworkError = @"networkError";


@interface WeatherService : NSObject <CLLocationManagerDelegate>

@property (nonatomic) CLLocationCoordinate2D currentCoordinates;
@property (nonatomic) BOOL locationAvailable;

@property (nonatomic, strong) WeatherManager *weatherManager;
@property (nonatomic, strong) ForcastManager *forcastManager;

+(WeatherService*)sharedInstance;
-(void)requestForcast;
-(void)requestWeather;
-(void)stopLocationManager;
-(void)startLocationManager;


@end
