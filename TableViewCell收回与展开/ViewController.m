//
//  ViewController.m
//  TableViewCell收回与展开
//
//  Created by Honzon on 15/11/27.
//  Copyright © 2015年 Honzon. All rights reserved.
//

#define KSCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define KSCREEN_HEIGHT  ([UIScreen mainScreen].bounds.size.height)
#define KNAV_HEIGHT  44


#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSIndexPath *indexPath;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self createTableView];
}

- (void)createTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 22, KSCREEN_WIDTH, KSCREEN_HEIGHT - 22) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.tableView = tableView;
    [self.view addSubview:self.tableView];
   
}


#pragma mark -- UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.indexPath isEqual:indexPath]) {
        return 120;
    }
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self showOpenWithIndexPath:indexPath];
}
#pragma mark -- UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        UILabel *label  = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 40)];
        label.tag = 1000;
        label.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:label];
        
        UIView *openView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, KSCREEN_WIDTH, 80)];
        openView.tag = 999 ;
        openView.hidden = YES;
        openView.backgroundColor = [UIColor grayColor];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openViewClick:)];
        [openView addGestureRecognizer:tap];
        
        
        [cell.contentView addSubview:openView];
    }
    
    UIView *openView = [cell.contentView viewWithTag:999];
    if ([self.indexPath isEqual:indexPath]) {
        openView.hidden = NO;
    } else
    {
       openView.hidden = YES;
    }
    
    UILabel *label = (UILabel *)[cell.contentView viewWithTag:1000];
    label.text = [NSString stringWithFormat:@"第%ld个section 第%ld个cell",(long)indexPath.section ,(long)indexPath.row];
    return cell;
}


#pragma mark -- method

-(void)showOpenWithIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.indexPath && [self.indexPath isEqual:indexPath]) {
        //页面收回
        self.indexPath = nil;
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }else
    {
        if (self.indexPath) {
            //切换cell
            
            NSIndexPath * oldIndexPath = [NSIndexPath indexPathForRow:self.indexPath.row inSection:self.indexPath.section];
            
            self.indexPath = indexPath;
            [self.tableView reloadRowsAtIndexPaths:@[oldIndexPath,indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
        }else
        {
            //页面弹出
            self.indexPath = indexPath;
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
    }
    
}

- (void)openViewClick:(id)sender
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
