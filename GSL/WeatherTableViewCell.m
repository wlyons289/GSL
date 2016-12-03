//
//  WeatherTableViewCell.m
//  GSL
//
//  Created by William Lyons on 2016-12-02.
//  Copyright © 2016 William Lyons. All rights reserved.
//

#import "WeatherTableViewCell.h"

@implementation WeatherTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)configureWithWeather:(WeatherDay*)weather
{
    self.city.text = weather.city;
    self.humidity.text = weather.humidity.stringValue;
    self.temperature.text = [NSString stringWithFormat:@"%3.2f", weather.temp.floatValue];
    self.summary.text = weather.weatherDesc;
}

@end
