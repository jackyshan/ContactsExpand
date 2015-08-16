//
//  ContactsModel.h
//  ContactsExpand
//
//  Created by apple on 8/16/15.
//  Copyright (c) 2015 jackyshan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactsModel : NSObject

@property (nonatomic, strong) NSString *userId;//用户id
@property (nonatomic, strong) NSString *name;//名称
@property (nonatomic, strong) NSString *phone;//用户手机号
@property (nonatomic, strong) NSURL *avatar;//头像链接
@property (nonatomic, strong) NSString *position;//职务
@property (nonatomic, strong) NSString *address;//地址
@property (nonatomic, assign) BOOL isOnline;//是否在线

@end

@interface StreetArea : NSObject

@property (nonatomic, strong) NSString *street;//街道名称
@property (nonatomic, strong) NSString *areaId;//区id

@end

@protocol StreetArea

@end

@interface DistrictArea : NSObject

@property (nonatomic, strong) NSString *district;//区域名称
@property (nonatomic, strong) NSArray<StreetArea> *streetList;//街道列表
@property (nonatomic, assign) BOOL selected;//被选中

@end

@protocol DistrictArea

@end

@interface CityArea : NSObject

@property (nonatomic, strong) NSString *city;//城市名称
@property (nonatomic, strong) NSArray<DistrictArea> *districtList;//区域列表
@property (nonatomic, assign) BOOL selected;//被选中

@end

@protocol CityArea

@end

@interface ProvinceArea : NSObject

@property (nonatomic, strong) NSString *province;//省级名称
@property (nonatomic, strong) NSArray<CityArea> *cityList;//城市列表
@property (nonatomic, assign) BOOL selected;//被选中

@end