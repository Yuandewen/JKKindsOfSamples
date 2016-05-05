//
//  JKCycleLabel.h
//  JKKindsOfSamples
//
//  Created by 四威 on 16/5/5.
//  Copyright © 2016年 JeanKyle. All rights reserved.
//

#import <UIKit/UIKit.h>

extern const  NSTimeInterval JKBeginTime;

@interface JKCycleLabel : UIView

@property (nonatomic, strong) NSArray<NSString *> *texts;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, assign) NSTextAlignment textAlignment;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, assign) NSTimeInterval timeInterval;

- (instancetype)initWithFrame:(CGRect)frame texts:(NSArray<NSString *> *)texts;

- (void)startCycling;



@end
