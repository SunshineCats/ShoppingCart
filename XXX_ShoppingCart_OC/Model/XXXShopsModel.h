//
//  XXXShopsModel.h
//  XXX_ShoppingCart_OC
//
//  Created by PohlKepler on 5/6/19.
//  Copyright © 2019 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XXXGoodsModel.h"

NS_ASSUME_NONNULL_BEGIN
//店铺
@interface XXXShopsModel : NSObject
//店铺ID
@property (nonatomic,strong)NSString *shopID;
//店铺名字
@property (nonatomic,strong)NSString *shopName;

@property (nonatomic,strong)NSString *sid;
//店铺是否选中
@property (nonatomic,assign)BOOL isSelect;
//商品array
@property (nonatomic,strong)NSMutableArray *items;
//@property (nonatomic,strong)NSMutableArray *items;

+ (instancetype)modelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
