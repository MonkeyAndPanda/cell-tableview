//
//  CommentCell.m
//  TableCommentDemo
//
//  Created by 曹小猿 on 16/4/22.
//  Copyright © 2016年 曹小猿. All rights reserved.
//
#define ScreenWidth        [UIScreen mainScreen].bounds.size.width

#import "CommentCell.h"

@interface CommentCell()
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@end
static CGFloat cellHeight = 0;

@implementation CommentCell

- (void)awakeFromNib {
    // Initialization code
  [self initControl];
}
+ (CGFloat)cellHeight {
  return cellHeight;
}
-(void)initControl{
  _commentLabel.preferredMaxLayoutWidth = ScreenWidth-20;
  
}

-(void)setCellData:(DetailModel *)cellData{

  _cellData = cellData;
  _commentLabel.text = cellData.message;

//用autolayout算高
//  CGFloat layoutCellHeight = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
//  cellHeight = layoutCellHeight;
//用内容算高
  cellHeight = [self heightForString:cellData.message fontSize:15 andWidth:ScreenWidth-20]+4;
  
}

- (float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width{
  CGSize sizeToFit = [value sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];
  return sizeToFit.height;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
