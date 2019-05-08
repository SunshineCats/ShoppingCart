//
//  XXXGoodsModel.h
//  XXX_ShoppingCart_OC
//
//  Created by PohlKepler on 5/6/19.
//  Copyright © 2019 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
//商品
@interface XXXGoodsModel : NSObject
//商品ID
@property (nonatomic,strong) NSString *goodsId;
//商品名字
@property (nonatomic,strong) NSString *goodsName;
//商品价格
@property (nonatomic,strong) NSString *realPrice;
//商品图片
@property (nonatomic,strong) NSString *goodsPic;
//商品数量
@property (nonatomic,assign) NSInteger count;
//商品是否选中
@property (nonatomic,assign) BOOL isSelected;
//商品总量
@property (nonatomic,assign) NSInteger orginalPrice;

+ (instancetype)modelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
