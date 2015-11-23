//
//  VideoTableViewCell.m
//  项目A_汽车之家
//
//  Created by zyana on 15/11/18.
//  Copyright © 2015年 zyana. All rights reserved.
//

#import "VideoTableViewCell.h"

@interface VideoTableViewCell ()

@property (strong, nonatomic) IBOutlet UIImageView *imgView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *replyLabel;


@end

@implementation VideoTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setVideoModel:(VideoModel *)videoModel{
    _videoModel = videoModel;
    _titleLabel.text = videoModel.title;
    _timeLabel.text = videoModel.time;
    _replyLabel.text = [NSString stringWithFormat:@"%ld评论", videoModel.replycount];
    [_imgView sd_setImageWithURL:[NSURL URLWithString:videoModel.smallimg] placeholderImage:[UIImage imageNamed:@"3"]];
}

@end
