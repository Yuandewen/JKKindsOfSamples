//
//  JKChooseView.h
//  JKKindsOfSamples
//
//  Created by 四威 on 16/5/6.
//  Copyright © 2016年 JeanKyle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKChooseViewCell.h"

@class JKChooseView;

@protocol JKChooseViewDataSource <NSObject>

@required

- (NSInteger)numberOfLinesInChooseView:(JKChooseView *)chooseView;

- (JKChooseViewCell *)chooseView:(JKChooseView *)chooseView cellForLineAtIndex:(NSInteger)index;

@optional

- (NSInteger)defaultCellForLineAtIndexInChooseView:(JKChooseView *)chooseView;

@end

@protocol JKChooseViewDelegate <NSObject>

@optional

- (void)chooseView:(JKChooseView *)chooseView didSelectLineAtIndex:(NSInteger)index;

@end

@interface JKChooseView : UIView <UIScrollViewDelegate>

@property (nonatomic, weak) id<JKChooseViewDelegate>delegate;

@property (nonatomic, weak) id<JKChooseViewDataSource>dataSource;

- (void)reloadData;

- (JKChooseViewCell *)cellForLineAtIndex:(NSInteger)index;

@end
