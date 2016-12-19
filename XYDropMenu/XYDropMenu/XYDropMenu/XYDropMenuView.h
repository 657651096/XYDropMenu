//
//  XYDropMenuView.h
//  XYDropMenu
//
//  Created by 肖尧 on 16/12/19.
//  Copyright © 2016年 肖尧. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XYDropMenuView;

@protocol XYDropMenuViewDelegate <NSObject>

//选择menu后回调
-(void)dropMenuView:(XYDropMenuView *)dropMenuView didSelectedMenu:(NSString *)menuString;

@end

@interface XYDropMenuView : UIButton

/* 代理 **/
@property (nonatomic, weak) id<XYDropMenuViewDelegate> delegate;

-(instancetype)initWithTitles:(NSArray *)titles;

-(void)showInView:(UIView *)view;

-(void)hide;

@end
