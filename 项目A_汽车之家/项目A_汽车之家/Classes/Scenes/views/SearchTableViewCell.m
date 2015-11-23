//
//  SearchTableViewCell.m
//  项目A_汽车之家
//
//  Created by zyana on 15/11/23.
//  Copyright © 2015年 zyana. All rights reserved.
//

#import "SearchTableViewCell.h"

@implementation SearchTableViewCell

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setBrandModel:(BrandModel *)brandModel{
    _brandModel = brandModel;
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 80, 50)];
    [imgView sd_setImageWithURL:[NSURL URLWithString:brandModel.imgurl]];
    [self addSubview:imgView];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 10, 175, 21.5)];
    nameLabel.text = brandModel.name;
    nameLabel.font = [UIFont systemFontOfSize:18];
    [self addSubview:nameLabel];
    
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 45, 175, 18)];
    priceLabel.text = brandModel.price;
    priceLabel.font = [UIFont systemFontOfSize:14];
    priceLabel.textColor = [UIColor redColor];
    [self addSubview:priceLabel];
}

@end
