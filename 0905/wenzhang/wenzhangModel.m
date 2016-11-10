//
//  wenzhangModel.m
//  0905
//
//  Created by spp on 16/9/7.
//  Copyright © 2016年 spp. All rights reserved.
//

#import "wenzhangModel.h"

@implementation wenzhangModel

-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

@end
