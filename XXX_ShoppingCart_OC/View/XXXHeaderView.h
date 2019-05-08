//
//  XXXHeaderView.h
//  XXX_ShoppingCart_OC
//
//  Created by PohlKepler on 5/5/19.
//  Copyright © 2019 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XXXShopsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XXXHeaderView : UIView

//店铺选项
@property (nonatomic,strong) UIButton *storeSelectButton;
//店铺名字
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,assign) NSInteger section;
@property (nonatomic,strong) XXXShopsModel *shopsModel;
@property (nonatomic,strong) void(^storeSelectButtonClickedBlock)(XXXShopsModel *shopsModel,NSInteger section,BOOL isSectionSelected);
@end

NS_ASSUME_NONNULL_END
