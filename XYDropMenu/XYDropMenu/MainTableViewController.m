//
//  MainTableViewController.m
//  XYDropMenu
//
//  Created by 肖尧 on 16/12/19.
//  Copyright © 2016年 肖尧. All rights reserved.
//

#import "MainTableViewController.h"
#import "XYDropMenuView.h"

@interface MainTableViewController ()<XYDropMenuViewDelegate>

/* 选择的menu **/
//@property (nonatomic, copy) NSString *menuString;
/* 选择的cell **/
@property (nonatomic, strong) UITableViewCell *currentCell;

@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"请选择 - %ld", indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        XYDropMenuView *dropMenuView = [[XYDropMenuView alloc] initWithTitles:@[@"性别", @"男", @"女"]];
        dropMenuView.delegate = self;
        [dropMenuView showInView:self.navigationController.view];
        self.currentCell = [tableView cellForRowAtIndexPath:indexPath];
    }else if (indexPath.row == 1){
        XYDropMenuView *dropMenuView = [[XYDropMenuView alloc] initWithTitles:@[@"学历", @"高中", @"职专", @"大专", @"本科", @"研究生", @"博士"]];
        dropMenuView.delegate = self;
        [dropMenuView showInView:self.navigationController.view];
        self.currentCell = [tableView cellForRowAtIndexPath:indexPath];
    }else if (indexPath.row == 2){
        XYDropMenuView *dropMenuView = [[XYDropMenuView alloc] initWithTitles:@[@"工作经验", @"应届生", @"1~3年", @"3~5年", @"5~10年", @"10年以上"]];
        dropMenuView.delegate = self;
        [dropMenuView showInView:self.navigationController.view];
        self.currentCell = [tableView cellForRowAtIndexPath:indexPath];
    }else if (indexPath.row == 3){
        XYDropMenuView *dropMenuView = [[XYDropMenuView alloc] initWithTitles:@[@"属相", @"鼠", @"牛", @"虎", @"兔", @"龙", @"马", @"羊", @"猴", @"龙", @"鸡", @"狗", @"猪"]];
        dropMenuView.delegate = self;
        [dropMenuView showInView:self.navigationController.view];
        self.currentCell = [tableView cellForRowAtIndexPath:indexPath];
    }else if (indexPath.row == 4){
        XYDropMenuView *dropMenuView = [[XYDropMenuView alloc] initWithTitles:@[@"年龄", @"15以下", @"16", @"17", @"18", @"19", @"20", @"21", @"22", @"23", @"24", @"25", @"26", @"27", @"28", @"29", @"30", @"31", @"32", @"33", @"34", @"35", @"35以上"]];
        dropMenuView.delegate = self;
        [dropMenuView showInView:self.navigationController.view];
        self.currentCell = [tableView cellForRowAtIndexPath:indexPath];
    }
}

#pragma mark - XYDropMenuViewDelegate
-(void)dropMenuView:(XYDropMenuView *)dropMenuView didSelectedMenu:(NSString *)menuString{
    self.currentCell.textLabel.text = menuString;
}

@end
