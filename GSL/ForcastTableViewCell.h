//
//  ForcastTableViewCell.h
//  GSL
//
//  Created by William Lyons on 2016-12-02.
//  Copyright © 2016 William Lyons. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ForcastDay.h"

@interface ForcastTableViewCell : UITableViewCell

-(void)configureWithForcast:(ForcastDay*)forcast;

@property (weak, nonatomic) IBOutlet UILabel *humidity;
@property (weak, nonatomic) IBOutlet UILabel *pressure;
@property (weak, nonatomic) IBOutlet UILabel *temperature;
@property (weak, nonatomic) IBOutlet UILabel *summary;
@property (weak, nonatomic) IBOutlet UILabel *wind;
@property (weak, nonatomic) IBOutlet UILabel *rain;
@property (weak, nonatomic) IBOutlet UILabel *snow;

@end
