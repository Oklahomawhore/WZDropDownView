//
//  ViewController.m
//  WZDropDownView
//
//  Created by Wangshu Zhu on 2019/2/13.
//  Copyright © 2019 zhu wangshu. All rights reserved.
//

#import "ViewController.h"
#import "WZDropDownView.h"

@interface ViewController ()

@property (strong, nonatomic) WZDropDownView *dropView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _dropView = [[WZDropDownView alloc] initWithFrame:CGRectMake(200, 40, 300, 60)];
    NSString *logoPath = [[NSBundle mainBundle] pathForResource:@"网易Logo" ofType:@"jpg"];
    UIImage *logo = [UIImage imageWithContentsOfFile:logoPath];
    NSString *name = @"freewaterzws";
    NSString *lastLogin = @"2017年12月12日";
    
    NSDictionary *dic = @{@"name" : name,
                          @"image" : logo,
                          @"lastLogin" : lastLogin
                          };
    
    NSDictionary *dic2 = @{@"name" : @"MikePence",
                           @"image" : logo,
                           @"lastLogin" : @"2018年1月3日"
                           };
    
    NSDictionary *dic3 = @{@"name" : @"DonaldTrump",
                           @"image" : logo,
                           @"lastLogin" : @"2019年1月1日"
                           };
    
    _dropView.optionArray = @[dic, dic2, dic3];
    [_dropView didSelect:^(NSString * _Nonnull selectedText, NSInteger index, NSInteger identifier) {
        NSLog(@"selected user： %@", selectedText);
    }];
    [self.view addSubview:_dropView];
}


@end
