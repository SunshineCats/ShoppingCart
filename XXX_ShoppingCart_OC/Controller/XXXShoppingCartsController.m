//
//  XXXShoppingCartsController.m
//  XXX_ShoppingCart_OC
//
//  Created by PohlKepler on 4/29/19.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "XXXShoppingCartsController.h"
#import "XXXShoppingCartsCell.h"
#import "XXXBottomView.h"
#import "XXXHeaderView.h"
#import "XXXShopsModel.h"
#import "XXXGoodsModel.h"

@interface XXXShoppingCartsController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) XXXShoppingCartsCell *shoppingCartsCell;
@property (nonatomic,strong) XXXBottomView *bottomView;
@property (nonatomic,strong) XXXHeaderView *headerView;
//店铺array
@property (nonatomic,strong) NSMutableArray *shopsArray;

@end

@implementation XXXShoppingCartsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.bottomView.allSelectButton.selected = NO;
    [self shopsAndGoodsRequest];
}

//创建tableView
- (void)createTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH - kCGRectH(40)) style:(UITableViewStyleGrouped)];
    [self.tableView registerClass:[XXXShoppingCartsCell class] forCellReuseIdentifier:@"XXXShoppingCartsCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    [self.view addSubview:self.tableView];
}

//底部全选
- (void)createBottomView{
    self.bottomView = [[XXXBottomView alloc] initWithFrame:CGRectMake(0, kScreenH - kCGRectH(40), kScreenW, kCGRectH(40))];
    self.bottomView.allSelectLabel.text = kNSStringFormat(@"全选");
    self.bottomView.allLabel.text = kNSStringFormat(@"结算(0)");
    self.bottomView.moneyLabel.text = kNSStringFormat(@"￥%@",@(0));
    self.bottomView.combinedLabel.text = kNSStringFormat(@"合计：");
    self.bottomView.noFreightLabel.text = kNSStringFormat(@"不含运费");
    [self.bottomView.allSelectButton addTarget:self action:@selector(clickedAllButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.bottomView];
}

//数据解析
- (void)shopsAndGoodsRequest{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ShopCarSources" ofType:@"plist" inDirectory:nil];
    NSDictionary *dic = [[NSDictionary alloc]initWithContentsOfFile:path];
    for (NSMutableDictionary *dict in dic[@"data"]) {
        XXXShopsModel *shopsModel = [XXXShopsModel modelWithDict:dict];
        //开辟空间
        shopsModel.items = [NSMutableArray array];
        for (NSDictionary *goodsDic in dict[@"items"]) {
            XXXGoodsModel *goodsModel = [XXXGoodsModel modelWithDict:goodsDic];
            [shopsModel.items addObject:goodsModel];
        }
        [self.shopsArray addObject:shopsModel];
    }

    if (self.shopsArray) {
        [self createTableView];
        [self createBottomView];
    }

}


#pragma mark -- UITableView --
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    XXXShopsModel *shopsModel = self.shopsArray[section];
    return shopsModel.items.count;
//    return [[self.shopsArray[section] items] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.shopsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    XXXShoppingCartsCell *shoppingCartsCell = [[XXXShoppingCartsCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"XXXShoppingCartsCell"];
    self.shoppingCartsCell = shoppingCartsCell;
    [self configureCell:shoppingCartsCell indexPath:indexPath];
    return shoppingCartsCell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    kWeakSelf
    return [tableView fd_heightForCellWithIdentifier:@"XXXShoppingCartsCell" cacheByIndexPath:indexPath configuration:^(XXXShoppingCartsCell *cell) {
        [weakSelf configureCell:cell indexPath:indexPath];
    }];
}

