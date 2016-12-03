//
//  WeatherManager.m
//  GSL
//
//  Created by William Lyons on 2016-12-02.
//  Copyright © 2016 William Lyons. All rights reserved.
//

#import "WeatherManager.h"

@implementation WeatherManager
{
    WeatherDay *weatherDay;
}

-(void)processData:(NSData*)data
{
    weatherDay = [WeatherDay new];
    
    NSError *error;
    NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    NSAssert(dataDict != nil, @"Weather JSON is nill");

    weatherDay.city = dataDict[@"name"];
    
    NSDictionary *main = dataDict[@"main"];
    weatherDay.humidity = main[@"humidity"];
    weatherDay.pressure = main[@"pressure"];
    NSNumber *k = main[@"temp"];
    NSNumber *c = @(k.floatValue - 273.15);
    weatherDay.temp = c;
    
    NSArray *weather = dataDict[@"weather"];
    NSDictionary *weatherInfo = [weather objectAtIndex:0];
    weatherDay.weatherDesc = weatherInfo[@"description"];
}

-(WeatherDay*)todaysWeather
{
    return weatherDay;
}

@end
