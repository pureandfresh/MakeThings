//
//  UserGenderViewController.m
//  MakeThings
//
//  Created by Jing Ye on 23/05/2018.
//  Copyright © 2018 aiwen. All rights reserved.
//

#import "UserGenderViewController.h"
#import "UserInfoCheckGenderCell.h"


static CGFloat kHeightForRow = 60;

@interface UserGenderViewController ()<
UITableViewDelegate,
UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSArray *dataArray;

@end

@implementation UserGenderViewController

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
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self
                                                                           action:@selector(leftButtonClicked)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonClicked)];

}

- (void)leftButtonClicked{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)rightButtonClicked{
    //todo
    
}


- (void)prepareData{
    NSArray *genderStringArray = @[@"男",@"女"];
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSString *string in genderStringArray) {
        UserInfoGenderModel *model = [[UserInfoGenderModel alloc]initUserInfoGenderModelWithGenderString:string];
        if ([string isEqualToString:@"男"]) {
            model.isSelected = YES;
        }
        [tempArray addObject:model];
    }
    self.dataArray = [NSArray arrayWithArray:tempArray];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kHeightForRow;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UserInfoCheckGenderCell *cell = [tableView dequeueReusableCellWithIdentifier:UserInfoCheckGenderCellID forIndexPath:indexPath];
    [cell updateCellWithModel:self.dataArray[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UserInfoGenderModel *selectedModel = self.dataArray[indexPath.row];
    selectedModel.isSelected = YES;
    [self.dataArray enumerateObjectsUsingBlock:^(UserInfoGenderModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![selectedModel.genderString isEqualToString:model.genderString]) {
            model.isSelected = NO;
        }
    }];
    [self.tableView reloadData];
}
@end
