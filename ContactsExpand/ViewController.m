//
//  ViewController.m
//  ContactsExpand
//
//  Created by apple on 8/16/15.
//  Copyright (c) 2015 jackyshan. All rights reserved.
//

#import "ViewController.h"
#import "CityAreaCell.h"
#import "DistrictAreaCell.h"
#import "ContactsModel.h"
#import "ThreeSubView.h"
#import "ProvinceAreaCell.h"
#import "StreetAreaCell.h"

#define PROVINCEAREA_CELL @"provinceAreaCell"
#define CITYAREA_CELL @"cityAreaCell"
#define DISTRICTAREA_CELL @"districtAreaCell"
#define STREETAREA_CELL @"streetAreaCell"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate> {
    UITableView *_tableView;
    NSMutableArray *_contactsArr;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"列表展开";
    
    [self _setupViews];
    [self _getData];
}

- (void)_setupViews {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    _tableView = tableView;
    
    [tableView registerClass:[ProvinceAreaCell class] forCellReuseIdentifier:PROVINCEAREA_CELL];
    [tableView registerClass:[CityAreaCell class] forCellReuseIdentifier:CITYAREA_CELL];
    [tableView registerClass:[DistrictAreaCell class] forCellReuseIdentifier:DISTRICTAREA_CELL];
    [tableView registerClass:[StreetAreaCell class] forCellReuseIdentifier:STREETAREA_CELL];
}

