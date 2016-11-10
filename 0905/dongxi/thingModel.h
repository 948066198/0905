//
//  thingModel.h
//  0905
//
//  Created by spp on 16/9/8.
//  Copyright © 2016年 spp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface thingModel : NSObject

@property(nonatomic,copy)NSString *strLastUpdateDate;

@property(nonatomic,copy)NSString *strPn;

@property(nonatomic,copy)NSString *strBu;

@property(nonatomic,copy)NSString *strTm;

@property(nonatomic,copy)NSString *strWu;

@property(nonatomic,copy)NSString *strId;

@property(nonatomic,copy)NSString *strTt;

@property(nonatomic,copy)NSString *strTc;

-(instancetype)initWithDict:(NSDictionary *)dict;

@end
