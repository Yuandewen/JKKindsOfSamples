//
//  JKCycleLabelController.m
//  JKKindsOfSamples
//
//  Created by 四威 on 16/5/5.
//  Copyright © 2016年 JeanKyle. All rights reserved.
//

#import "JKCycleLabelController.h"
#import "JKCycleLabel.h"

@implementation JKCycleLabelController

- (void)viewDidLoad {
    [super viewDidLoad];
    JKCycleLabel *label = [[JKCycleLabel alloc] initWithFrame:CGRectMake(0, 0, 300, 50)
                                                        texts:@[
                                                                @"外包科室忽悠手册曝光",
                                                                @"六大网盘将关停",
                                                                @"西欧半数男生是1人后裔",
                                                                @"黑心免税店专宰中国人",
                                                                @"老人组团赴美唱红歌",
                                                                @"立案调查百度推广涉广告"
                                                                ]];
    label.center = CGPointMake(self.view.frame.size.width * 0.5, self.view.frame.size.height * 0.5);
    label.timeInterval = 2;
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:22 weight:UIFontWeightHeavy];
    label.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:1 alpha:1];
    [self.view addSubview:label];
    [label startCycling];
}

@end
