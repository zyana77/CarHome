//
//  TechnologyTableViewCell.m
//  项目A_汽车之家
//
//  Created by zyana on 15/11/18.
//  Copyright © 2015年 zyana. All rights reserved.
//

#import "TechnologyTableViewCell.h"

@interface TechnologyTableViewCell ()

@property (strong, nonatomic) IBOutlet UIImageView *imgView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *replyLabel;


@end

@implementation TechnologyTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTechnology:(Technology *)technology{
    _technology = technology;
    _titleLabel.text = technology.title;
    _timeLabel.text = technology.time;
    _replyLabel.text = [NSString stringWithFormat:@"%ld评论", technology.replycount];
    [_imgView sd_setImageWithURL:[NSURL URLWithString:technology.smallpic] placeholderImage:[UIImage imageNamed:@"3"]];
}


@end
