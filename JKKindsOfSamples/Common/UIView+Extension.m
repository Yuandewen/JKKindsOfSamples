//
//  UIView+Extension.m
//  uu
//
//  Created by 四威 on 16/2/22.
//  Copyright © 2016年 梁晋杰. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)
#pragma mark - getter
- (CGFloat)width {
    return self.frame.size.width;
}
- (CGFloat)height {
    return self.frame.size.height;
}
- (CGFloat)x {
    return self.frame.origin.x;
}
- (CGFloat)y {
    return self.frame.origin.y;
}
- (CGSize)size {
    return self.frame.size;
}
- (CGPoint)origin {
    return self.frame.origin;
}
- (CGFloat)bottom {
    return CGRectGetMaxY(self.frame);
}
- (CGFloat)right {
    return CGRectGetMaxX(self.frame);
}
- (CGFloat)radius {
    return 0;
}
- (CGSize)shadowOffset {
    return self.layer.shadowOffset;
}
//渐变色get方法无意义
- (NSArray<UIColor *> *)gradientHorizontalColors {
    return @[self.backgroundColor];
}
//渐变色get方法无意义
- (NSArray<UIColor *> *)gradientVerticalColors {
    return @[self.backgroundColor];
}
#pragma mark - setter
- (void)setWidth:(CGFloat)width {
    CGRect frm = self.frame;
    frm.size.width = width;
    self.frame = frm;
}
- (void)setHeight:(CGFloat)height {
    CGRect frm = self.frame;
    frm.size.height = height;
    self.frame = frm;
}
- (void)setX:(CGFloat)x {
    CGRect frm = self.frame;
    frm.origin.x = x;
    self.frame = frm;
}
- (void)setY:(CGFloat)y {
    CGRect frm = self.frame;
    frm.origin.y = y;
    self.frame = frm;
}
- (void)setSize:(CGSize)size {
    CGRect frm = self.frame;
    frm.size = size;
    self.frame = frm;
}
- (void)setOrigin:(CGPoint)origin {
    CGRect frm = self.frame;
    frm.origin = origin;
    self.frame = frm;
}
- (void)setRadius:(CGFloat)radius {
    self.layer.cornerRadius = radius;//设置那个圆角的有多圆
    self.layer.masksToBounds = YES;//这样会使圆角不被遮，但是这样会导致阴影效果没有
}
- (void)setShadowOffset:(CGSize)shadowOffset {
    self.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    self.layer.shadowOpacity = 1;
    self.layer.shadowOffset = shadowOffset;
}
- (void)setGradientHorizontalColors:(NSArray<UIColor *> *)gradientHorizontalColors {
    CAGradientLayer *layerG = [CAGradientLayer layer];
    layerG.frame = self.bounds;
    NSMutableArray *arrColors = [NSMutableArray array];
    for (UIColor *color in gradientHorizontalColors) {
        CGColorRef colorCG = color.CGColor;
        [arrColors addObject:(__bridge id)colorCG];
    }
    layerG.colors = arrColors;
    layerG.startPoint = CGPointMake(0, 0);
    layerG.endPoint = CGPointMake(1, 0);
    [self.layer addSublayer:layerG];
}
- (void)setGradientVerticalColors:(NSArray<UIColor *> *)gradientVerticalColors {
    CAGradientLayer *layerG = [CAGradientLayer layer];
    layerG.frame = self.bounds;
    NSMutableArray *arrColors = [NSMutableArray array];
    for (UIColor *color in gradientVerticalColors) {
        CGColorRef colorCG = color.CGColor;
        [arrColors addObject:(__bridge id)colorCG];
    }
    layerG.colors = arrColors;
    [self.layer addSublayer:layerG];
}
#pragma mark - 对象方法
- (BOOL)removeAllSubviews {
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    if (self.subviews.count) {
        return NO;
    }
    return YES;
}
- (void)removeSelfFromSuperView {
    if ([self removeAllSubviews]) {
        [self removeFromSuperview];
    }
}
- (void)addMoreViews:(NSArray *)views {
    for (UIView *view in views) {
        [self addSubview:view];
    }
}
- (UIViewController *)viewController {
    for (UIView *next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}
UIViewController* getViewControllerInCurrentScreen() {
    UIViewController *result = nil;
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for (UIWindow * tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        if ([nextResponder isKindOfClass:UINavigationController.class]) {
            result = ((UINavigationController *)nextResponder).viewControllers.lastObject;
        } else {
            result = (UIViewController *)nextResponder;
        }
    }else {
        result = window.rootViewController;
    }
    return result;
}
@end