- (void)configureCell:(XXXShoppingCartsCell *)shoppingCartsCell indexPath:(NSIndexPath *)indexPath{
    kWeakSelf
    //如果使用了Masonry，设置为NO
    shoppingCartsCell.fd_enforceFrameLayout = NO;
    XXXShopsModel *shopsModel = self.shopsArray[indexPath.section];
    XXXGoodsModel *goodsModel = shopsModel.items[indexPath.row];
    shoppingCartsCell.goodsModel = goodsModel;
    shoppingCartsCell.indexPath = indexPath;
    shoppingCartsCell.selectButton.selected = goodsModel.isSelected;
    shoppingCartsCell.nameLabel.text = kNSStringFormat(@"%@",goodsModel.goodsName);
    shoppingCartsCell.iconImgView.image = [UIImage imageNamed:goodsModel.goodsPic];
    shoppingCartsCell.priceLabel.text = kNSStringFormat(@"￥%@",goodsModel.realPrice);
    shoppingCartsCell.numberLabel.text = kNSStringFormat(@"%ld",goodsModel.count);
    shoppingCartsCell.countLabel.text = kNSStringFormat(@"数量:%ld",goodsModel.orginalPrice);
    shoppingCartsCell.selectButtonClickedBlock = ^(XXXGoodsModel * _Nonnull goodsModel, NSIndexPath * _Nonnull cellIndexPath) {
        goodsModel.isSelected = !goodsModel.isSelected;
        [weakSelf.tableView reloadData];
        [weakSelf updateSelectCount];
        [weakSelf updateTotalMoney];
        
    };
    shoppingCartsCell.addAndCutButtonClickedBlock = ^(XXXGoodsModel * _Nonnull goodsModel, NSInteger count) {
        goodsModel.count =  count;
        [weakSelf updateSelectCount];
        [weakSelf updateTotalMoney];
    };
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    kWeakSelf
    XXXShopsModel *shopsModel = self.shopsArray[section];
    XXXHeaderView *headerView = [[XXXHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kCGRectH(40))];
    self.headerView = headerView;
    headerView.section = section;
    headerView.shopsModel = shopsModel;
    headerView.nameLabel.text = shopsModel.shopName;
    headerView.storeSelectButtonClickedBlock = ^(XXXShopsModel * _Nonnull shopsModel, NSInteger section, BOOL isSectionSelected) {
        for (XXXGoodsModel *goodsModel in shopsModel.items) {
            goodsModel.isSelected = isSectionSelected;
        }
        [weakSelf.tableView reloadData];
    };
    BOOL isSelected = YES;
    for (XXXGoodsModel *goodsModel in shopsModel.items){
        if (goodsModel.isSelected == NO){
            isSelected = NO;
            break;
        }
    }
    headerView.storeSelectButton.selected = isSelected;
    
    [self updateAllSelectButtonState];
    [self updateSelectCount];
    [self updateTotalMoney];
    return headerView;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kCGRectH(40);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //删除数据
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        XXXShopsModel *shopsModel = self.shopsArray[indexPath.section];
        [shopsModel.items removeObjectAtIndex:indexPath.row];
        //删除
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        if (shopsModel.items.count == 0) {
            [self.shopsArray removeObjectAtIndex:indexPath.section];
            [self.tableView reloadData];
        }
        
        [self updateHeaderSectionButtonState];
        [self updateAllSelectButtonState];
        [self updateSelectCount];
        [self updateTotalMoney];
        [self.tableView reloadData];

    }
}

#pragma mark -- 懒加载 --
- (NSMutableArray *)shopsArray{
    if (!_shopsArray) {
        _shopsArray = [[NSMutableArray alloc] init];
    }
    return _shopsArray;
}

#pragma mark -- Action --
//底部全选
- (void)clickedAllButton:(UIButton *)button{
    button.selected = !button.selected;
    for (XXXShopsModel *shopsModel in self.shopsArray) {
        for (XXXGoodsModel *goodsModel in shopsModel.items) {
            goodsModel.isSelected = button.selected;
            [self.tableView reloadData];
        }
    }
    [self updateAllSelectButtonState];
}

//更新全选按钮选中状态
- (void)updateAllSelectButtonState{
    BOOL isSelected = YES;
    for (XXXShopsModel *shopsModel in self.shopsArray){
        for (XXXGoodsModel *goodsModel in shopsModel.items){
            if (goodsModel.isSelected == NO){
                isSelected = NO;
                break;
            }
        }
    }
    self.bottomView.allSelectButton.selected = isSelected;
}

//更新headerSection 选中状态
- (void)updateHeaderSectionButtonState{
    BOOL isSelected = YES;
    for (XXXShopsModel *shopsModel in self.shopsArray) {
        for (XXXGoodsModel *goodsModel in shopsModel.items){
            if (goodsModel.isSelected == NO){
                isSelected = NO;
                break;
            }
        }
    }
    
    self.headerView.storeSelectButton.selected = isSelected;
}

//更新底部商品个数
- (void)updateSelectCount{
    NSInteger total = 0;
    for (XXXShopsModel *shopsModel in self.shopsArray) {
        for (XXXGoodsModel *goodsModel in shopsModel.items) {
            if (goodsModel.isSelected) {
                total += goodsModel.count;
            }
        }
    }
    self.bottomView.allLabel.text = kNSStringFormat(@"结算(%ld)",total);

}

//更新总价格
- (void)updateTotalMoney{
    NSInteger total = 0;
    for (XXXShopsModel *shopsModel in self.shopsArray) {
        for (XXXGoodsModel *goodsModel in shopsModel.items) {
            if (goodsModel.isSelected) {
                total += goodsModel.count * [goodsModel.realPrice floatValue];
            }
        }
    }
    self.bottomView.moneyLabel.text = kNSStringFormat(@"￥%ld",total);

}



@end
