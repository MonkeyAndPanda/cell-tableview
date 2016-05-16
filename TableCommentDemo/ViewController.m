//
//  ViewController.m
//  TableCommentDemo
//
//  Created by 曹小猿 on 16/4/22.
//  Copyright © 2016年 曹小猿. All rights reserved.
//

#import "ViewController.h"
#import "DetailCell.h"
#import "DetailModel.h"
#import "CommentModel.h"

@interface ViewController (){

  NSMutableArray *tableData;
  CGPoint        contentoffset;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self initData];
  [self initControl];
  
}
-(void)initData{

  tableData = [NSMutableArray array];
  for (int i=0; i<10; i++) {
    DetailModel * model = [[DetailModel alloc]init];
    NSMutableString *moreMesage = [NSMutableString string];
    for (int k=0; k<i+1; k++) {
      [moreMesage appendString:[NSString stringWithFormat:@"今天天气真的特别好，处处都有好风光%d",i]];
    }
    model.message = moreMesage;
    model.name = [NSString stringWithFormat:@"测试者%d",i];
    model.commentArray = [NSMutableArray array];
    for (int j=0; j<i+2; j++) {
      CommentModel * cmodel = [[CommentModel alloc]init];
      cmodel.asker = [NSString stringWithFormat:@"发问者%d",j];
      cmodel.answer = [NSString stringWithFormat:@"回答者%d",j];
      
      NSMutableString *moreComment = [NSMutableString string];
      for (int h=0; h<j+1; h++) {
        [moreComment appendString:[NSString stringWithFormat:@"这是我对你的回答%d",j]];
      }
      cmodel.message = moreComment;

      [model.commentArray addObject:cmodel];
    }
    
    [tableData addObject:model];
  }
  
}

-(void)initControl{
  
  
}

#pragma mark - TableView data source
//两个tableview嵌套，父table放所有信息，子table放评论列表
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return tableData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
 //在model中建个height参数存储高度
  DetailModel *model = [tableData objectAtIndex:[indexPath row]];
  if (model.height==0) {
    return [DetailCell cellHeight];
  }else{
    return model.height;
  }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DetailCell *cell = (DetailCell *) [tableView dequeueReusableCellWithIdentifier:@"DetailCell"];
    if (!cell) {
      cell = [[[NSBundle mainBundle] loadNibNamed:@"DetailCell" owner:nil options:nil] lastObject];
    }
    cell.index =[indexPath row];
    cell.cellData = [tableData objectAtIndex:[indexPath row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.sendBlock = ^(NSInteger index){
  
      [self addComment:index];
    };
    return cell;

}
-(void)addComment:(NSInteger)index{

  DetailModel * detailModel = [tableData objectAtIndex:index];
  //height为0时高度更新
  detailModel.height = 0.0;
  CommentModel * commentModel = [[CommentModel alloc]init];
  commentModel.message = @"这是新增的评论";
  [detailModel.commentArray addObject:commentModel];
  [self.tableView reloadData];
  
//  NSIndexPath * indexpath = [NSIndexPath indexPathForRow:index inSection:0];
//  [self.tableView reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationFade];
  
  //评论后cell滚动居中

//  [self didCommentScrollToMiddle:indexpath];

}
//评论后cell滚动居中
-(void)didCommentScrollToMiddle:(NSIndexPath *)indexpath{
  
  //获取当前cell在tableview中的位置
  
  CGRect rectintableview=[self.tableView rectForRowAtIndexPath:indexpath];
  
  //获取当前cell在屏幕中的位置
  
  CGRect rectinsuperview=[self.tableView convertRect:rectintableview fromView:[self.tableView superview]];
  
  contentoffset.x=self.tableView.contentOffset.x;
  
  contentoffset.y=self.tableView.contentOffset.y;
  
  if ((rectintableview.origin.y+50-self.tableView.contentOffset.y)>200) {
    
    [self.tableView setContentOffset:CGPointMake(self.tableView.contentOffset.x,((rectintableview.origin.y-self.tableView.contentOffset.y)-150)+self.tableView.contentOffset.y) animated:NO];
    
  }

}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
