//
//  RecommendedTableViewCell.m
//  项目A_汽车之家
//
//  Created by zyana on 15/11/16.
//  Copyright © 2015年 zyana. All rights reserved.
//

#import "RecommendedTableViewCell.h"
@interface RecommendedTableViewCell ()
@property (strong, nonatomic) IBOutlet UIImageView *imgView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *replycountLabel;


@end

@implementation RecommendedTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setInformation:(CultureModel *)information{
    _information = information;
    _titleLabel.text = information.title;
    _timeLabel.text = information.time;
    _replycountLabel.text = [NSString stringWithFormat:@"%ld评论", (long)information.replycount] ;
    [_imgView sd_setImageWithURL:[NSURL URLWithString:information.smallpic] placeholderImage:[UIImage imageNamed:@"3"]];
    
}

@end
