//
//  ViewController.h
//  GSL
//
//  Created by William Lyons on 2016-12-02.
//  Copyright © 2016 William Lyons. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UITableViewController <UITabBarDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *labelCity;
@property (weak, nonatomic) IBOutlet UILabel *labelHumidity;
@property (weak, nonatomic) IBOutlet UILabel *labelTemp;
@property (weak, nonatomic) IBOutlet UILabel *labelDescription;

@end

