//
//  ExerciseViewController.m
//  MakeThings
//
//  Created by Jing Ye on 13/12/2017.
//  Copyright © 2017 aiwen. All rights reserved.
//

#import "ExerciseViewController.h"
#import "NavigationBarTitlesView.h"
#import "MTBannerView.h"
#import "ExerciseDetailCell.h"
#import "ExerciseDetailModel.h"

static NSString *kExerciseDetailCellID = @"ExerciseDetailCell";

@interface ExerciseViewController ()<NavigationBarTitlesViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *bannerContainerView;
@property (nonatomic)NavigationBarTitlesView *navigationBarTitleView;
@property (nonatomic) MTBannerView *bannerView;

@property (nonatomic) NSArray *dataArray;
@end

@implementation ExerciseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavi];
    [self setupUI];
    self.view.backgroundColor = [UIColor whiteColor];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setupNavi{
    _navigationBarTitleView = [[NavigationBarTitlesView alloc]initWithFrame:CGRectZero titlesArray:@[@"精选",@"热门"]];
    _navigationBarTitleView.delegate = self;
    self.navigationItem.titleView = _navigationBarTitleView;

}
- (void)setupUI{
    
    [self.view addSubview:self.bannerView];
    self.navigationItem.hidesBackButton = YES;
}

#pragma mark - getter
-(NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSArray array];
        // fake data
        NSMutableArray *tempArray = [NSMutableArray array];
        for (int i = 0; i < 5; i++) {
        ExerciseDetailModel *detailModel = [[ExerciseDetailModel alloc]init];
            detailModel.imageUrl = @"https://image.baidu.com/search/detail?ct=503316480&z=0&ipn=false&word=iu&step_word=&hs=2&pn=21&spn=0&di=34983208370&pi=0&rn=1&tn=baiduimagedetail&is=0%2C0&istype=0&ie=utf-8&oe=utf-8&in=&cl=2&lm=-1&st=undefined&cs=1630097167%2C3222957648&os=1645297879%2C2543224498&simid=4281672924%2C952977593&adpicid=0&lpn=0&ln=3984&fr=&fmq=1515406850064_R&fm=&ic=undefined&s=undefined&se=&sme=&tab=0&width=undefined&height=undefined&face=undefined&ist=&jit=&cg=star&bdtype=0&oriquery=&objurl=http%3A%2F%2Fi0.hdslb.com%2Fbfs%2Farchive%2Fa5f0dd457cf9cfdeb89754d4f2cd9a8c9d35b5d8.jpg&fromurl=ippr_z2C%24qAzdH3FAzdH3Fooo_z%26e3Bktstktst_z%26e3Bv54AzdH3Fet1j5AzdH3Fwe0n8an9lAzdH3F&gsm=0&rpstart=0&rpnum=0";
            detailModel.title = @"今天健身次什么？？";
            detailModel.userName = @"小可";
            detailModel.commentAmount = @"2313";
            detailModel.readAmount = @"3868";
            [tempArray addObject:detailModel];
        }
        _dataArray = [NSArray arrayWithArray:tempArray];
    }
    return _dataArray;
}

- (MTBannerView *)bannerView {
    if (!_bannerView) {
        _bannerView = [[MTBannerView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 187) images:
                       nil];
        [_bannerView reloadBannerWithData:@[@"https://image.baidu.com/search/detail?ct=503316480&z=0&ipn=false&word=iu&step_word=&hs=2&pn=21&spn=0&di=34983208370&pi=0&rn=1&tn=baiduimagedetail&is=0%2C0&istype=0&ie=utf-8&oe=utf-8&in=&cl=2&lm=-1&st=undefined&cs=1630097167%2C3222957648&os=1645297879%2C2543224498&simid=4281672924%2C952977593&adpicid=0&lpn=0&ln=3984&fr=&fmq=1515406850064_R&fm=&ic=undefined&s=undefined&se=&sme=&tab=0&width=undefined&height=undefined&face=undefined&ist=&jit=&cg=star&bdtype=0&oriquery=&objurl=http%3A%2F%2Fi0.hdslb.com%2Fbfs%2Farchive%2Fa5f0dd457cf9cfdeb89754d4f2cd9a8c9d35b5d8.jpg&fromurl=ippr_z2C%24qAzdH3FAzdH3Fooo_z%26e3Bktstktst_z%26e3Bv54AzdH3Fet1j5AzdH3Fwe0n8an9lAzdH3F&gsm=0&rpstart=0&rpnum=0",@"https://image.baidu.com/search/detail?ct=503316480&z=0&ipn=false&word=iu&step_word=&hs=2&pn=29&spn=0&di=34983208370&pi=0&rn=1&tn=baiduimagedetail&is=0%2C0&istype=0&ie=utf-8&oe=utf-8&in=&cl=2&lm=-1&st=undefined&cs=1630097167%2C3222957648&os=1645297879%2C2543224498&simid=4281672924%2C952977593&adpicid=0&lpn=0&ln=3984&fr=&fmq=1515406850064_R&fm=&ic=undefined&s=undefined&se=&sme=&tab=0&width=undefined&height=undefined&face=undefined&ist=&jit=&cg=star&oriquery=&objurl=http%3A%2F%2Fi0.hdslb.com%2Fbfs%2Farchive%2Fa5f0dd457cf9cfdeb89754d4f2cd9a8c9d35b5d8.jpg&gsm=3c&rpstart=0&rpnum=0",@"https://image.baidu.com/search/detail?ct=503316480&z=0&ipn=false&word=iu&step_word=&hs=2&pn=28&spn=0&di=5452948050&pi=0&rn=1&tn=baiduimagedetail&is=0%2C0&istype=0&ie=utf-8&oe=utf-8&in=&cl=2&lm=-1&st=undefined&cs=3673833274%2C1112455152&os=1673613466%2C378105057&simid=4085770028%2C379502779&adpicid=0&lpn=0&ln=3984&fr=&fmq=1515406850064_R&fm=&ic=undefined&s=undefined&se=&sme=&tab=0&width=undefined&height=undefined&face=undefined&ist=&jit=&cg=star&bdtype=0&oriquery=&objurl=http%3A%2F%2Fimg3.duitang.com%2Fuploads%2Fitem%2F201509%2F23%2F20150923102325_fJETn.thumb.700_0.png&fromurl=ippr_z2C%24qAzdH3FAzdH3Fooo_z%26e3B17tpwg2_z%26e3Bv54AzdH3Fks52AzdH3F%3Ft1%3Dcndma990m&gsm=0&rpstart=0&rpnum=0"]];
        _bannerView.backgroundColor = [UIColor redColor];
    }
    return _bannerView;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ExerciseDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:kExerciseDetailCellID forIndexPath:indexPath];
    ExerciseDetailModel *model = self.dataArray[indexPath.row];
    [cell updateExerciseDetailCellWithModel:model];
    return cell;
}
#pragma mark - NavigationBarTitlesViewDelegate

- (void)selectedItemAtIndex:(NSInteger)index {
    
}

@end
