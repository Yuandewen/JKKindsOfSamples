//
//  JKChooseViewCell.m
//  JKKindsOfSamples
//
//  Created by 四威 on 16/5/6.
//  Copyright © 2016年 JeanKyle. All rights reserved.
//

#import "JKChooseViewCell.h"

@implementation JKChooseViewCell {
    UIImageView *_imageView;
    UILabel *_label;
}

- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image title:(NSString *)title {
    if (self = [super initWithFrame:frame]) {
        _image = image;
        _title = title;
        
        CGFloat iH = frame.size.height / 5 * 4;
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, iH)];
        _imageView.image = _image;
        [self addSubview:_imageView];
        
        CGFloat lH = frame.size.height - iH;
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_imageView.frame), frame.size.width, lH)];
        _label.backgroundColor = [UIColor clearColor];
        _label.text = _title;
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont systemFontOfSize:lH * 0.5];
        _label.textColor = [UIColor whiteColor];
        _label.shadowOffset = CGSizeMake(0.5, 0.5);
        _label.shadowColor = [UIColor lightGrayColor];
        [self addSubview:_label];
    }
    return self;
}
- (void)setImage:(UIImage *)image {
    _image = image;
    _imageView.image = _image;
}
- (void)setTitle:(NSString *)title {
    _title = title;
    _label.text = _title;
}

@end
