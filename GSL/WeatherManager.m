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

-(void)processData:(NSDictionary*)dataDict
{
    weatherDay = [WeatherDay new];
    
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
