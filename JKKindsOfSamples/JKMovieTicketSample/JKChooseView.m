//
//  JKChooseView.m
//  JKKindsOfSamples
//
//  Created by 四威 on 16/5/6.
//  Copyright © 2016年 JeanKyle. All rights reserved.
//

#import "JKChooseView.h"
#import "UIImage+Extension.h"

#define VIEW_PADDING 30

#define VIEW_DIMENSIONS 100

#define VIEWS_OFFSET 100

@implementation JKChooseView {
    UIScrollView *_scrollView;
    UIImageView *_backgroundView;
}

- (instancetype)init {
    if (self = [super init]) {
        [self initiali];
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initiali];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if ( self = [super initWithFrame:frame]) {
        [self initiali];
    }
    return self;
}
- (void)initiali {
    _backgroundView = [[UIImageView alloc] initWithFrame:self.bounds];
    _backgroundView.backgroundColor = [UIColor darkGrayColor];
    _backgroundView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:_backgroundView];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.showsVerticalScrollIndicator = false;
    _scrollView.decelerationRate = 0.5;
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.showsHorizontalScrollIndicator = false;
    _scrollView.delegate = self;
    [self addSubview:_scrollView];
    
    [_scrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewDidTapped:)]];
    
}
- (void)reloadData {
    if (self.dataSource == nil) return;
    
    [_scrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    CGFloat left = VIEWS_OFFSET;
    for (NSInteger i = 0; i < [self.dataSource numberOfLinesInChooseView:self]; i++) {
        left += VIEW_PADDING;
        JKChooseViewCell *cell = [self.dataSource chooseView:self cellForLineAtIndex:i];
        cell.index = i;
        cell.frame = CGRectMake(left, VIEW_PADDING, VIEW_DIMENSIONS, VIEW_DIMENSIONS);
        [_scrollView addSubview:cell];
        left += VIEW_DIMENSIONS + VIEW_PADDING;
    }
    [_scrollView setContentSize:CGSizeMake(left + VIEWS_OFFSET, self.frame.size.height)];
    [self setBackgroundImageWithIndex:0];
    
    if ([self.dataSource respondsToSelector:@selector(defaultCellForLineAtIndexInChooseView:)]) {
        NSInteger defaultIndex = [self.dataSource defaultCellForLineAtIndexInChooseView:self];
        [_scrollView setContentOffset:CGPointMake(defaultIndex * (VIEW_DIMENSIONS + (2 * VIEW_PADDING)), 0) animated:true];
        [self setBackgroundImageWithIndex:defaultIndex];
    }
}
- (void)scrollViewDidTapped:(UIGestureRecognizer *)recognizer {
    
    CGPoint location = [recognizer locationInView:recognizer.view];
    
    for (NSInteger i = 0; i < [self.dataSource numberOfLinesInChooseView:self]; i++) {
        JKChooseView *cell = [_scrollView.subviews objectAtIndex:i];
        
        if (CGRectContainsPoint(cell.frame, location)) {
            [_scrollView setContentOffset:CGPointMake(cell.frame.origin.x - self.frame.size.width * 0.5 + cell.frame.size.width * 0.5, 0) animated:true];
            [self setBackgroundImageWithIndex:i];
            if ([self.delegate respondsToSelector:@selector(chooseView:didSelectLineAtIndex:)]) {
                [self.delegate chooseView:self didSelectLineAtIndex:i];
                break;
            }
        }
    }
    
}
- (void)didMoveToSuperview {
    [self reloadData];
}
- (void)makeCurrentCellCentred {
    NSInteger finalOffset = _scrollView.contentOffset.x + (VIEWS_OFFSET / 2) + VIEW_PADDING;
    NSInteger index = finalOffset / (VIEW_DIMENSIONS + 2 * VIEW_PADDING);
    finalOffset = index * (VIEW_DIMENSIONS + 2 * VIEW_PADDING);
    
    [self setBackgroundImageWithIndex:index];
    
    [_scrollView setContentOffset:CGPointMake(finalOffset, 0) animated:true];
    
    if ([self.delegate respondsToSelector:@selector(chooseView:didSelectLineAtIndex:)]) {
        [self.delegate chooseView:self didSelectLineAtIndex:index];
    }
}
- (void)setBackgroundImageWithIndex:(NSInteger)index {
    JKChooseViewCell *cell = [self cellForLineAtIndex:index];
    _backgroundView.image = [cell.image imageAeroWithBlurRadius:2.5];
    for (JKChooseViewCell *cell in _scrollView.subviews) {
        [UIView animateWithDuration:0.3 animations:^{
            if (cell.index == index) {
                cell.transform = CGAffineTransformMakeScale(1.2, 1.2);
            }else {
                cell.transform = CGAffineTransformMakeScale(1.0, 1.0);
            }
        }];
    }
}
- (JKChooseViewCell *)cellForLineAtIndex:(NSInteger)index {
    for (JKChooseViewCell *cell in _scrollView.subviews) {
        if (cell.index == index) {
            return cell;
        }
    }
    return nil;
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [self makeCurrentCellCentred];
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self makeCurrentCellCentred];
}
@end
