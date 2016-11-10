//
//  wenzhangModel.h
//  0905
//
//  Created by spp on 16/9/7.
//  Copyright © 2016年 spp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface wenzhangModel : NSObject

@property(nonatomic,copy)NSString *strLastUpdateDate;

@property(nonatomic,copy)NSString *strContent;

@property(nonatomic,copy)NSString *sWebLk;

@property(nonatomic,copy)NSString *wImgUrl;

@property(nonatomic,copy)NSString *sRdNum;

@property(nonatomic,copy)NSString *strPraiseNumber;

@property(nonatomic,copy)NSString *strContDayDiffer;

@property(nonatomic,copy)NSString *strContentId;

@property(nonatomic,copy)NSString *strContTitle;

@property(nonatomic,copy)NSString *strContAuthor;

@property(nonatomic,copy)NSString *strContAuthorIntroduce;

@property(nonatomic,copy)NSString *strContMarketTime;

@property(nonatomic,copy)NSString *sGW;

@property(nonatomic,copy)NSString *sAuth;

@property(nonatomic,copy)NSString *sWbN;

@property(nonatomic,copy)NSString *subTitle;

-(instancetype)initWithDict:(NSDictionary *)dict;

@end
