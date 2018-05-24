//
//  MTBaseViewController.m
//  MakeThings
//
//  Created by Jing Ye on 13/12/2017.
//  Copyright © 2017 aiwen. All rights reserved.
//

#import "MTBaseViewController.h"

@interface MTBaseViewController ()

@end

@implementation MTBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setBackBarButtonItemWithImage:[UIImage imageNamed:@"pubic_arrow_left"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIViewController *)getTargetViewControllerWithStoryboardName:(NSString *)storyboardName viewControllerIdentifier:(NSString *)identifier{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:identifier];
    return vc;
}

#pragma mark - 修改NavigationBar返回按钮，同时不会导致返回手势失效
- (void)setBackBarButtonItemWithImage:(UIImage *)image {
    UIImage *newImage = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0, image.size.width, 0, 0)];
    UIBarButtonItem*backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    [backItem setBackButtonBackgroundImage:newImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    self.navigationItem.backBarButtonItem = backItem;
}



@end
