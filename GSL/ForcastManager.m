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
    NSArray *days;
}

-(void)processData:(NSDictionary*)dict
{
    days = dict[@"list"];
}


-(ForcastDay*)forcastForDayAtRow:(NSInteger)row
{
    if(days.count <= row)
    {
        return days[row];
    }
    else
    {
        return nil;
    }
}

@end
