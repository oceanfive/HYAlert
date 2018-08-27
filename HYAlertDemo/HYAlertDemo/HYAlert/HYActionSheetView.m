//
//  HYActionSheetView.m
//  HYAlertDemo
//
//  Created by ocean on 2018/8/26.
//  Copyright © 2018年 ocean. All rights reserved.
//

#import "HYActionSheetView.h"

#define HY_UICOLOR_FROM_RGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define HY_ANIMATION_DURATON 0.25

@interface HYActionSheetViewCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier;
- (void)configCellTitle:(NSString *)title;
- (void)configCellTitleFont:(UIFont *)titleFont;
- (void)configCellTitleColor:(UIColor *)titleColor;
@property (nonatomic, assign) BOOL lineViewHidden;

@end

@interface HYActionSheetViewCell ()

@property (nonatomic, strong) UILabel *mTitleLabel;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation HYActionSheetViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier {
    HYActionSheetViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[HYActionSheetViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *mTitleLabel = [[UILabel alloc] init];
        mTitleLabel.font = [UIFont systemFontOfSize:20.0f];
        mTitleLabel.textColor = [UIColor blackColor];
        mTitleLabel.textAlignment = NSTextAlignmentCenter;
        mTitleLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:mTitleLabel];
        self.mTitleLabel = mTitleLabel;
        
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = HY_UICOLOR_FROM_RGB(0xcccccc);
        [self.contentView addSubview:lineView];
        self.lineView = lineView;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.mTitleLabel.frame = self.contentView.bounds;
    CGFloat lineHeight = 0.8;
    self.lineView.frame = CGRectMake(0, CGRectGetHeight(self.contentView.frame) - lineHeight, CGRectGetWidth(self.contentView.frame), lineHeight);
}

- (void)configCellTitle:(NSString *)title {
    self.mTitleLabel.text = title;
}
- (void)configCellTitleFont:(UIFont *)titleFont {
    self.mTitleLabel.font = titleFont;
}
- (void)configCellTitleColor:(UIColor *)titleColor {
    self.mTitleLabel.textColor = titleColor;
}

- (void)setLineViewHidden:(BOOL)lineViewHidden {
    _lineViewHidden = lineViewHidden;
    self.lineView.hidden = lineViewHidden;
}

@end

#pragma mark - ---------------------------

@interface HYActionSheetView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) CGFloat spacing;
@property (nonatomic, copy) NSString *cancelText;

/// 添加手势，点击消失，self添加手势不起作用！
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UITableView *mTableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

/// 回调数组
@property (nonatomic, strong) NSMutableArray *handlers;

@end

@implementation HYActionSheetView

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (NSMutableArray *)handlers {
    if (!_handlers) {
        _handlers = [NSMutableArray array];
    }
    return _handlers;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _spacing = 7.0f;
        _cellHeight = 50.0f;
        _titleFont = [UIFont systemFontOfSize:17];
        _titleColor = [UIColor blackColor];
        _cancelText = @"取消";
        [self initSubviews];
    }
    return self;
}
- (void)initSubviews {
    self.mTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mTableView.scrollEnabled = NO;
    self.mTableView.delegate   = self;
    self.mTableView.dataSource = self;
    self.mTableView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.mTableView];
    
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor clearColor];
    [self addSubview:bgView];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgViewDidTap)];
    [bgView addGestureRecognizer:tapGesture];
    self.bgView = bgView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat tableHeight = self.dataSource.count * _cellHeight + _spacing + _cellHeight;
    CGFloat tableViewY = CGRectGetHeight(self.bounds) - tableHeight;
    if ([self _isiPhoneX]) {
        tableViewY -= [self _iPhoneXTabBarAddHeight];
    }
    self.mTableView.frame = CGRectMake(0, tableViewY, CGRectGetWidth(self.bounds), tableHeight);
    self.bgView.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), tableViewY);
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.dataSource.count;
    } else {
        return 1;
    }
}

#pragma mark - UITableView - Rows - Display
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"HYActionSheetViewCell";
    HYActionSheetViewCell *cell = [HYActionSheetViewCell cellWithTableView:tableView identifier:identifier];
    
    if (indexPath.section == 0) {
        NSString *cellData = [self.dataSource objectAtIndex:indexPath.row];
        [cell configCellTitle:cellData];
    } else {
        [cell configCellTitle:_cancelText];
    }
    [cell configCellTitleColor:_titleColor];
    [cell configCellTitleFont:_titleFont];
    cell.lineViewHidden = (indexPath.section == 1) || (indexPath.row == self.dataSource.count - 1);
    
    return cell;
}

#pragma mark - UITableView - Header - Display
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.1f;
    } else {
        return _spacing;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    static NSString *headerIdentifer = @"UITableViewHeaderFooterViewID";
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifer];
    if (!headerView) {
        headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:headerIdentifer];
        UIView *bgView = [[UIView alloc] init];
        bgView.backgroundColor = [UIColor clearColor];
        bgView.frame = headerView.bounds;
        headerView.backgroundView = bgView;
    }
    return headerView;
}

#pragma mark - UITableView - Footer - Display
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        id block = [self.handlers objectAtIndex:indexPath.row];
        if (![block isKindOfClass:[NSNull class]]) {
            HYActionSheetViewHandler handle = (HYActionSheetViewHandler)block;
            if (handle) {
                handle();
                [self dismiss];
            }
        } else {
            // 没有回调
            [self dismiss];
        }
    } else {
        // 取消
        [self dismiss];
    }
}

#pragma mark - 操作
- (void)addActionWithTitle:(NSString *)title handler:(HYActionSheetViewHandler)handler {
    if (!title || title.length <= 0) {
        return;
    }
    [self.dataSource addObject:title];
    if (handler) {
        [self.handlers addObject:handler];
    } else {
        [self.handlers addObject:[NSNull null]];
    }
    [self.mTableView reloadData];
}

#pragma mark - show / dismiss

- (void)show {
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [keyWindow addSubview:self];
    
    CGRect frame = keyWindow.bounds;
    frame.origin.y += frame.size.height;
    self.frame = frame;
    // frame 动画
    [UIView animateWithDuration:HY_ANIMATION_DURATON delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.frame = keyWindow.bounds;
    } completion:^(BOOL finished) {

    }];
    // backgroundColor 动画；延时执行，避免突兀，不会显示“self黑框”上移动画
    self.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:HY_ANIMATION_DURATON delay:HY_ANIMATION_DURATON - 0.05 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)dismiss {
    // 动画是 self 的话，会有“self黑框”下移动画
    CGRect frame = self.mTableView.frame;
    frame.origin.y += frame.size.height;
    if ([self _isiPhoneX]) {
        frame.origin.y += [self _iPhoneXTabBarAddHeight];
    }
    [UIView animateWithDuration:HY_ANIMATION_DURATON delay:0  options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.mTableView.frame = frame;
    } completion:^(BOOL finished) {
        self.backgroundColor = [UIColor clearColor];
        [self removeFromSuperview];
    }];
}

#pragma mark - 手势
- (void)bgViewDidTap {
    [self dismiss];
}

#pragma mark - 私有方法

- (BOOL)_isiPhoneX {
    return CGSizeEqualToSize(CGSizeMake(375, 812), [[UIScreen mainScreen] bounds].size);
}

- (CGFloat)_iPhoneXTabBarAddHeight {
    return 34;
}

- (void)dealloc {
    NSLog(@"HYActionSheetView dealloc");
}


@end
