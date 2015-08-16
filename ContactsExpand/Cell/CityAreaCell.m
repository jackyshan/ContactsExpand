//
//  CityAreaCell.m
//  YSBIndustry
//
//  Created by jackyshan on 15/3/9.
//  Copyright (c) 2015年 WuJunwei. All rights reserved.
//

#import "CityAreaCell.h"
#import "ThreeSubView.h"
#import "Macro.h"

@interface CityAreaCell() {
    ThreeSubView *_threeSubView;
}

@end

@implementation CityAreaCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.backgroundColor = COLOR_EEEEEE;
        
        [self _setupViews];
    }
    
    return self;
}

- (void)_setupViews {
    ThreeSubView *threeSubView = [[ThreeSubView alloc] initWithFrame:CGRectMake(30, 0, kScreenWidth-40, 45)
                                              leftButtonSelectBlock:nil
                                            centerButtonSelectBlock:nil
                                             rightButtonSelectBlock:nil];
    [threeSubView.leftButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [threeSubView.rightButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [threeSubView.leftButton setTitleColor:COLOR_1B1B1B forState:UIControlStateNormal];
    [threeSubView.leftButton setTitleColor:COLOR_0096ff forState:UIControlStateSelected];
    [threeSubView.leftButton.titleLabel setFont:[UIFont systemFontOfSize:12.f]];
    [threeSubView autoFit];
    [threeSubView.rightButton setImage:[UIImage imageNamed:@"arrow_up"] forState:UIControlStateNormal];
    [threeSubView.rightButton setImage:[UIImage imageNamed:@"arrow_down"] forState:UIControlStateSelected];
    [self.contentView addSubview:threeSubView];
    _threeSubView = threeSubView;
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, kScreenWidth, 1)];
    lineView.backgroundColor = COLOR_DCDCDC;
    [self.contentView addSubview:lineView];
}

- (void)updateWithModel:(CityArea *)model {
    [_threeSubView.leftButton setTitle:model.city forState:UIControlStateNormal];
    [_threeSubView.rightButton setSelected:model.selected];
    [_threeSubView.leftButton setSelected:model.selected];
}

@end
