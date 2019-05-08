//
//  XXXShoppingCartsCell.h
//  XXX_ShoppingCart_OC
//
//  Created by PohlKepler on 4/29/19.
//  Copyright © 2019 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XXXGoodsModel.h"
NS_ASSUME_NONNULL_BEGIN


@interface XXXShoppingCartsCell : UITableViewCell

//选择
@property (nonatomic,strong) UIButton *selectButton;
//商品图
@property (nonatomic,strong) UIImageView *iconImgView;
//商品名称
@property (nonatomic,strong) UILabel *nameLabel;
//商品价格
@property (nonatomic,strong) UILabel *priceLabel;
//加
@property (nonatomic,strong) UIButton *addButton;
//添加商品个数
@property (nonatomic,strong) UILabel *numberLabel;
//减
@property (nonatomic,strong) UIButton *cutButton;
//数量
@property (nonatomic,strong) UILabel *countLabel;

@property (nonatomic,strong) NSIndexPath *indexPath;
@property (nonatomic,strong) XXXGoodsModel *goodsModel;

@property (nonatomic,strong)void(^addAndCutButtonClickedBlock)(XXXGoodsModel *goodsModel,NSInteger count);
@property (nonatomic,strong)void(^selectButtonClickedBlock)(XXXGoodsModel *goodsModel,NSIndexPath *cellIndexPath);
@end

NS_ASSUME_NONNULL_END
