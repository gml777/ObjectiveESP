//
//  HFLTableViewCell.m
//  ESP3
//
//  Created by 陈浩 on 17/1/13.
//  Copyright © 2017年 Nonvia. All rights reserved.
//

#import "HFLTableViewCell.h"
#import "HighFrequencyList.h"
@interface   HFLTableViewCell()<UITableViewDelegate>


@end
@implementation HFLTableViewCell

-(void)setList:(HighFrequencyList *)list
{
/*    _list = list;
    _mingzi.text=list.names;
    _ipdizhi.text=list.ips;
 //   NSLog(@"");
    switch (list.type) {
        case HFLStatesCommunicationInterrupted:
            _zhuangtai.image=[UIImage imageNamed:@"灰色图标-停运"];
            break;
        case HFLStatesRun:
            _zhuangtai.image=[UIImage imageNamed:@"运行-图标"];
            break;
        case HFLStatesStop:
            _zhuangtai.image=[UIImage imageNamed:@"绿色图标"];
            break;
        case HFLStatesFaultAlarm:
            _zhuangtai.image=[UIImage imageNamed:@"告警图标"];
        default:
            break;
    }*/
}




/*- (void)awakeFromNib {
  //  [self addGestureRecognizer: [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longTap:)]];
}*/

-(void)longTap:(UILongPressGestureRecognizer *)longRecognizer
{
    if (longRecognizer.state==UIGestureRecognizerStateBegan) {
        
        [self becomeFirstResponder];
      //  UIView *touchPoint = longPressGestureRecognizer.locationInView(self);
      //  if NSIndexPath indexPath = yourTableView.indexPathForRowAtPoint(touchPoint) {
            // your code here, get the row for the indexPath or do whatever you want
      //  }
        UIMenuItem *copyItem = [[UIMenuItem alloc] initWithTitle:@"修改" action:@selector(copyItemClicked:)];
        
        
        UIMenuItem *resendItem = [[UIMenuItem alloc] initWithTitle:@"增加" action:@selector(insertItemClicked:)];
        
        UIMenuItem *resendItem1 = [[UIMenuItem alloc] initWithTitle:@"查看" action:@selector(resendItemClicked:)];
        
     //   UIMenuItem *resendItem2 = [[UIMenuItem alloc] initWithTitle:@"收藏多条" action:@selector(resendItemClicked:)];
        
        UIMenuItem *resendItem3 = [[UIMenuItem alloc] initWithTitle:@"删除" action:@selector(deleteItemClicked:)];
        
        UIMenuController *menu=[UIMenuController sharedMenuController];
        
        [menu setMenuItems:[NSArray arrayWithObjects:copyItem,resendItem,resendItem1,resendItem3,nil]];
        
        [menu setTargetRect:self.bounds inView:self];
        
        [menu setMenuVisible:YES animated:YES];
    }
}
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    
    if(action ==@selector(copyItemClicked:)){
        return YES;
        
    }else if (action==@selector(resendItemClicked:)){
        
        return YES;
    }else if (action==@selector(insertItemClicked:)){
            
        return YES;
    }else if (action==@selector(deleteItemClicked:)){
                
        return YES;
    }
    return [super canPerformAction:action withSender:sender];
}
-(void)resendItemClicked:(id)sender{
   NSLog(@"自定义cell查看%@",sender);
    
}
-(void)insertItemClicked:(id)sender{
    NSLog(@"自定义cell增加%@",sender);
}
-(void)deleteItemClicked:(id)sender{
    NSLog(@"自定义cell删除%@",sender);
}
-(void)copyItemClicked:(UIMenuItem *)sender{
    NSLog(@"自定义cell修改%@",sender);
  //  UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
 //   pasteboard.string = @"hongwei";
}

-(BOOL)canBecomeFirstResponder{
    return YES;
}


