//
//  ViewController.m
//  GSL
//
//  Created by William Lyons on 2016-12-02.
//  Copyright © 2016 William Lyons. All rights reserved.
//

#import "ViewController.h"
#import "WeatherService.h"

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
    WeatherService *service = [WeatherService sharedInstance];
    WeatherManager *weatherManager = service.weatherManager;
    self.labelCity.text = weatherManager.city;
    self.labelTemp.text = weatherManager.temp;
    self.labelHumidity.text = weatherManager.humidity;
    self.labelDescription.text = weatherManager.weatherDesc;
    
}

-(void)forcastUpdated:(NSNotification* )notification
{
    NSLog(@"weather updated");
    
    
}

-(void)locationUpdated:(NSNotification* )notification
{
    [self requestData];
}


@end
