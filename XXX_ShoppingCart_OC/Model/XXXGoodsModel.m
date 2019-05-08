//
//  XXXGoodsModel.m
//  XXX_ShoppingCart_OC
//
//  Created by PohlKepler on 5/6/19.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "XXXGoodsModel.h"

@implementation XXXGoodsModel

+ (instancetype)modelWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict{
    return [XXXGoodsModel mj_objectWithKeyValues:dict];
}
@end
