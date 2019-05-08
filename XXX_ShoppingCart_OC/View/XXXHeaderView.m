//
//  XXXHeaderView.m
//  XXX_ShoppingCart_OC
//
//  Created by PohlKepler on 5/5/19.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "XXXHeaderView.h"

@implementation XXXHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self loadUI];
    }
    return self;
}

- (void)loadUI{
    UIView *whiteView = [[UIView alloc] init];
    whiteView.backgroundColor = kRGBAColor(245, 246, 248, 1);
    [self addSubview:whiteView];
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.offset(0);
    }];
    
    _storeSelectButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_storeSelectButton setImage:[UIImage imageNamed:@"Unselected"] forState:(UIControlStateNormal)];
    [_storeSelectButton setImage:[UIImage imageNamed:@"Selected"] forState:(UIControlStateSelected)];
    [_storeSelectButton addTarget:self action:@selector(clickedStoreButton) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:_storeSelectButton];
    [_storeSelectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.centerY.equalTo(whiteView);
        make.width.height.offset(kCGRectW(30));
    }];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = fontSize(15);
    _nameLabel.textColor = [UIColor blackColor];
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.storeSelectButton.mas_right).offset(kCGRectX(10));
        make.height.offset(kCGRectH(30));
        make.centerY.equalTo(whiteView);
    }];
}

- (void)clickedStoreButton{
    self.storeSelectButton.selected = !self.storeSelectButton.selected;
    self.storeSelectButtonClickedBlock(self.shopsModel, self.section, self.storeSelectButton.selected);
}


@end
