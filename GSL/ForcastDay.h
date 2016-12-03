//
//  ForcastDay.h
//  GSL
//
//  Created by William Lyons on 2016-12-02.
//  Copyright © 2016 William Lyons. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ForcastDay : NSObject

@property (nonatomic, strong) NSNumber *humidity;
@property (nonatomic, strong) NSNumber *pressure;
@property (nonatomic, strong) NSNumber *temperature;
@property (nonatomic, strong) NSString *summary;
@property (nonatomic, strong) NSString *wind;

@end
