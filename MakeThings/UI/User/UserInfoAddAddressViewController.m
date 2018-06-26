//
//  UserInfoAddAddressViewController.m
//  MakeThings
//
//  Created by Jing Ye on 24/05/2018.
//  Copyright © 2018 aiwen. All rights reserved.
//

#import "UserInfoAddAddressViewController.h"
#import "UserInfoAddressCell.h"
#import "UserInfoAddAddressCell.h"
#import "UserInfomationAPI.h"
#import "MTAplicationUser.h"
#import "UserAddressModel.h"
#import "UserInfoEditAddressViewController.h"

@interface UserInfoAddAddressViewController ()<
UITableViewDelegate,
UITableViewDataSource,
UserInfoAddressCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSArray *dataArray;
@end

@implementation UserInfoAddAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareData];
    [self setupUI];
}
 - (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setupUI{
    self.tableView.tableFooterView = [UIView new];
    
}

- (void)prepareData{
    
    __block MTAplicationUser *loginUser = [[MTAplicationUser sharedAplicationUser] getLatestLoginUser];
    WS(weakSelf);
    __block NSMutableArray *tempDataArray = [NSMutableArray array];
    [[[UserInfomationAPI alloc]init] requestUserAddressListWithContact: loginUser.nickName phoneNumber:loginUser.phoneNumber region:@"" detailedAddress:@"" isDefault:@"" userID:loginUser.userID successBlock:^(NSDictionary *responseDic) {
        SS(strongSelf, weakSelf);
        NSArray *tempArray = responseDic[@"data"];
        [tempArray enumerateObjectsUsingBlock:^(NSDictionary  *dic, NSUInteger idx, BOOL * _Nonnull stop) {
            UserAddressModel *model = [[UserAddressModel alloc]initUserAddressModelWithDictionary:dic];
            [tempDataArray addObject:model];
            if (idx == tempArray.count-1) {
                UserAddressModel *model = [[UserAddressModel alloc]init];
                [tempDataArray addObject:model];
            }
            strongSelf.dataArray = [NSArray arrayWithArray:tempDataArray];
            [strongSelf.tableView reloadData];

        }];
        
    } failedBlock:^(NSString *errorString) {
        
    }];
    
   
//    [[[UserInfomationAPI alloc]init] UserAddNewAddressWithContact:loginUser.nickName phoneNumber:loginUser.phoneNumber region:@"四川成都" detailedAddress:@"大连路3号" isDefault:@"true" successBlock:^(NSDictionary *responseDic) {
//        SS(strongSelf, weakSelf);
//        NSString *status = [NSString stringWithFormat:@"%@",responseDic[@"status"]];
//        if (status.integerValue == 0) {
//            // sucess
//            UserAddressModel *addressModel = [[UserAddressModel alloc]init];
//            addressModel.region = @"四川成都";
//            addressModel.detailAddress = @"大连路3号";
//            addressModel.isDefaultAddress = @"true";
//            addressModel.contactName = loginUser.nickName;
//            addressModel.contactPhone = loginUser.phoneNumber;
//            addressModel.addressID = responseDic[@"data"][@"id"];
//            [tempArray addObject:addressModel];
//            strongSelf.dataArray = [NSArray arrayWithArray:tempArray];
//        }
//        
//        
//      
//
//    } failedBlock:^(NSString *errorString) {
//        
//    }];
}


#pragma mark - <UITableViewDelegate,UITableViewDataSource>

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == self.dataArray.count -1) {
        UserInfoAddAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:UserInfoAddAddressCellID];
        cell.addAddressLabel.text = @"增加地址";
        return cell;
    }
    UserInfoAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:UserInfoAddressCellID forIndexPath:indexPath];
    [cell updateUserInfoAddressCellWithModel:self.dataArray[indexPath.row]];
    cell.delegate = self;
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - UserInfoAddressCellDelegate

- (void)userInfoAddressCellDidClickedEditButton:(UserInfoAddressCell *)cell{
    
    UINavigationController *navi = [[UIStoryboard storyboardWithName:@"User" bundle:nil] instantiateViewControllerWithIdentifier:UserInfoEditAddressViewControllerNavi];
    [self presentViewController:navi animated:YES completion:nil];
    
    
}




@end
