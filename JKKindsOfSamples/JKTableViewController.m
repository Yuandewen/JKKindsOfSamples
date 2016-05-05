//
//  JKTableViewController.m
//  JKKindsOfSamples
//
//  Created by 四威 on 16/5/3.
//  Copyright © 2016年 JeanKyle. All rights reserved.
//

#import "JKTableViewController.h"
#import "JKContainerController.h"
#import "UIView+Extension.h"

@implementation JKTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"%@", [NSNotificationCenter defaultCenter]);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0: {
            NSArray *colors = @[[UIColor redColor], [UIColor orangeColor], [UIColor yellowColor], [UIColor greenColor], [UIColor cyanColor], [UIColor blueColor], [UIColor purpleColor], [UIColor brownColor]];
            NSArray *titles = @[@"娱乐头条", @"涨姿势", @"千趣", @"怪谈异事", @"深圳今日焦点", @"微博", @"趣图锦集", @"游戏秀"];
            NSMutableArray *array = [NSMutableArray array];
            for (NSInteger i = 0; i < 8; i++) {
                UIViewController *ctr = [[UIViewController alloc] init];
                ctr.title = titles[i];
                UILabel *lbl = [[UILabel alloc] initWithFrame:ctr.view.bounds];
                lbl.textAlignment = NSTextAlignmentCenter;
                lbl.font = [UIFont systemFontOfSize:200];
                lbl.backgroundColor = colors[i];
                lbl.textColor = [UIColor whiteColor];
                lbl.text = [NSString stringWithFormat:@"%zd", i+1];
                [ctr.view addSubview:lbl];
                [array addObject:ctr];
            }
            JKContainerController *vc = [[JKContainerController alloc] init];
            [vc addChildViewControllers:array];
            [self.navigationController pushViewController:vc animated:true];
        }
            break;
        default:
            break;
    }
}

@end
