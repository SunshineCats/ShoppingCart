//
//  XXXShopsModel.m
//  XXX_ShoppingCart_OC
//
//  Created by PohlKepler on 5/6/19.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "XXXShopsModel.h"

@implementation XXXShopsModel

+ (instancetype)modelWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

//字典转模型，使用的是mj_objectWithKeyValues:方法
- (instancetype)initWithDict:(NSDictionary *)dict{
    [XXXShopsModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"shopID":@"id"};
    }];
    return [XXXShopsModel mj_objectWithKeyValues:dict];
}

@end
