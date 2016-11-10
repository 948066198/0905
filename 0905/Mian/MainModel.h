//
//  MainModel.h
//  0905
//
//  Created by spp on 16/9/7.
//  Copyright © 2016年 spp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface hpEntityModel : NSObject

@property(nonatomic,copy)NSString *sWebLk;

@property(nonatomic,copy)NSString *strAuthor;

@property(nonatomic,copy)NSString *strContent;

@property(nonatomic,copy)NSString *strHpId;

@property(nonatomic,copy)NSString *strHpTitle;

@property(nonatomic,copy)NSString *strMarketTime;

@property(nonatomic,copy)NSString *strOriginalImgUrl;

@property(nonatomic,copy)NSString *wImgUrl;

@property(nonatomic,copy)NSString *strThumbnailUrl;

@property(nonatomic,copy)NSString *strLastUpdateDate;

@property(nonatomic,copy)NSString *strDayDiffer;

@property(nonatomic,copy)NSString *strPn;

@end

@interface MainModel : NSObject

@property(nonatomic,copy)NSString *result;

@property(nonatomic,strong)hpEntityModel *hpEntity;

-(instancetype)initWithDict:(NSDictionary *)dict;

@end

