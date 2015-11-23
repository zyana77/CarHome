//
//  EvaluateTableViewCell.m
//  项目A_汽车之家
//
//  Created by zyana on 15/11/17.
//  Copyright © 2015年 zyana. All rights reserved.
//

#import "EvaluateTableViewCell.h"

@interface EvaluateTableViewCell()

@property (strong, nonatomic) IBOutlet UIImageView *imgView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *replyLabel;


@end

@implementation EvaluateTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setEvaluate:(Evaluate *)evaluate{
    _evaluate = evaluate;
    _titleLabel.text = evaluate.title;
    _timeLabel.text = evaluate.time;
    _replyLabel.text = [NSString stringWithFormat:@"%ld评论", evaluate.replycount];
    [_imgView sd_setImageWithURL:[NSURL URLWithString:evaluate.smallpic] placeholderImage:[UIImage imageNamed:@"3"]];
}

@end
