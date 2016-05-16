//
//  DetailCell.h
//  TableCommentDemo
//
//  Created by 曹小猿 on 16/4/22.
//  Copyright © 2016年 曹小猿. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailModel.h"
@interface DetailCell : UITableViewCell
@property(nonatomic ,strong)DetailModel *cellData;
@property(nonatomic ,assign)NSInteger index;
@property (nonatomic, copy) void (^sendBlock)(NSInteger index);

+ (CGFloat)cellHeight;
@end
