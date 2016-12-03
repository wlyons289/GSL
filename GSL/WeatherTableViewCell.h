//
//  WeatherTableViewCell.h
//  GSL
//
//  Created by William Lyons on 2016-12-02.
//  Copyright © 2016 William Lyons. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherDay.h"

@interface WeatherTableViewCell : UITableViewCell

-(void)configureWithWeather:(WeatherDay*)weather;

@property (weak, nonatomic) IBOutlet UILabel *city;
@property (weak, nonatomic) IBOutlet UILabel *humidity;
@property (weak, nonatomic) IBOutlet UILabel *temperature;
@property (weak, nonatomic) IBOutlet UILabel *summary;

@end
