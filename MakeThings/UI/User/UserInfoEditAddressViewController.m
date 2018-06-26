//
//  UserInfoEditAddressViewController.m
//  MakeThings
//
//  Created by Jing Ye on 24/05/2018.
//  Copyright © 2018 aiwen. All rights reserved.
//

#import "UserInfoEditAddressViewController.h"

@interface UserInfoEditAddressViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation UserInfoEditAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setupUI{
    self.tableView.tableFooterView = [UIView new];
    self.title = @"修改地址";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self
                                                                           action:@selector(leftButtonClicked)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonClicked)];
}

- (void)leftButtonClicked{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)rightButtonClicked{
    
}


@end
