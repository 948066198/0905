//
//  MainModel.m
//  0905
//
//  Created by spp on 16/9/7.
//  Copyright © 2016年 spp. All rights reserved.
//

#import "MainModel.h"

@implementation hpEntityModel

-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}


@end


@implementation MainModel

-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        for (NSString *key in dict) {
            if ([key isEqualToString:@"hpEntity"]) {
                self.hpEntity = [[hpEntityModel alloc]initWithDict:dict[key]];
                continue;
            }
            [self setValue:dict[key] forKey:key];
        }
        
    }
    return self;
}

@end
