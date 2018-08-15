//
//  HYAlert.m
//  HYFoundation
//
//  Created by ocean on 2018/8/6.
//  Copyright © 2018年 ocean. All rights reserved.
//

#import "HYAlert.h"
#import <UIKit/UIKit.h>

@interface HYAlert ()<UIAlertViewDelegate, UIActionSheetDelegate>

@property (nonatomic, strong) UIAlertController *alertController;
@property (nonatomic, strong) UIAlertView *alertView;
@property (nonatomic, strong) UIActionSheet *actionSheet;
@property (nonatomic, assign) HYAlertStyle preferredStyle;
@property (nonatomic, strong) NSMutableArray *handlers;

@end

@implementation HYAlert

- (NSMutableArray *)handlers {
    if (!_handlers) {
        _handlers = [NSMutableArray array];
    }
    return _handlers;
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(HYAlertStyle)preferredStyle {
    self = [super init];
    if (self) {
        self.preferredStyle = preferredStyle;
        if ([self _iOS8Later]) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(UIAlertControllerStyle)preferredStyle];
            self.alertController = alertController;
        } else {
            if (preferredStyle == HYAlertStyleAlert) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
                self.alertView = alertView;
            } else {
                UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
                self.actionSheet = actionSheet;
            }
        }
    }
    return self;
}

- (void)addActionWithTitle:(nullable NSString *)title style:(HYAlertActionStyle)style handler:(nullable HYAlertActionHandler)handler {
    if ([self _iOS8Later]) {
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:title style:(UIAlertActionStyle)style handler:^(UIAlertAction * _Nonnull mAction) {
            if (handler) {
                handler();
            }
        }];
        [self.alertController addAction:alertAction];
    } else {
        if (self.preferredStyle == HYAlertStyleAlert) {
            [self.alertView addButtonWithTitle:title];
            // cancel  索引处理
            if (style == HYAlertActionStyleCancel) {
                self.alertView.cancelButtonIndex = self.handlers.count;
            }
        } else {
            [self.actionSheet addButtonWithTitle:title];
            // cancel / destructive 索引处理
            if (style == HYAlertActionStyleCancel) {
                self.actionSheet.cancelButtonIndex = self.handlers.count;
            } else if (style == HYAlertActionStyleDestructive) {
                self.actionSheet.destructiveButtonIndex = self.handlers.count;
            }
        }
        if (handler) {
            [self.handlers addObject:handler];
        } else {
            // 为了保证 buttonIndex 一致
            [self.handlers addObject:[NSNull null]];
        }
    }
}

- (void)showInViewController:(UIViewController *)vc {
    if (!vc) return;
    if ([self _iOS8Later]) {
        [vc presentViewController:self.alertController animated:YES completion:nil];
    } else {
        if (self.preferredStyle == HYAlertStyleAlert) {
            [self.alertView show];
        } else {
            [self.actionSheet showInView:vc.view];
        }
    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self _dealWithHandlersAtIndex:buttonIndex];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self _dealWithHandlersAtIndex:buttonIndex];
}

- (void)_dealWithHandlersAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex >= 0 &&
        buttonIndex < self.handlers.count) {
        id block = [self.handlers objectAtIndex:buttonIndex];
        if (![block isKindOfClass:[NSNull class]]) {
            HYAlertActionHandler handler = (HYAlertActionHandler)block;
            if (handler) {
                handler();
            }
        }
    }
}

#pragma mark - helper
- (BOOL)_iOS8Later {
    return [UIDevice currentDevice].systemVersion.doubleValue >= 8;
}

@end
