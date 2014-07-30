//
//  TodayViewController.m
//  WordForCopyWidget
//
//  Created by Nanba Takeo on 2014/07/30.
//  Copyright (c) 2014年 GrooveLab. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

static NSString *const AppGroupId = @"group.asia.groovelab.TodayExtensionContaining";
static NSString *const UserDefaultsKey = @"wordForCopy";

@interface TodayViewController () <NCWidgetProviding>

@property (weak, nonatomic) IBOutlet UIButton *wordToClipboardButton;

@end

@implementation TodayViewController

@synthesize wordToClipboardButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    //  userDefaults
    self.wordToClipboardButton.enabled = NO;
    
    NSUserDefaults *shareduserDeafults = [[NSUserDefaults alloc] initWithSuiteName:AppGroupId];
    NSString *wordForCopy = [shareduserDeafults objectForKey:UserDefaultsKey];
    if ( wordForCopy ) {
        self.wordToClipboardButton.enabled = YES;
    }
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

- (IBAction)copyAction:(id)sender {
    NSUserDefaults *shareduserDeafults = [[NSUserDefaults alloc] initWithSuiteName:AppGroupId];
    NSString *wordForCopy = [shareduserDeafults objectForKey:UserDefaultsKey];
    if ( wordForCopy ) {
        UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
        [pasteBoard setValue:wordForCopy forPasteboardType:@"public.utf8-plain-text"];
    }
}

- (IBAction)openContainingApp:(id)sender {
    NSString *urlStr = @"groovelab-today-extension-containing://";
    [[self extensionContext] openURL:[NSURL URLWithString:urlStr] completionHandler:nil];
}

@end
