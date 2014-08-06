//
//  TodayViewController.m
//  WeatherWidget
//
//  Created by Nanba Takeo on 2014/07/30.
//  Copyright (c) 2014年 GrooveLab. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

static NSString *const WeatherURL = @"http://api.openweathermap.org/data/2.5/weather?q=Fukuoka,jp";

@interface TodayViewController () <NCWidgetProviding>

@property (weak, nonatomic) IBOutlet UILabel *weatherLabel;

@end

@implementation TodayViewController

@synthesize weatherLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //  UIVisualEffectView
    UIVisualEffectView *ev = [[UIVisualEffectView alloc] initWithEffect:[UIVibrancyEffect notificationCenterVibrancyEffect]];
    ev.frame = self.view.frame;
    ev.autoresizingMask = self.view.autoresizingMask;
    
    __strong UIView *oldView = self.view;
    self.view = ev;
    [ev.contentView addSubview:oldView];
    self.view.tintColor = [UIColor lightTextColor];
    
    //  weather
    NSURL *url = [NSURL URLWithString:WeatherURL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if (data) {
                                   NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                   
                                   NSData *jsonData = [result dataUsingEncoding:NSUnicodeStringEncoding];
                                   NSError *error;
                                   NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                                        options:NSJSONReadingAllowFragments
                                                                                          error:&error];
                                   NSArray *arr = dict[@"weather"];
                                   NSDictionary *dict2 = arr.firstObject;
                                   self.weatherLabel.text = [NSString stringWithFormat:@"%@", dict2[@"description"]];
                               } else {
                                   self.weatherLabel.text = @"error";
                               }
                           }];

    //  size
    self.preferredContentSize = CGSizeMake( self.preferredContentSize.width, 100.0 );
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encoutered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

@end
