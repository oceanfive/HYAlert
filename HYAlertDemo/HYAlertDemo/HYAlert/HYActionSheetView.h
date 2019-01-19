//
//  HYActionSheetView.h
//  HYAlertDemo
//
//  Created by ocean on 2018/8/26.
//  Copyright © 2018年 ocean. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// action 回调block
typedef void (^HYActionSheetViewHandler)(void);

/**
 使用注意:
 1、初始化
 2、先配置相关属性
 3、添加 addActionWithTitle
 4、show
 
 HYActionSheetView *sheetView = [[HYActionSheetView alloc] init];
 
 sheetView.titleColor = [UIColor redColor];
 sheetView.titleFont = [UIFont systemFontOfSize:30];
 sheetView.cellHeight = 80;
 sheetView.spacing = 20;
 sheetView.cancelText = @"你好呀";
 
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
 */
@interface HYActionSheetView : UIView

/// 高度，默认值为 50.0f
@property (nonatomic, assign) CGFloat cellHeight;
/// 字体，默认 [UIFont systemFontOfSize:17]
@property (nonatomic, strong) UIFont *titleFont;
/// 颜色，默认 [UIColor blackColor]
@property (nonatomic, strong) UIColor *titleColor;

/// "取消" 和 "上面的action" 的间距，默认为 7
@property (nonatomic, assign) CGFloat spacing;
/// "取消" action 的文字，默认是 "取消"
@property (nonatomic, copy) NSString *cancelText;

/// 添加 action
- (void)addActionWithTitle:(nullable NSString *)title handler:(nullable HYActionSheetViewHandler)handler;

/// 显示
- (void)show;

@end

NS_ASSUME_NONNULL_END