- (void)_getData {
    _contactsArr = [NSMutableArray array];
    
    for (int i = 0; i < 2; i++) {
        NSMutableArray *mArr1 = [NSMutableArray array];
        for (int i = 0; i < 2; i++) {
            NSMutableArray *mArr = [NSMutableArray array];
            for (int i = 0; i < 3; i++) {
                NSMutableArray *mArr2 = [NSMutableArray array];
                for (int i = 0; i < 2; i++) {
                    StreetArea *model = [[StreetArea alloc] init];
                    model.street = @"赤岗街道";
                    model.areaId = @"11";
                    [mArr2 addObject:model];
                }
                DistrictArea *district = [[DistrictArea alloc] init];
                district.district = @"海珠区";
                district.streetList = [mArr2 copy];
                [mArr addObject:district];
            }
            CityArea *city = [[CityArea alloc] init];
            city.city = @"广州市";
            city.districtList = [mArr copy];
            [mArr1 addObject:city];
        }
        ProvinceArea *province = [[ProvinceArea alloc] init];
        province.province = @"广东省";
        province.cityList = [mArr1 copy];
        [_contactsArr addObject:province];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _contactsArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    
    id model =  _contactsArr[indexPath.row];
    if ([model isKindOfClass:[ProvinceArea class]]) {
        cell = [tableView dequeueReusableCellWithIdentifier:PROVINCEAREA_CELL forIndexPath:indexPath];
        [(ProvinceAreaCell *)cell updateWithModel:model];
    }
    else if ([model isKindOfClass:[CityArea class]]) {
        cell = [tableView dequeueReusableCellWithIdentifier:CITYAREA_CELL forIndexPath:indexPath];
        [(CityAreaCell *)cell updateWithModel:model];
    }
    else if ([model isKindOfClass:[DistrictArea class]]) {
        cell = [tableView dequeueReusableCellWithIdentifier:DISTRICTAREA_CELL forIndexPath:indexPath];
        [(DistrictAreaCell *)cell updateWithModel:model];
    }
    else {
        cell = [tableView dequeueReusableCellWithIdentifier:STREETAREA_CELL forIndexPath:indexPath];
        [(StreetAreaCell *)cell updateWithModel:model];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    id model = _contactsArr[indexPath.row];
    if ([model isKindOfClass:[ProvinceArea class]]) {//当前的判断
        ProvinceArea *provinceModel = model;
        provinceModel.selected = !provinceModel.selected;
        
        NSMutableArray *paths = [NSMutableArray array];
        NSMutableIndexSet *sets = [NSMutableIndexSet indexSet];
        NSInteger indexPlus = 0;
        for (int i = 1; i <= provinceModel.cityList.count; i++) {
            [sets addIndex:indexPath.row+i+indexPlus];
            NSIndexPath *path = [NSIndexPath indexPathForRow:indexPath.row+i+indexPlus inSection:indexPath.section];
            [paths addObject:path];
            
            CityArea *cityModel = provinceModel.cityList[i-1];//第三层处理
            if (cityModel.selected) {
                cityModel.selected = !cityModel.selected;
                NSInteger indexPlus1 = 0;
                for (int j = 1; j <= cityModel.districtList.count; j++) {
                    [sets addIndex:indexPath.row+i+j+indexPlus+indexPlus1];
                    NSIndexPath *path = [NSIndexPath indexPathForRow:indexPath.row+i+j+indexPlus+indexPlus1 inSection:indexPath.section];
                    [paths addObject:path];
                    
                    DistrictArea *districtModel = cityModel.districtList[j-1];//第四层处理
                    if (districtModel.selected) {
                        districtModel.selected = !districtModel.selected;
                        for (int k = 1; k <= districtModel.streetList.count; k++) {
                            [sets addIndex:indexPath.row+i+j+k+indexPlus+indexPlus1];
                            NSIndexPath *path = [NSIndexPath indexPathForRow:indexPath.row+i+j+k+indexPlus+indexPlus1 inSection:indexPath.section];
                            [paths addObject:path];
                        }
                        indexPlus1 += districtModel.streetList.count;
                    }
                }
                indexPlus += cityModel.districtList.count;
                indexPlus += indexPlus1;
            }
        }
        
        if (provinceModel.selected) {//被选中了，哈哈
            if (provinceModel.cityList.count <= 0) {
                provinceModel.selected = !provinceModel.selected;
                NSLog(@"无城市列表!");return;
            }
            [_contactsArr insertObjects:provinceModel.cityList atIndexes:sets];
            [tableView beginUpdates];
            [tableView insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationMiddle];
            [tableView endUpdates];
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView scrollToRowAtIndexPath:paths[provinceModel.cityList.count-1]
                             atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }
        else //没有选中，😄
        {
            [_contactsArr removeObjectsAtIndexes:sets];
            [tableView beginUpdates];
            [tableView deleteRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationMiddle];
            [tableView endUpdates];
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
    }
    else if ([model isKindOfClass:[CityArea class]]) {//当前的判断
        CityArea *cityModel = model;
        cityModel.selected = !cityModel.selected;
        
        NSMutableArray *paths = [NSMutableArray array];
        NSMutableIndexSet *sets = [NSMutableIndexSet indexSet];
        NSInteger indexPlus = 0;
        for (int i = 1; i <= cityModel.districtList.count; i++) {
            [sets addIndex:indexPath.row+i+indexPlus];
            NSIndexPath *path = [NSIndexPath indexPathForRow:indexPath.row+i+indexPlus inSection:indexPath.section];
            [paths addObject:path];
            
            DistrictArea *districtModel = cityModel.districtList[i-1];//第三层处理
            if (districtModel.selected) {
                districtModel.selected = !districtModel.selected;
                for (int j = 1; j <= districtModel.streetList.count; j++) {
                    [sets addIndex:indexPath.row+i+j+indexPlus];
                    NSIndexPath *path = [NSIndexPath indexPathForRow:indexPath.row+i+j+indexPlus inSection:indexPath.section];
                    [paths addObject:path];
                }
                indexPlus += districtModel.streetList.count;
            }
        }
        
        if (cityModel.selected) {//被选中了，哈哈
            if (cityModel.districtList.count <= 0) {
                cityModel.selected = !cityModel.selected;
                NSLog(@"无区级列表!");return;
            }
            [_contactsArr insertObjects:cityModel.districtList atIndexes:sets];
            [tableView beginUpdates];
            [tableView insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationMiddle];
            [tableView endUpdates];
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView scrollToRowAtIndexPath:paths[cityModel.districtList.count-1]
                             atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }
        else //没有选中，😄
        {
            [_contactsArr removeObjectsAtIndexes:sets];
            [tableView beginUpdates];
            [tableView deleteRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationMiddle];
            [tableView endUpdates];
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
    }
    else if ([model isKindOfClass:[DistrictArea class]]) {
        DistrictArea *districtModel = model;
        districtModel.selected = !districtModel.selected;
        
        NSMutableArray *paths = [NSMutableArray array];
        NSMutableIndexSet *sets = [NSMutableIndexSet indexSet];
        for (int i = 1; i <= districtModel.streetList.count; i++) {
            [sets addIndex:indexPath.row+i];
            NSIndexPath *path = [NSIndexPath indexPathForRow:indexPath.row+i inSection:indexPath.section];
            [paths addObject:path];
        }
        
        if (districtModel.selected) {//被选中了，哈哈
            if (districtModel.streetList.count <= 0) {
                districtModel.selected = !districtModel.selected;
                NSLog(@"无街道列表!");return;
            }
            [_contactsArr insertObjects:districtModel.streetList atIndexes:sets];
            [tableView beginUpdates];
            [tableView insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationMiddle];
            [tableView endUpdates];
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            //            [tableView scrollToRowAtIndexPath:paths[districtModel.streetList.count-1]
            //                             atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }
        else //没有选中，😄
        {
            [_contactsArr removeObjectsAtIndexes:sets];
            [tableView beginUpdates];
            [tableView deleteRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationMiddle];
            [tableView endUpdates];
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
    }
    else if ([model isKindOfClass:[StreetArea class]]) {
        
    }
}

@end
