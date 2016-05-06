//
//  JKChooseViewCell.h
//  JKKindsOfSamples
//
//  Created by 四威 on 16/5/6.
//  Copyright © 2016年 JeanKyle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JKChooseViewCell : UIView

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, copy) NSString *title;

- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image title:(NSString *)title;

@end
