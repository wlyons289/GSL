//
//  ViewController.m
//  GSL
//
//  Created by William Lyons on 2016-12-02.
//  Copyright © 2016 William Lyons. All rights reserved.
//

#import "ViewController.h"
#import "WeatherService.h"
#import "WeatherTableViewCell.h"
#import "ForcastTableViewCell.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weatherUpdated:) name:notifyWeatherUpated object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(forcastUpdated:) name:notifyForcastUpated object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locationUpdated:) name:notifyLocationUpdated object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (IBAction)refresh:(id)sender
{
    NSLog(@"refresh");
    [sender endRefreshing];
    
    [self requestData];
    
}

-(void)requestData
{
    WeatherService *service = [WeatherService sharedInstance];
    if(service.currentCoordinates.latitude != 0.0 && service.currentCoordinates.longitude != 0.0) {
        [service requestWeather];
        [service requestForcast];
    }
}

-(void)weatherUpdated:(NSNotification* )notification
{
    NSLog(@"weather updated");
    [self.tableView reloadData];
}

-(void)forcastUpdated:(NSNotification* )notification
{
    NSLog(@"forcast updated");
    [self.tableView reloadData];
    
}

-(void)locationUpdated:(NSNotification* )notification
{
    [self requestData];
}


#pragma mark - Table view datasource

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section == 0)
        return @"Today"; // TODO: localize
    else
        return @"3 day forcast";
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2; // TODO: const
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0) {
        return 1;
    }
    else
    {
        WeatherService *service = [WeatherService sharedInstance];
        return service.forcastManager.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *weatherCellId = @"WEATHER_CELL";
    static NSString *forcastCellId = @"FORCAST_CELL";
    
    WeatherService *service = [WeatherService sharedInstance];
    
    UITableViewCell *cell = nil;
    switch(indexPath.section)
    {
        case 0:
        {
            WeatherTableViewCell *weatherCell = (WeatherTableViewCell*)[tableView dequeueReusableCellWithIdentifier:weatherCellId];
            [weatherCell configureWithWeather:service.weatherManager.todaysWeather];
            cell = weatherCell;
            break;
        }
        case 1:
        {
            ForcastTableViewCell *forcastCell = (ForcastTableViewCell*)[tableView dequeueReusableCellWithIdentifier:forcastCellId];
            ForcastDay *f = [service.forcastManager forcastForDayAtRow:indexPath.row];
            [forcastCell configureWithForcast:f];
            cell = forcastCell;
            break;
        }
    }

    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0) {
        return 140; // TODO: const
    }
    else return 220;
}

@end
