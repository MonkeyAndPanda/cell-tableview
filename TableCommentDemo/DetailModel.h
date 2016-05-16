//
//  DetailModel.h
//  TableCommentDemo
//
//  Created by 曹小猿 on 16/4/22.
//  Copyright © 2016年 曹小猿. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailModel : NSObject
@property(nonatomic ,strong)NSString * name;
@property(nonatomic ,strong)NSString * message;
@property(nonatomic ,strong)NSMutableArray *commentArray;
@property(nonatomic ,assign)float height;

@end
