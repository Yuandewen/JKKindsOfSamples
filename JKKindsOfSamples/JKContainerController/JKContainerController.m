//
//  JKContainerController.m
//  JKKindsOfSamples
//
//  Created by 四威 on 16/5/3.
//  Copyright © 2016年 JeanKyle. All rights reserved.
//

#import "JKContainerController.h"
#import "UIView+Extension.h"

@interface JKContainerController() <UIScrollViewDelegate>{
    UIScrollView *_segment;
    UIScrollView *_contentView;
    UIView *_lineSegment;
    UIView *_navigationBar;
}
@property (nonatomic, strong) NSArray *arrayTitles;
@property (nonatomic, strong) NSArray *arrayControllers;
@end

@implementation JKContainerController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:true];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:false];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)addChildViewControllers:(NSArray<UIViewController *> *)childViewControllers {
    _arrayControllers = childViewControllers;
    NSMutableArray *arrayM = [NSMutableArray array];
    for (UIViewController *vc in childViewControllers) {
        if (!vc.title.length) {
            vc.title = @"分页";
        }
        [arrayM addObject:vc.title];
    }
    _arrayTitles = arrayM;
    [self layoutNavigationBar];
    [self layoutSegment];
    [self layoutContentView];
}
- (void)layoutNavigationBar {
    _navigationBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 64)];
    _navigationBar.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setImage:[UIImage imageNamed:@"i_back"] forState:UIControlStateNormal];
    btn.tintColor = [UIColor purpleColor];
    btn.frame = CGRectMake(0, 20, 35, 44);
    [_navigationBar addSubview:btn];
    [btn addTarget:self action:@selector(backItemClick) forControlEvents:UIControlEventTouchUpInside];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, _navigationBar.height - 0.27, _navigationBar.width, 0.27)];
    line.backgroundColor = [UIColor lightGrayColor];
    [_navigationBar addSubview:line];
    [self.view addSubview:_navigationBar];
}
- (void)layoutContentView {
    _contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _segment.bottom, self.view.width, self.view.height - _segment.bottom)];
    _contentView.showsVerticalScrollIndicator = false;
    _contentView.delegate = self;
    _contentView.showsHorizontalScrollIndicator = false;
    _contentView.pagingEnabled = true;
    [self.view addSubview:_contentView];
    CGFloat vLeft = 0, vTop = 0, vWidth = _contentView.width, vHeight = _contentView.height;
    for (NSInteger i = 0; i < _arrayControllers.count; i++) {
        UIViewController *vc = _arrayControllers[i];
        UIView *view = vc.view;
        view.tag = 300 + i;
        view.frame = CGRectMake(vLeft, vTop, vWidth, vHeight);
        [_contentView addSubview:view];
        vLeft += vWidth;
    }
    _contentView.contentSize = CGSizeMake(vLeft, vHeight);
}
- (void)layoutSegment {
    CGFloat bLeft = 0, bTop = 0, bHeight = 40, bWidth;
    _segment = [[UIScrollView alloc] initWithFrame:CGRectMake(bLeft, 20, _navigationBar.width / 3 * 2, bHeight)];
    _segment.showsVerticalScrollIndicator = false;
    _segment.showsHorizontalScrollIndicator = false;
    _segment.center = CGPointMake(_navigationBar.width * 0.5, _segment.center.y);
    [_navigationBar addSubview:_segment];
    for (NSInteger i = 0; i < _arrayTitles.count; i++) {
        NSString *title = _arrayTitles[i];
        UIFont *font = [UIFont systemFontOfSize:16];
        UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
        item.backgroundColor = [UIColor whiteColor];
        item.titleLabel.font = font;
        item.tag = i + 200;
        item.titleLabel.textAlignment = NSTextAlignmentCenter;
        [item setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [item setTitle:title forState:UIControlStateNormal];
        bWidth = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, bHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size.width + 30;
        item.frame = CGRectMake(bLeft, bTop, bWidth, bHeight);
        if (i == 0) {
            _lineSegment = [[UIView alloc] initWithFrame:CGRectMake(0, item.bottom - 3, item.width, 3)];
            _lineSegment.backgroundColor = [UIColor purpleColor];
            [_segment addSubview:_lineSegment];
        }
        [_segment addSubview:item];
        [item addTarget:self action:@selector(segmentItemSelected:) forControlEvents:UIControlEventTouchUpInside];
        bLeft += bWidth;
    }
    [_segment bringSubviewToFront:_lineSegment];
    _segment.contentSize = CGSizeMake(bLeft, bHeight);
}
- (void)backItemClick {
    [self dismissViewControllerAnimated:true completion:nil];
    [self.navigationController popViewControllerAnimated:true];
}
- (void)segmentItemSelected:(UIButton *)item {
    [UIView animateWithDuration:0.3 animations:^{
        _lineSegment.x = item.x;
        _lineSegment.width = item.width;
        [_segment scrollRectToVisible:item.frame animated:true];
    }];
    UIView *view = [_contentView viewWithTag:item.tag + 100];
    [_contentView scrollRectToVisible:view.frame animated:true];
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    UIButton *btn = (UIButton *)[_segment viewWithTag:index + 200];
    [self segmentItemSelected:btn];
    [_segment scrollRectToVisible:btn.frame animated:true];
}
@end