/*
- (void)cellLongPress:(UIGestureRecognizer *)gestureRecognizer
{
    //  NSLog(@"gml");
    //  if (recognizer.state == UIGestureRecognizerStateBegan) {
    
 
     CGPoint location = [recognizer locationInView:self];
     NSIndexPath * indexPath = [self indexPathForRowAtPoint:location];
     UIMyTableViewCell *cell = (UIMyTableViewCell *)recognizer.view;
     　　　　　//这里把cell做为第一响应(cell默认是无法成为responder,需要重写canBecomeFirstResponder方法)
     [cell becomeFirstResponder];
     
     UIMenuItem *itCopy = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(handleCopyCell:)];
     UIMenuItem *itDelete = [[UIMenuItem alloc] initWithTitle:@"删除" action:@selector(handleDeleteCell:)];
     UIMenuController *menu = [UIMenuController sharedMenuController];
     [menu setMenuItems:[NSArray arrayWithObjects:itCopy, itDelete,  nil]];
     [menu setTargetRect:cell.frame inView:self];
     [menu setMenuVisible:YES animated:YES];
     
     
     */
    //   [itCopy release];
    //   [itDelete release];
    //  NSLog(@"wwwwwfffffff");
/*
    CGPoint point = [gestureRecognizer locationInView:self.tableView];
    if(gestureRecognizer.state == UIGestureRecognizerStateBegan)
        
    {
        NSLog(@"ssseeeeee");
        NSIndexPath *index=[self.tableView indexPathForRowAtPoint:point];
        //   NSLog(@"%ld",index.row);
        HFLTableViewCell *cell = (HFLTableViewCell *)gestureRecognizer.view;
        //这里把cell做为第一响应(cell默认是无法成为responder,需要重写canBecomeFirstResponder方法)
        [cell becomeFirstResponder];
        
        UIMenuItem *itCopy = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(handleCopyCell:)];
        UIMenuItem *itDelete = [[UIMenuItem alloc] initWithTitle:@"删除" action:@selector(handleDeleteCell:)];
        UIMenuItem *itSelect = [[UIMenuItem alloc]initWithTitle:@"查看" action:@selector(HandleSelectCell:)];
        UIMenuItem *itUpdate = [[UIMenuItem alloc]initWithTitle:@"修改" action:@selector(handleUpdateCell:)];
        UIMenuController *menu = [UIMenuController sharedMenuController];
        [menu setMenuItems:[NSArray arrayWithObjects:itCopy, itDelete,itSelect,itUpdate, nil]];
        [menu setTargetRect:cell.frame inView:self.tableView];
        [menu setMenuVisible:YES animated:YES];
        //  NSLog(@"ooooo");
    }
    
    else if(gestureRecognizer.state == UIGestureRecognizerStateEnded)
        
    {
        NSLog(@"mimimimimimi");
    }
    
    else if(gestureRecognizer.state == UIGestureRecognizerStateChanged)
        
    {
        NSLog(@"lostllllllll");
        
    }
    
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:point];
    
    if (indexPath == nil)
    {
        NSLog(@"sadfasdfasdf");
    }
    else
    {
        
        //focusRow = [indexPath row];
        
        //focusView.hidden = NO;
        
    }
    // }
}
- (void)handleCopyCell:(id)sender{//复制cell
    NSLog(@"handle copy cell");
    // NSLog(@"%ld",sender.indexPath.row);
}

- (void)handleDeleteCell:(id)sender{//删除cell
    NSLog(@"handle delete cell");
}
- (void)HandleSelectCell:(id)sender{//删除cell
    NSLog(@"handle select cell");
}
- (void)handleUpdateCell:(id)sender{//删除cell
    NSLog(@"handle update cell");
}
//3.在自定义的cell里重写canBecomeFirstResponder方法，返回yes
//为了让菜单显示，目标视图必须在responder链中，很多UIKit视图默认并无法成为一个responder，因此你需要使这些视图重载 canBecomeFirstResponder方法，并返回YES
- (BOOL)canBecomeFirstResponder{
    return YES;
}
*/


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectedBackgroundView.backgroundColor=XMGColor(216, 240, 250);
}
-(void)layoutSubviews
{
    [super layoutSubviews];
  //  self.ipdizhi.frame.origin.x=[UIScreen mainScreen].bounds.size.width / 2.0 - self.ipdizhi.frame.size.width / 2.0 + 12;
}
@end
