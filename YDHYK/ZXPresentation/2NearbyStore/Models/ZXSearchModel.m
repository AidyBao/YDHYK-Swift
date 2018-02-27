//
//  ZXSearchModel.m
//  YDHYK
//
//  Created by 120v on 2017/11/17.
//  Copyright © 2017年 screson. All rights reserved.
//
#import "ZXSearchModel.h"
#import "LKDBTool.h"
#import <MJExtension/MJExtension.h>

@implementation ZXSearchModel

//将key值id更换为uid
-(instancetype)init{
    if (self = [super init]) {
        
//        [ZXSearchModel mj_replacedKeyFromPropertyName:^NSDictionary *{
//            return @{@"storeId":@"id"};
//        }];
        
        [ZXSearchModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"storeId":@"id"};
        }];
    }
    return self;
}

//必须重写此方法
+ (NSDictionary *)describeColumnDict{
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
    LKDBColumnDes *account = [LKDBColumnDes new];
    account.primaryKey = YES;//是否为主键
    account.columnName = @"storeId";//别名
    
    LKDBColumnDes *name = [[LKDBColumnDes alloc] initWithgeneralFieldWithAuto:NO unique:NO isNotNull:YES check:nil defaultVa:nil];
    
    LKDBColumnDes *noField = [LKDBColumnDes new];
    noField.useless = YES;
    noField.autoincrement = YES;
    
    [dict setObject:account forKey:@"storeId"];
    [dict setObject:name forKey:@"name"];
    [dict setObject:noField forKey:@"noField"];
    return dict;
}
@end
