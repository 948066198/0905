//
//  questionModel.h
//  0905
//
//  Created by spp on 16/9/8.
//  Copyright © 2016年 spp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface questionModel : NSObject

@property(nonatomic,copy)NSString *strLastUpdateDate;

@property(nonatomic,copy)NSString *strDayDiffer;

@property(nonatomic,copy)NSString *sWebLk;

@property(nonatomic,copy)NSString *strPraiseNumber;

@property(nonatomic,copy)NSString *strQuestionId;

@property(nonatomic,copy)NSString *strQuestionTitle;

@property(nonatomic,copy)NSString *strQuestionContent;

@property(nonatomic,copy)NSString *strQuestionMarketTime;

@property(nonatomic,copy)NSString *sEditor;

@property(nonatomic,copy)NSString *strAnswerTitle;

@property(nonatomic,copy)NSString *strAnswerContent;

@property(nonatomic,copy)NSDictionary *entQNCmt;

-(instancetype)initWithDict:(NSDictionary *)dict;

@end
