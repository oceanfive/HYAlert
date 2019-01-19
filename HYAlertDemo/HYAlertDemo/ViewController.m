//
//  ViewController.m
//  HYAlertDemo
//
//  Created by ocean on 2018/8/15.
//  Copyright © 2018年 ocean. All rights reserved.
//

#import "ViewController.h"
#import "HYAlert/HYAlert.h"
#import "HYActionSheetView.h"
//#import "HYActionSheetViewController.h"

@interface ViewController ()

@property (nonatomic, strong) HYAlert *alert;
@property (nonatomic, strong) HYActionSheetView *sheetView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    self.alert = [[HYAlert alloc] initWithTitle:@"title" message:@"message" preferredStyle:HYAlertStyleAlert];
//    [self.alert addActionWithTitle:@"按钮1" style:HYAlertActionStyleDefault handler:^{
//        NSLog(@"1111");
//    }];
//    [self.alert addActionWithTitle:@"按钮2" style:HYAlertActionStyleCancel handler:nil];
//    [self.alert addActionWithTitle:@"按钮3" style:HYAlertActionStyleDestructive handler:^{
//        NSLog(@"333");
//    }];
    
//    self.view.backgroundColor = [UIColor clearColor];
    
    self.view.backgroundColor = [UIColor blueColor];
    
    UIImageView *myImageView = [[UIImageView alloc] init];
    myImageView.image = [UIImage imageNamed:@"image"];
    myImageView.contentMode = UIViewContentModeScaleAspectFit;
    myImageView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:myImageView];
    myImageView.frame = self.view.bounds;
    
    
    
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
//    HYAlert *alert = [[HYAlert alloc] initWithTitle:@"title" message:@"message" preferredStyle:HYAlertStyleAlert];
//    [alert addActionWithTitle:@"按钮1" style:HYAlertActionStyleDefault handler:^{
//        NSLog(@"1111");
//    }];
//    [alert addActionWithTitle:@"按钮2" style:HYAlertActionStyleCancel handler:nil];
//    [alert addActionWithTitle:@"按钮3" style:HYAlertActionStyleDestructive handler:^{
//        NSLog(@"333");
//    }];
//    [alert showInViewController:self];
    
    
    
    HYActionSheetView *sheetView = [[HYActionSheetView alloc] init];
    
//    sheetView.titleColor = [UIColor redColor];
//    sheetView.titleFont = [UIFont systemFontOfSize:30];
//    sheetView.cellHeight = 80;
//    sheetView.spacing = 20;
//    sheetView.cancelText = @"你好呀";
    
    [sheetView addActionWithTitle:@"第一个" handler:^{
        NSLog(@"第一个");
    }];
    [sheetView addActionWithTitle:@"第二个" handler:^{
        NSLog(@"第二个");
    }];
    [sheetView addActionWithTitle:@"第三个" handler:^{
        NSLog(@"第三个");
    }];
    
    [sheetView show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
