//
//  UIView+Extension.h
//  uu
//
//  Created by 四威 on 16/2/22.
//  Copyright © 2016年 梁晋杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)
//视图宽度
@property (nonatomic, assign) CGFloat width;
//视图高度
@property (nonatomic, assign) CGFloat height;
//视图左边
@property (nonatomic, assign) CGFloat x;
//视图顶部
@property (nonatomic, assign) CGFloat y;
//视图大小
@property (nonatomic, assign) CGSize size;
//视图位置
@property (nonatomic, assign) CGPoint origin;
//视图底部(只读)
@property (nonatomic, assign, readonly) CGFloat bottom;
//视图右边(只读)
@property (nonatomic, assign, readonly) CGFloat right;
//视图圆角
@property (nonatomic, assign) CGFloat radius;
//水平渐变色
@property (nonatomic, strong) NSArray<UIColor *> *gradientHorizontalColors;
//垂直渐变色
@property (nonatomic, strong) NSArray<UIColor *> *gradientVerticalColors;
//阴影
@property (nonatomic, assign) CGSize shadowOffset;
/**
 *  移除所有子视图
 */
- (BOOL)removeAllSubviews;
/**
 *  从父视图移除自身饼移除其所有子视图
 */
- (void)removeSelfFromSuperView;
/**
 *  批量添加子控件
 *
 *  @param views 子控件
 */
- (void)addMoreViews:(NSArray *)views;
- (UIViewController *)viewController;
UIViewController* getViewControllerInCurrentScreen();
@end
