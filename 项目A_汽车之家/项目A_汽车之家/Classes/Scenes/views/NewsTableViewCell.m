//
//  NewsTableViewCell.m
//  项目A_汽车之家
//
//  Created by zyana on 15/11/17.
//  Copyright © 2015年 zyana. All rights reserved.
//

#import "NewsTableViewCell.h"

@interface NewsTableViewCell()

@property (strong, nonatomic) IBOutlet UIImageView *imgView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *replyLabel;


@end

@implementation NewsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setNews:(News *)news{
    _news = news;
    _titleLabel.text = news.title;
    _timeLabel.text = news.time;
    _replyLabel.text = [NSString stringWithFormat:@"%ld评论", (long)news.replycount];
    [_imgView sd_setImageWithURL:[NSURL URLWithString:news.smallpic] placeholderImage:[UIImage imageNamed:@"3"]];
}

@end
