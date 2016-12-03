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

-(void)processData:(NSDictionary*)dict
{
    days = [NSMutableArray new];
    NSArray *list = dict[@"list"];
    
    for(NSDictionary *forcastDict in list)
    {
        ForcastDay *forcast = [ForcastDay new];
        NSDictionary *main = forcastDict[@"main"];
        forcast.humidity = main[@"humidity"];
        forcast.pressure = main[@"pressure"];
        NSNumber *k = main[@"temp"];
        NSNumber *c = @(k.floatValue - 273.15);
        forcast.temperature = c;
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
