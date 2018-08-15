//
//  HYAlert.h
//  HYFoundation
//
//  Created by ocean on 2018/8/6.
//  Copyright © 2018年 ocean. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class UIViewController;

typedef NS_ENUM(NSUInteger, HYAlertStyle) {
    /** 等价于 UIActionSheet */
    HYAlertStyleSheet = 0,
    /** 等价于 UIAlertView */
    HYAlertStyleAlert
};

typedef NS_ENUM(NSInteger, HYAlertActionStyle) {
    /** 蓝色 */
    HYAlertActionStyleDefault = 0,
    /** 蓝色，位置在最下面或最最左面 */
    HYAlertActionStyleCancel,
    /** 红色 */
    HYAlertActionStyleDestructive
};

/// action 回调block
typedef void (^HYAlertActionHandler)(void);

/**
 使用注意：
 1、8.0之前，需要引用 HYAlert 对象，否则对象被释放掉了，代理方法不会被调用
 2、使用私有API可以修改 UIAlertAction 和 UIAlertController 的样式，
    http://ok0lwc348.bkt.clouddn.com/UIAlertAction%E7%A7%81%E6%9C%89API.png
    http://ok0lwc348.bkt.clouddn.com/UIAlertController%E7%A7%81%E6%9C%89API.png
 */

@interface HYAlert : NSObject

/// 初始化方法
- (instancetype)initWithTitle:(nullable NSString *)title message:(nullable NSString *)message preferredStyle:(HYAlertStyle)preferredStyle;

/// 添加button操作
- (void)addActionWithTitle:(nullable NSString *)title style:(HYAlertActionStyle)style handler:(nullable HYAlertActionHandler)handler;

/// 显示
- (void)showInViewController:(UIViewController *)vc;

@end

NS_ASSUME_NONNULL_END

