//
//  JKCycleLabel.m
//  JKKindsOfSamples
//
//  Created by 四威 on 16/5/5.
//  Copyright © 2016年 JeanKyle. All rights reserved.
//

#import "JKCycleLabel.h"

const NSTimeInterval JKBeginTime = 1.0;

@interface JKCycleLabel () {
    UILabel *_label;
    __block NSInteger _index;
    NSTimeInterval _interval;
}
@property (nonatomic, strong) NSArray<NSString *> *arrayTexts;
@end

@implementation JKCycleLabel

@synthesize texts = _texts;
@synthesize textColor = _textColor;
@synthesize font = _font;
@synthesize textAlignment = _textAlignment;
@synthesize timeInterval = _timeInterval;

- (instancetype)initWithFrame:(CGRect)frame texts:(NSArray<NSString *> *)texts {
    if (self = [super initWithFrame:frame]) {
        [self initializeWithTexts:texts];
    }
    return self;
}
- (void)initializeWithTexts:(NSArray<NSString *> *)texts {
    self.clipsToBounds = true;
    _label = [[UILabel alloc] initWithFrame:self.bounds];
    _label.backgroundColor = [UIColor clearColor];
    [self addSubview:_label];
    _index = 0;
    _label.text = _arrayTexts[0];
    self.font = [UIFont systemFontOfSize:self.frame.size.height * 0.5];
    self.textColor = [UIColor blackColor];
    self.textAlignment = NSTextAlignmentCenter;
    self.texts = texts;
    self.timeInterval = 3;
}
- (void)startCycling {
    
    if (_index == _arrayTexts.count) {
        _index = 0;
    }
    
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.type = @"cube";
    animation.subtype = kCATransitionFromTop;
    [_label.layer addAnimation:animation forKey:@"animation"];
    
    [UIView animateWithDuration:0.5 animations:^{ _label.text = _arrayTexts[_index]; }];
    _index += 1;
    [self performSelector:@selector(startCycling) withObject:nil afterDelay:_interval];
}

#pragma mark - setter
- (void)setTimeInterval:(NSTimeInterval)timeInterval {
    _timeInterval = timeInterval;
    _interval = JKBeginTime + _timeInterval;
}
- (void)setTexts:(NSArray<NSString *> *)texts {
    _texts = texts;
    _arrayTexts = _texts;
}
- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    _label.textColor = _textColor;
}
- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    _textAlignment = textAlignment;
    _label.textAlignment = _textAlignment;
}
- (void)setFont:(UIFont *)font {
    _font = font;
    _label.font = _font;
}

#pragma mark - getter
- (NSArray<NSString *> *)texts {
    return _arrayTexts;
}
- (UIColor *)textColor {
    return _label.textColor;
}
- (NSTextAlignment)textAlignment {
    return _label.textAlignment;
}
- (UIFont *)font {
    return _label.font;
}
- (NSTimeInterval)timeInterval {
    return _interval - JKBeginTime;
}
@end
