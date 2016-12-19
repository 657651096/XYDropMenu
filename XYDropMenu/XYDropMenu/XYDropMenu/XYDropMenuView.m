//
//  XYDropMenuView.m
//  XYDropMenu
//
//  Created by 肖尧 on 16/12/19.
//  Copyright © 2016年 肖尧. All rights reserved.
//

#import "XYDropMenuView.h"

#define XYScreenBounds [UIScreen mainScreen].bounds
#define XYMenuCellHeight 44.0
#define XYMenuTitleHeight 30.0

@interface XYDropMenuView ()

/* 总容器 **/
@property (nonatomic, strong) UIView *container;
/* 菜单容器 **/
@property (nonatomic, strong) UIScrollView *menuContainer;
/* 菜单标题 **/
@property (nonatomic, strong) UILabel *menuTitle;

/* 标题数组 **/
@property (nonatomic, strong) NSArray *titles;

@end

@implementation XYDropMenuView

-(instancetype)initWithTitles:(NSArray *)titles{
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        self.titles = titles;
        [self setUpUI];
    }
    return self;
}

//-(instancetype)initWithFrame:(CGRect)frame{
//    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
//        [self setUpUI];
//    }
//    return self;
//}

//-(void)setTitles:(NSArray *)titles{
//    _titles = titles;
//    
//    [self setUpUI];
//}

//添加按钮
-(void)setUpUI{
    self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    [self addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    //添加标题
    self.menuTitle.text = self.titles.firstObject;
    //添加子菜单
    for (int i = 1; i < self.titles.count; i++) {
        CGFloat buttonX = 0;
        CGFloat buttonW = XYScreenBounds.size.width;
        CGFloat buttonH = XYMenuCellHeight;
        CGFloat buttonY = buttonH * (i - 1);
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(buttonX, buttonY, buttonW, buttonH)];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitle:self.titles[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(selectMenu:) forControlEvents:UIControlEventTouchUpInside];
        //添加分割线
        UIView *cutoffLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, buttonW, 1)];
        cutoffLine.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.2];
        [button addSubview:cutoffLine];
        [self.menuContainer addSubview:button];
    }
}

//菜单点击
-(void)selectMenu:(UIButton *)sender{
    //隐藏菜单
    [self dismiss];
    //委托
    if ([self.delegate respondsToSelector:@selector(dropMenuView:didSelectedMenu:)]) {
        [self.delegate dropMenuView:self didSelectedMenu:[sender titleForState:UIControlStateNormal]];
    }
}

//点击消失
-(void)dismiss{
    [UIView animateWithDuration:0.25 animations:^{
        self.container.frame = CGRectMake(self.container.frame.origin.x, XYScreenBounds.size.height, self.container.frame.size.width, self.container.frame.size.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

//显示
-(void)showInView:(UIView *)view{
    [view addSubview:self];
    //弹出菜单
    [UIView animateWithDuration:0.25 animations:^{
        self.container.frame = CGRectMake(self.container.frame.origin.x, XYScreenBounds.size.height - self.container.frame.size.height, self.container.frame.size.width, self.container.frame.size.height);
    } completion:nil];
}

//隐藏
-(void)hide{
    [self dismiss];
}

#pragma mark - 懒加载
-(UIView *)container{
    if (!_container) {
        CGFloat containerX = 0;
        CGFloat containerW = XYScreenBounds.size.width;
        CGFloat containerH = XYMenuCellHeight * (self.titles.count > 10 ? 10 : self.titles.count - 1) + 30;
        CGFloat containerY = XYScreenBounds.size.height;
        _container = [[UIView alloc] initWithFrame:CGRectMake(containerX, containerY, containerW, containerH)];
        _container.backgroundColor = [UIColor whiteColor];
        [self addSubview:_container];
    }
    return _container;
}

-(UIView *)menuContainer{
    if (!_menuContainer) {
        CGFloat menuContainerX = 0;
        CGFloat menuContainerY = XYMenuTitleHeight;
        CGFloat menuContainerW = XYScreenBounds.size.width;
        CGFloat menuContainerH = XYMenuCellHeight * (self.titles.count > 10 ? 10 : self.titles.count - 1);
        _menuContainer = [[UIScrollView alloc] initWithFrame:CGRectMake(menuContainerX, menuContainerY, menuContainerW, menuContainerH)];
        _menuContainer.backgroundColor = [UIColor clearColor];
        _menuContainer.contentSize = CGSizeMake(0, XYMenuCellHeight * (self.titles.count - 1));
        _menuContainer.showsVerticalScrollIndicator = NO;
        [self.container addSubview:_menuContainer];
    }
    return _menuContainer;
}

-(UILabel *)menuTitle{
    if (!_menuTitle) {
        _menuTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, XYScreenBounds.size.width, XYMenuTitleHeight)];
        _menuTitle.textAlignment = NSTextAlignmentCenter;
        [self.container addSubview:_menuTitle];
    }
    return _menuTitle;
}

@end
