//
//  MainTabBarViewController.m
//  MakeThings
//
//  Created by Jing Ye on 13/12/2017.
//  Copyright © 2017 aiwen. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "MTBaseNavigationViewController.h"
#import "ExerciseViewController.h"
#import "EattingViewController.h"
#import "MasterCircleViewController.h"
#import "ActivityViewController.h"
#import "UserViewController.h"


typedef NS_ENUM(NSInteger,MainTabBarItemType){
    MainTabBarItemTypeExercise = 0,
    MainTabBarItemTypeEatting,
    MainTabBarItemTypeMasterCircle,
    MainTabBarItemTypeActivity,
    MainTabBarItemTypeUser
} ;

static NSString *kExerciseTitle = @"锻炼";
static NSString *kEattingTitle = @"饮食";
static NSString *kMasterCircleTitle = @"牛人圈";
static NSString *kActivityTitle = @"活动";
static NSString *kUserTitle = @"我";


@interface MainTabBarViewController ()<UINavigationControllerDelegate>
@property (nonatomic) NSArray *tabBarItemArray;
@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTabBarController];
  //  self.navigationItem.hidesBackButton = YES;


}

//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
//    self.navigationItem.hidesBackButton = NO;
//
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (NSArray *)tabBarItemArray {
    if (!_tabBarItemArray) {
        _tabBarItemArray = @[@(MainTabBarItemTypeExercise),
                             @(MainTabBarItemTypeEatting),
                             @(MainTabBarItemTypeMasterCircle),
                             @(MainTabBarItemTypeActivity),
                             @(MainTabBarItemTypeUser)
                             ];
    }
    return _tabBarItemArray;
    
}

- (void)setupTabBarController{
    __weak typeof(self) welf = self;
    __block NSMutableArray *viewControllersArray = [NSMutableArray array];
    [self.tabBarItemArray enumerateObjectsUsingBlock:^(NSNumber *number, NSUInteger idx, BOOL * _Nonnull stop) {
        [viewControllersArray addObject:[welf buildViewControllerFromType:number.integerValue]];
    }];
    self.viewControllers = [viewControllersArray copy];
}

- (UIViewController * _Nonnull)buildViewControllerFromType:(MainTabBarItemType)Type{
    UIViewController *targetViewController;
    switch (Type) {
        case MainTabBarItemTypeExercise:{
            
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            ExerciseViewController *exerciseVc = [mainStoryboard instantiateViewControllerWithIdentifier:@"ExerciseViewController"];
            MTBaseNavigationViewController *exerciseNavi = [[MTBaseNavigationViewController alloc]initWithRootViewController:exerciseVc];
            exerciseNavi.tabBarItem = [[UITabBarItem alloc]initWithTitle:kExerciseTitle image:[UIImage imageNamed:@"test_image"] selectedImage:[UIImage imageNamed:@"test_image1"]];
            exerciseNavi.statusBarStyle = UIStatusBarStyleLightContent;
            exerciseNavi.navigationBar.translucent = NO;
            targetViewController = exerciseNavi;

        }
            
            break;
        case MainTabBarItemTypeEatting:{
            EattingViewController *eattingVc = [[EattingViewController alloc]init];
            MTBaseNavigationViewController *eattingNavi = [[MTBaseNavigationViewController alloc]initWithRootViewController:eattingVc];
            eattingNavi.tabBarItem = [[UITabBarItem alloc]initWithTitle:kEattingTitle image:[UIImage imageNamed:@"test_image"] selectedImage:[UIImage imageNamed:@"test_image1"]];
            eattingNavi.statusBarStyle = UIStatusBarStyleLightContent;
            eattingNavi.navigationBar.translucent = NO;
            targetViewController = eattingNavi;

        }
            
            break;
        case MainTabBarItemTypeMasterCircle:{
            MasterCircleViewController *masterCirclrVc = [[MasterCircleViewController alloc]init];
            MTBaseNavigationViewController *masterCircleNavi = [[MTBaseNavigationViewController alloc]initWithRootViewController:masterCirclrVc];
            masterCircleNavi.tabBarItem = [[UITabBarItem alloc]initWithTitle:kMasterCircleTitle image:[UIImage imageNamed:@"test_image"] selectedImage:[UIImage imageNamed:@"test_image1"]];
            masterCircleNavi.statusBarStyle = UIStatusBarStyleLightContent;
            masterCircleNavi.navigationBar.translucent = NO;
            targetViewController = masterCircleNavi;

        }
            
            break;
        case MainTabBarItemTypeActivity:{
            ActivityViewController *activityVc = [[ActivityViewController alloc]init];
            MTBaseNavigationViewController *activityNavi = [[MTBaseNavigationViewController alloc]initWithRootViewController:activityVc];
            activityNavi.tabBarItem = [[UITabBarItem alloc]initWithTitle:kActivityTitle image:[UIImage imageNamed:@"test_image"] selectedImage:[UIImage imageNamed:@"test_image1"]];
            activityNavi.statusBarStyle = UIStatusBarStyleLightContent;
            activityNavi.navigationBar.translucent = NO;
            targetViewController = activityNavi;

        }
            
            break;
        case MainTabBarItemTypeUser:{
//            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:UserStoryboard bundle:nil];
//            UserViewController *userVc = [storyboard instantiateViewControllerWithIdentifier:UserViewControllerID];

            MTBaseNavigationViewController *userNavi = [[UIStoryboard storyboardWithName:UserStoryboard bundle:nil] instantiateViewControllerWithIdentifier:@"userNavi"];
            userNavi.tabBarItem = [[UITabBarItem alloc]initWithTitle:kUserTitle image:[UIImage imageNamed:@"test_image"] selectedImage:[UIImage imageNamed:@"test_image1"]];
            userNavi.statusBarStyle = UIStatusBarStyleLightContent;
            userNavi.navigationBar.translucent = NO;
            targetViewController = userNavi;

        }
            
            break;

        default:
            break;
    }
    return targetViewController;
}

@end
