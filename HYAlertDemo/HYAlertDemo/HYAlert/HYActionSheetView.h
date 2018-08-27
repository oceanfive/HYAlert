//
//  HYActionSheetView.h
//  HYAlertDemo
//
//  Created by ocean on 2018/8/26.
//  Copyright © 2018年 ocean. All rights reserved.
//

#import <UIKit/UIKit.h>

/// action 回调block
typedef void (^HYActionSheetViewHandler)(void);

@interface HYActionSheetView : UIView

/// 高度，默认值为 50.0f
@property (nonatomic, assign) CGFloat cellHeight;
/// 字体，默认 [UIFont systemFontOfSize:17]
@property (nonatomic, strong) UIFont *titleFont;
/// 颜色，默认 [UIColor blackColor]
@property (nonatomic, strong) UIColor *titleColor;

/// 添加 action
- (void)addActionWithTitle:(nullable NSString *)title handler:(nullable HYActionSheetViewHandler)handler;

/// 显示
- (void)show;

@end
