//
//  ForcastTableViewCell.m
//  GSL
//
//  Created by William Lyons on 2016-12-02.
//  Copyright © 2016 William Lyons. All rights reserved.
//

#import "ForcastTableViewCell.h"

@implementation ForcastTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configureWithForcast:(ForcastDay*)forcast
{
    self.humidity.text = forcast.humidity.stringValue;
    self.pressure.text = forcast.pressure.stringValue;
    self.temperature.text = [NSString stringWithFormat:@"%3.2f", forcast.temperature.floatValue];
    self.summary.text = forcast.summary;
    self.wind.text = forcast.wind;
    self.rain.text = forcast.rain;
    self.snow.text = forcast.snow;
}

@end
