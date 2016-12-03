//
//  WeatherManager.m
//  GSL
//
//  Created by William Lyons on 2016-12-02.
//  Copyright © 2016 William Lyons. All rights reserved.
//

#import "WeatherManager.h"

@implementation WeatherManager


-(void)processData:(NSDictionary*)dataDict
{
    
    self.city = dataDict[@"name"];
    
    NSDictionary *main = dataDict[@"main"];
    self.humidity = [NSString stringWithFormat:@"%@", main[@"humidity"]];
    self.pressure = [NSString stringWithFormat:@"%@", main[@"pressure"]];
    self.temp = [NSString stringWithFormat:@"%@", main[@"temp"]];
    
    NSArray *weather = dataDict[@"weather"];
    NSDictionary *weatherInfo = [weather objectAtIndex:0];
    self.weatherDesc = weatherInfo[@"description"];
    
    
}

@end
