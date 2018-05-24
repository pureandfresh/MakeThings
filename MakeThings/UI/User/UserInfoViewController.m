//
//  UserInfoViewController.m
//  MakeThings
//
//  Created by Jing Ye on 21/05/2018.
//  Copyright © 2018 aiwen. All rights reserved.
//

#import "UserInfoViewController.h"
#import "UserInfoDetailModel.h"
#import "UserInfoCommonCell.h"
#import "UserInfoPortraitCell.h"
#import "UserPortraitPreviewController.h"
#import "UserChangeInfoViewController.h"
#import "UserQRCodePreviewViewController.h"
#import "UserGenderViewController.h"

static CGFloat kHeightForRow = 60;
static CGFloat kHeightForPortraitRow  = 80;
static NSString *UserInfoCommonCellID = @"UserInfoCommonCell";
static NSString *UserInfoPortraitCellID = @"UserInfoPortraitCell";

@interface UserInfoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSArray *dataArray;
@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self prepareData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)setupUI{
    self.tableView.tableFooterView = [UIView new];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"pubic_arrow_left"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonClicked:)];

}

- (void)leftBarButtonClicked:(UIBarButtonItem *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)prepareData{
    __block NSMutableArray *tempArray = [NSMutableArray array];
    NSArray *titleArray = @[@"头像",@"名字",@"手机号码",@"我的二维码",@"性别",@"地区",@"个性签名",@"我的地址"];
    [titleArray enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL * _Nonnull stop) {
        UserInfoDetailModel *model = [[UserInfoDetailModel alloc]initUserInfoDetailModelWithTitle:title content:@"" type:idx];
        [tempArray addObject:model];
    }];
    self.dataArray  = [NSArray arrayWithArray:tempArray];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return kHeightForPortraitRow;
    }
    return kHeightForRow;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
     UserInfoPortraitCell  *cell =  [tableView dequeueReusableCellWithIdentifier:UserInfoPortraitCellID];
        return cell;
    }else{
       UserInfoCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:UserInfoCommonCellID forIndexPath:indexPath];
        [cell updateUserInfoCommonCellWithModel:self.dataArray[indexPath.row]];
        return cell;

    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UserInfoDetailModel *model = self.dataArray[indexPath.row];
    [self handleTableViewSelectedRowEvent:model];
}

- (void)handleTableViewSelectedRowEvent:(UserInfoDetailModel*)model{
    switch (model.type) {
        case UserInfoRowTypePortrait:{
            [UserPortraitPreviewController pushToUserPortraitPreviewControllerWithImage:[UIImage imageNamed:@"banner_image"] fromViewController:self];
        }
            
            break;
        case UserInfoRowTypeName:{
            //model.content
            [UserChangeInfoViewController presentToUserChangeInfoViewControllerWithContentString:@"test" fromViewController:self];
        }
            
            break;
        case UserInfoRowTypeQRCode:{
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:UserStoryboard bundle:nil];
            UserQRCodePreviewViewController *vc = [storyboard instantiateViewControllerWithIdentifier:UserQRCodePreviewViewControllerID];
            [self.navigationController pushViewController:vc animated:YES];
        }
            
            break;
        case UserInfoRowTypeGender:{
            
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:UserStoryboard bundle:nil];
            UINavigationController *navi = [storyboard instantiateViewControllerWithIdentifier:UserGenderViewControllerNavi];
            [self presentViewController:navi animated:YES completion:nil];
        }


        default:
            break;
    }
}


@end
