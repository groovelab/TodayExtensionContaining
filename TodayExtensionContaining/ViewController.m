//
//  ViewController.m
//  TodayExtensionContaining
//
//  Created by Nanba Takeo on 2014/07/30.
//  Copyright (c) 2014年 GrooveLab. All rights reserved.
//

#import "ViewController.h"

static NSString *const AppGroupId = @"group.asia.groovelab.TodayExtensionContaining";
static NSString *const UserDefaultsKey = @"wordForCopy";

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *wordForCopyTextField;

@end

@implementation ViewController

@synthesize wordForCopyTextField;
            
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //  wordForCopy from UserDefaults
    NSUserDefaults *shareduserDeafults = [[NSUserDefaults alloc] initWithSuiteName:AppGroupId];
    NSString *wordForCopy = [shareduserDeafults objectForKey:UserDefaultsKey];
    if ( wordForCopy ) {
        self.wordForCopyTextField.text = wordForCopy;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveAction:(id)sender {
    
    //  UserDefaults
    NSString *word = self.wordForCopyTextField.text;
    NSUserDefaults *sharedUserDefaults = [[NSUserDefaults alloc] initWithSuiteName:AppGroupId];
    [sharedUserDefaults setObject:word forKey:UserDefaultsKey];
}

@end
