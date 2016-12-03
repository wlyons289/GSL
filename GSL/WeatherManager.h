//
//  WeatherManager.h
//  GSL
//
//  Created by William Lyons on 2016-12-02.
//  Copyright © 2016 William Lyons. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherManager : NSObject

-(void)processData:(NSDictionary*)dict;

@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *humidity;
@property (nonatomic, strong) NSString *pressure;
@property (nonatomic, strong) NSString *temp;
@property (nonatomic, strong) NSString *weatherDesc;

@end
