//
//  JKMovieTicketController.m
//  JKKindsOfSamples
//
//  Created by 四威 on 16/5/6.
//  Copyright © 2016年 JeanKyle. All rights reserved.
//

#import "JKMovieTicketController.h"
#import "JKChooseView.h"
#import "UIView+Extension.h"

@interface JKMovieTicketController () <JKChooseViewDataSource, JKChooseViewDelegate> {
    JKChooseView *_chooseView;
}
@property (nonatomic, strong) NSArray *arrayData;
@end

@implementation JKMovieTicketController

- (NSArray *)arrayData {
    if (!_arrayData) {
        NSMutableArray *arrayM = [NSMutableArray array];
        NSArray *arrayTitles = @[@"坏蛋必须死", @"美国队长3", @"奇幻森林", @"移动迷宫", @"复仇者联盟"];
        for (NSInteger i = 0; i < arrayTitles.count; i++) {
            JKChooseViewCell *cell = [[JKChooseViewCell alloc] initWithFrame:CGRectMake(0, 0, 100, 150) image:[UIImage imageNamed:[NSString stringWithFormat:@"%02zd", i]] title:arrayTitles[i]];
            [arrayM addObject:cell];
        }
        _arrayData = arrayM;
    }
    return _arrayData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _chooseView = [[JKChooseView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, 200)];
    _chooseView.dataSource = self;
    _chooseView.delegate = self;
    [self.view addSubview:_chooseView];
}
- (NSInteger)numberOfLinesInChooseView:(JKChooseView *)chooseView {
    return self.arrayData.count;
}
- (JKChooseViewCell *)chooseView:(JKChooseView *)chooseView cellForLineAtIndex:(NSInteger)index {
    return self.arrayData[index];
}
@end
