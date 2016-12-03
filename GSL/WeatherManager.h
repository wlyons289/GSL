//
//  WeatherManager.h
//  GSL
//
//  Created by William Lyons on 2016-12-02.
//  Copyright © 2016 William Lyons. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeatherDay.h"

@interface WeatherManager : NSObject

-(void)processData:(NSData*)data;

-(WeatherDay*)todaysWeather;

@end
