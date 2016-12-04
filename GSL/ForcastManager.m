//
//  ForcastManager.m
//  GSL
//
//  Created by William Lyons on 2016-12-02.
//  Copyright © 2016 William Lyons. All rights reserved.
//

#import "ForcastManager.h"

@implementation ForcastManager
{
    NSMutableArray *days;
}

-(void)processData:(NSData*)data
{
    
    days = [NSMutableArray new];
    
    NSError *error;
    NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    NSAssert(dataDict != nil, @"Forcast JSON is nill");

    NSArray *list = dataDict[@"list"];
    for(NSDictionary *forcastDict in list)
    {
        ForcastDay *forcast = [ForcastDay new];
        NSDictionary *main = forcastDict[@"main"];
        forcast.humidity = main[@"humidity"];
        forcast.pressure = main[@"pressure"];
        NSNumber *k = main[@"temp"];
        NSNumber *c = @(k.floatValue - 273.15);
        forcast.temperature = c;
        
        NSArray *weathers = forcastDict[@"weather"];
        if(weathers.count > 0)
        {
            NSDictionary *weather = weathers[0];
            forcast.summary = weather[@"description"];
            
        }

        NSDictionary *wind = forcastDict[@"wind"];
        NSNumber *speed = wind[@"speed"];
        NSNumber *deg = wind[@"deg"];
        forcast.wind = [NSString stringWithFormat:@"%3.1f MPH Heading: %3.1f °", speed.floatValue, deg.floatValue];
        
        
        [days addObject:forcast];
    }
}


-(ForcastDay*)forcastForDayAtRow:(NSInteger)row
{
    if(days && days.count >= row)
    {
        return days[row];
    }
    return nil;
}

-(NSInteger)count
{
    return days.count;
}

@end
