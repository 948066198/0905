//
//  questionModel.m
//  0905
//
//  Created by spp on 16/9/8.
//  Copyright © 2016年 spp. All rights reserved.
//

#import "questionModel.h"

@implementation questionModel

-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        for (NSString *key in dict) {
            if ([key isEqualToString:@"entQNCmt"]) {
                self.entQNCmt = [[NSDictionary alloc]initWithDictionary:dict[key]];
                continue;
            }
            [self setValue:dict[key] forKey:key];
        }
    }
    return self;
}

@end
