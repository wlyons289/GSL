//
//  WeatherDay.h
//  GSL
//
//  Created by William Lyons on 2016-12-02.
//  Copyright © 2016 William Lyons. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherDay : NSObject

@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSNumber *humidity;
@property (nonatomic, strong) NSNumber *pressure;
@property (nonatomic, strong) NSNumber *temp;
@property (nonatomic, strong) NSString *weatherDesc;


@end
