//
//  StreetAreaCell.m
//  YSBIndustry
//
//  Created by jackyshan on 15/3/17.
//  Copyright (c) 2015年 WuJunwei. All rights reserved.
//

#import "StreetAreaCell.h"
#import "ThreeSubView.h"
#import "Macro.h"

@interface StreetAreaCell() {
    ThreeSubView *_threeSubView;
}

@end

@implementation StreetAreaCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.backgroundColor = COLOR_D2D2D2;
        
        [self _setupViews];
    }
    
    return self;
}

- (void)_setupViews {
    ThreeSubView *threeSubView = [[ThreeSubView alloc] initWithFrame:CGRectMake(50, 0, kScreenWidth-40, 45)
                                               leftButtonSelectBlock:nil
                                             centerButtonSelectBlock:nil
                                              rightButtonSelectBlock:nil];
    [threeSubView.leftButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [threeSubView.rightButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [threeSubView.leftButton setTitleColor:COLOR_1B1B1B forState:UIControlStateNormal];
    [threeSubView.leftButton.titleLabel setFont:[UIFont systemFontOfSize:12.f]];
    [threeSubView autoFit];
    [self.contentView addSubview:threeSubView];
    _threeSubView = threeSubView;
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, kScreenWidth, 1)];
    lineView.backgroundColor = COLOR_DCDCDC;
    [self.contentView addSubview:lineView];
}

- (void)updateWithModel:(StreetArea *)model {
    [_threeSubView.leftButton setTitle:model.street forState:UIControlStateNormal];
}

@end
