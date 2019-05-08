//
//  XXXShoppingCartsCell.m
//  XXX_ShoppingCart_OC
//
//  Created by PohlKepler on 4/29/19.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "XXXShoppingCartsCell.h"

@implementation XXXShoppingCartsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self loadUI];
    }
    return self;
}

- (void)loadUI{
    kWeakSelf
    UIView *whiteView = [[UIView alloc] init];
    whiteView.backgroundColor = [UIColor whiteColor];
    whiteView.userInteractionEnabled = YES;
    [self.contentView addSubview:whiteView];
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.mas_equalTo(0);
        make.bottom.mas_equalTo(weakSelf.contentView.mas_bottom).offset(0);
    }];

    _selectButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _selectButton.frame = CGRectMake(0, 0, 48, 48);
    [_selectButton setImage:[UIImage imageNamed:@"Unselected"] forState:(UIControlStateNormal)];
    [_selectButton setImage:[UIImage imageNamed:@"Selected"] forState:(UIControlStateSelected)];
    [_selectButton addTarget:self action:@selector(selectButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [whiteView addSubview:_selectButton];
    [_selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.height.width.offset(kCGRectH(36));
        make.centerY.equalTo(whiteView);
    }];
    
    _iconImgView = [[UIImageView alloc] init];
    _iconImgView.layer.cornerRadius = 10;
    _iconImgView.layer.masksToBounds = YES;
    [whiteView addSubview:_iconImgView];
    [_iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.selectButton.mas_right).offset(kCGRectX(8));
        make.centerY.equalTo(weakSelf.selectButton);
        make.height.offset(kCGRectH(100));
        make.width.offset(kCGRectW(150));
        make.bottom.equalTo(whiteView.mas_bottom).offset(kCGRectY(-10));
    }];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.textColor = [UIColor blackColor];
    _nameLabel.font = fontSize(16);
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    [whiteView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.iconImgView.mas_right).offset(kCGRectX(5));
        make.top.offset(kCGRectY(10));
        make.width.offset(kScreenW/3);
    }];
    
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.textColor = [UIColor redColor];
    _priceLabel.font = fontSize(18);
    _priceLabel.textAlignment = NSTextAlignmentRight;
    [whiteView addSubview:_priceLabel];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(kCGRectW(-10));
        make.top.offset(kCGRectY(10));
        make.height.offset(kCGRectH(20));
    }];

    _addButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    _addButton.tag = 100;
    [_addButton setImage:[UIImage imageNamed:@"product_detail_add_normal"] forState:(UIControlStateNormal)];
    [_addButton addTarget:self action:@selector(addAndCutCountButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [whiteView addSubview:_addButton];
    [_addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(kCGRectX(-20));
        make.bottom.equalTo(whiteView.mas_bottom).offset(kCGRectY(-10));
        make.width.height.offset(kCGRectW(30));
    }];

    _numberLabel = [[UILabel alloc] init];
    _numberLabel.font = fontSize(14);
    _numberLabel.textColor = [UIColor blackColor];
    _numberLabel.textAlignment = NSTextAlignmentCenter;
    _numberLabel.layer.borderColor = kRGBAColor(211, 211, 211, 1).CGColor;//边框颜色
    _numberLabel.layer.borderWidth = 1;//边框宽度
    [whiteView addSubview:_numberLabel];
    [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.addButton.mas_bottom).offset(kCGRectY(-1.5));
        make.top.equalTo(weakSelf.addButton.mas_top).offset(kCGRectY(1.5));
        make.right.equalTo(weakSelf.addButton.mas_left).offset(kCGRectX(1));
        make.width.offset(kCGRectW(60));
    }];

    _cutButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    _cutButton.tag = 101;
    [_cutButton setImage:[UIImage imageNamed:@"product_detail_sub_normal"] forState:(UIControlStateNormal)];
    [_cutButton addTarget:self action:@selector(addAndCutCountButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [whiteView addSubview:_cutButton];
    [_cutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.addButton.mas_bottom);
        make.right.equalTo(weakSelf.numberLabel.mas_left).offset(kCGRectX(1));
        make.width.height.offset(kCGRectH(30));
    }];
    
    _countLabel = [[UILabel alloc] init];
    _countLabel.font = fontSize(14);
    _countLabel.textColor = kRGBAColor(211, 211, 211, 1);
    _countLabel.textAlignment = NSTextAlignmentCenter;
    [whiteView addSubview:_countLabel];
    [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.iconImgView.mas_right).offset(kCGRectX(5));
        make.bottom.equalTo(whiteView.mas_bottom).offset(kCGRectY(-10));
        make.height.offset(kCGRectH(20));
    }];
}

//加减
- (void)addAndCutCountButton:(UIButton *)button{
    
    NSInteger count = [self.numberLabel.text integerValue];
    if (button.tag == 100) {//加
        if (count >= self.goodsModel.orginalPrice){
            [MBProgressHUD bwm_showTitle:@"哎呀，宝贝不能再增加了哦~" toView:kKeyWindow hideAfter:2];
        }else{
            self.numberLabel.text = kNSStringFormat(@"%ld", ++ count);
        }

    }else if (button.tag == 101){//减
        
        if (count <= 1) {
            [MBProgressHUD bwm_showTitle:@"受不了了，宝贝不能再减少了哦~" toView:kKeyWindow hideAfter:2];
        }else{
            self.numberLabel.text = kNSStringFormat(@"%ld", -- count);
        }
    }
    
    self.addAndCutButtonClickedBlock(self.goodsModel, count);

}


- (void)selectButtonClicked{
    self.selectButton.selected = !self.selectButton.selected;
    self.selectButtonClickedBlock(self.goodsModel, self.indexPath);
}





- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
