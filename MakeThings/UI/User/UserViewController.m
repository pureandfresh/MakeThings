//
//  UserViewController.m
//  MakeThings
//
//  Created by Jing Ye on 13/12/2017.
//  Copyright © 2017 aiwen. All rights reserved.
//

#import "UserViewController.h"
#import "UserDetailModel.h"
#import "UserCommonCell.h"
#import "UserPortraitCell.h"
#import "MTAplicationUser.h"
#import "UserInfomationAPI.h"
#import "LoginViewController.h"
#import "UserInfoViewController.h"

@interface UserViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSArray *dataArray;
@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareData];
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setupUI{
    self.view.backgroundColor = [UIColor cyanColor];
    self.title = @"我";
  //  self.navigationItem.hidesBackButton = YES;
}

- (void)prepareData{
    MTAplicationUser *user = [[MTAplicationUser sharedAplicationUser]getLatestLoginUser];
    NSMutableArray *data = [NSMutableArray array];
    NSMutableArray *tempArray = [NSMutableArray array];
    
    UserDetailModel *userModel = [[UserDetailModel alloc]init];
    userModel.nickName = user.nickName;

    [data addObject:userModel];

    UserDetailModel *userModelOne = [[UserDetailModel alloc]init];
    UserItemModel *item = [[UserItemModel alloc]initUserItemModelWithTitle:@"我的订单"];
    [tempArray addObject:item];
    userModelOne.itemModelArray = [NSArray arrayWithArray:tempArray];
    [data addObject:userModelOne];
    
    UserDetailModel *userModelTwo = [[UserDetailModel alloc]init];
    [tempArray removeAllObjects];
    NSArray *titleArray = @[@"我的关注",@"我的收藏",@"我的优惠券"];
    for (NSString *title in titleArray) {
        UserItemModel *item = [[UserItemModel alloc]initUserItemModelWithTitle:title];
        [tempArray addObject:item];
    }
    userModelTwo.itemModelArray = [NSArray arrayWithArray:tempArray];
    [data addObject:userModelTwo];

    UserDetailModel *userModelThree = [[UserDetailModel alloc]init];
    [tempArray removeAllObjects];
    UserItemModel *itemSetting = [[UserItemModel alloc]initUserItemModelWithTitle:@"设置"];
    [tempArray addObject:itemSetting];
    userModelThree.itemModelArray = [NSArray arrayWithArray:tempArray];
    [data addObject:userModelThree];
    self.dataArray = [NSArray arrayWithArray:data];
    
    UserInfomationAPI *api =  [[UserInfomationAPI alloc]init];
    //api.delegate = self;

    [api requestUserStatisticWithUserId:user.userID successBlock:^(NSDictionary *responseDic) {
        NSString *status = [NSString stringWithFormat:@"%@",responseDic[@"status"]];
        if (status.integerValue == -2) {
          //  [LoginViewController presentToLoginViewControllerWithFromViewController:self];
        }else if (status.integerValue == 0){
            UserDetailModel *userModelOne = self.dataArray.firstObject;
            [userModelOne updateUserDetailModelWithDictionary:responseDic[@"data"]];
            [self.tableView reloadData];
        }else{
            
        }
            
        
    } failedBlock:^(NSString *errorString) {
        
    }];
    
    
}


#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    UserDetailModel *detailModel = self.dataArray[section];
    if (section == 0) {
        return detailModel.itemModelArray.count +1;
    }

    return detailModel.itemModelArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 80;
    }
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *targetCell;
    if (indexPath.section == 0) {
        UserPortraitCell *cell = [tableView dequeueReusableCellWithIdentifier:UserPortraitCellID];
        [cell updateUserPortraitCellWithModel:self.dataArray.firstObject];
        targetCell = cell;
    }else{
        UserDetailModel *model = self.dataArray[indexPath.section];
        UserItemModel *itemModel = model.itemModelArray[indexPath.row];
        UserCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:UserCommonCellID forIndexPath:indexPath];
        cell.titleLabel.text = itemModel.ItemTitle;
        targetCell = cell;

    }
    return targetCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        UserInfoViewController *vc = (UserInfoViewController *)[self getTargetViewControllerWithStoryboardName:@"User" viewControllerIdentifier:@"UserInfoViewController"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == self.dataArray.count - 1) {
        return  58;
    }
   return  20;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == self.dataArray.count - 1) {
        UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 58)];
        UIButton *logoutButton = [[UIButton alloc]initWithFrame:CGRectMake(16,0 , self.view.frame.size.width-16*2, 58)];
        [logoutButton setTitle:@"退出" forState:UIControlStateNormal];
        [logoutButton setBackgroundColor:[UIColor blueColor]];
        [logoutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        logoutButton.layer.cornerRadius = 5;
        [footerView addSubview:logoutButton];
        return footerView;

    }
    return nil;

}

@end
