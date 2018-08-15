//
//  ViewController.m
//  HYAlertDemo
//
//  Created by ocean on 2018/8/15.
//  Copyright © 2018年 ocean. All rights reserved.
//

#import "ViewController.h"
#import "HYAlert/HYAlert.h"

@interface ViewController ()

@property (nonatomic, strong) HYAlert *alert;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.alert = [[HYAlert alloc] initWithTitle:@"title" message:@"message" preferredStyle:HYAlertStyleAlert];
    [self.alert addActionWithTitle:@"按钮1" style:HYAlertActionStyleDefault handler:^{
        NSLog(@"1111");
    }];
    [self.alert addActionWithTitle:@"按钮2" style:HYAlertActionStyleCancel handler:nil];
    [self.alert addActionWithTitle:@"按钮3" style:HYAlertActionStyleDestructive handler:^{
        NSLog(@"333");
    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.alert showInViewController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
