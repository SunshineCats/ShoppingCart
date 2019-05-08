//
//  XXXBottomView.h
//  XXX_ShoppingCart_OC
//
//  Created by PohlKepler on 4/29/19.
//  Copyright © 2019 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XXXBottomView : UIView

//全选select
@property (nonatomic,strong) UIButton *allSelectButton;
@property (nonatomic,strong) UILabel *allSelectLabel;

//结算
@property (nonatomic,strong) UILabel *allLabel;
//金额
@property (nonatomic,strong) UILabel *moneyLabel;
//合计
@property (nonatomic,strong) UILabel *combinedLabel;
//不含运费
@property (nonatomic,strong) UILabel *noFreightLabel;

@end

NS_ASSUME_NONNULL_END
