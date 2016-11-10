//
//  mainVC.m
//  0905
//
//  Created by spp on 16/9/6.
//  Copyright © 2016年 spp. All rights reserved.
//

#import "main1VC.h"

#import "ScrollCell.h"

#import "AFNetworking.h"

#import "UIImageView+WebCache.h"

#import "MainModel.h"

#define picHeight (kWidth-20)/1.25

@interface main1VC ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) id<ISSShareActionSheet> actionSheet;

@property(nonatomic,strong)UICollectionView *collectionView;

@end

@implementation main1VC
{
    NSDictionary *_dataDict;
    
    UIImage *_img;
    
    NSInteger _CellCount;
    
    NSMutableArray *_DataArr;
    
    NSInteger _num;//第几页
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)commonShare:(id)sender
{
    MainModel *model = _DataArr[_num];
    
    //1、构造分享内容
    //1.1、要分享的图片（以下分别是网络图片和本地图片的生成方式的示例）
    id<ISSCAttachment> remoteAttachment = [ShareSDKCoreService attachmentWithUrl:model.hpEntity.strOriginalImgUrl];
    //1.2、以下参数分别对应：内容、默认内容、图片、标题、链接、描述、分享类型
    id<ISSContent> publishContent = [ShareSDK content:model.hpEntity.strContent
                                       defaultContent:nil
                                                image:remoteAttachment
                                                title:model.hpEntity.strAuthor
                                                  url:@"http://www.mob.com"
                                          description:nil
                                            mediaType:SSPublishContentMediaTypeImage];
    //1+、创建弹出菜单容器（iPad应用必要，iPhone应用非必要）
    id<ISSContainer> container = [ShareSDK container];
    [container setIPadContainerWithView:sender
                            arrowDirect:UIPopoverArrowDirectionUp];
    
    //2、展现分享菜单
    [ShareSDK showShareActionSheet:container
                         shareList:nil
                           content:publishContent
                     statusBarTips:NO
                       authOptions:nil
                      shareOptions:nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                NSLog(@"=== response state :%zi ",state);
                                
                                //可以根据回调提示用户。
                                if (state == SSResponseStateSuccess)
                                {
                                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success"
                                                                                    message:nil
                                                                                   delegate:self
                                                                          cancelButtonTitle:@"OK"
                                                                          otherButtonTitles:nil, nil];
                                    [alert show];
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed"
                                                                                    message:[NSString stringWithFormat:@"Error Description：%@",[error errorDescription]]
                                                                                   delegate:self
                                                                          cancelButtonTitle:@"OK"
                                                                          otherButtonTitles:nil, nil];
                                    [alert show];
                                }
                            }];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setRightBtnSecolor:@selector(commonShare:)];

    _num = 0;
    
    _CellCount = 2;
    
    _DataArr = [[NSMutableArray alloc]init];
    
    _img = [UIImage imageNamed:@"contBack"];

    [self requestData:1];
    
    [self createColloctionview];
}

-(void)createColloctionview
{
    UICollectionViewFlowLayout *layer = [[UICollectionViewFlowLayout alloc]init];
    [layer setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    layer.minimumLineSpacing = 0;
    layer.minimumInteritemSpacing = 0;
    layer.itemSize = CGSizeMake(kWidth, kHeight-113);
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight-113) collectionViewLayout:layer];
    self.collectionView.showsHorizontalScrollIndicator = NO;
//    self.collectionView.bounces = NO;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[ScrollCell class] forCellWithReuseIdentifier:@"cell11"];
    [self.view addSubview:self.collectionView];
    
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (_CellCount<11) {
        return _CellCount;
    }else
    {
        return 10;
    }
    
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ScrollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell11" forIndexPath:indexPath];
    
    if (_DataArr.count == 0) {
        
    }else
    
    if (indexPath.row<=_CellCount-2) {
        
        MainModel *model = _DataArr[indexPath.row];
        
        cell.strHpTitleLab.text = model.hpEntity.strHpTitle;
        
        
        cell.imgiv.frame = CGRectMake(10, 60, kWidth-20, picHeight);
        [cell.imgiv sd_setImageWithURL:[NSURL URLWithString:model.hpEntity.strOriginalImgUrl]  placeholderImage:[UIImage imageNamed:@"collectionHeadBg"]];
        
        NSString *AuthorStr = [model.hpEntity.strAuthor stringByReplacingOccurrencesOfString:@"&" withString:@"\n"];
        cell.AuthorLab.text = AuthorStr;
        
        
        NSArray *dateArr = [model.hpEntity.strMarketTime componentsSeparatedByString:@"-"];
        cell.dayLab.text = dateArr[2];
        
        
        NSString *contentStr = model.hpEntity.strContent;
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
        style.lineSpacing = 4;
        
        CGSize size = [contentStr boundingRectWithSize:CGSizeMake(kWidth-110, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSParagraphStyleAttributeName:style} context:nil].size;
        
        
        cell.iv.frame = CGRectMake(90, picHeight+135, kWidth-100, size.height+10);
        cell.iv.image = [self image:size.height];
        
        NSMutableAttributedString *contentStr1 = [[NSMutableAttributedString alloc]initWithString:contentStr attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSParagraphStyleAttributeName:style}];
        
        cell.contentLab.attributedText = contentStr1;
        cell.contentLab.frame = CGRectMake(10, 5, cell.iv.frame.size.width-10, size.height);
        
        
        NSString *MonStr = [[NSBundle mainBundle] pathForResource:@"Month" ofType:@"plist"];
        NSDictionary *MonDict = [[NSDictionary alloc]initWithContentsOfFile:MonStr];
        
        NSString *monyearstr = [NSString stringWithFormat:@"%@,%@",MonDict[dateArr[1]],dateArr[0]];
        cell.yearLab.text = monyearstr;

        cell.FirScrollview.contentSize = CGSizeMake(kWidth, picHeight+165+size.height);
        
    }
    
    
    return cell;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"%f %f",self.collectionView.contentOffset.x,self.collectionView.contentOffset.y);
    _num = self.collectionView.contentOffset.x/kWidth;
    if (self.collectionView.contentOffset.x == ((_CellCount-1)*kWidth) &&_CellCount<11) {
        [self requestData:_CellCount];
        _CellCount++;
    }
}




-(UIImage *)image:(CGFloat)height{
    
    CGRect rect = CGRectMake(0, 0, _img.size.width*2, 30);
    
    CGImageRef fir = CGImageCreateWithImageInRect(_img.CGImage, rect);
    
    UIImage *img = [UIImage imageWithCGImage:fir];
    
    CGImageRelease(fir);
    
    
    CGRect rect1 = CGRectMake(0, 30, _img.size.width*2, 10);
    
    CGImageRef sec = CGImageCreateWithImageInRect(_img.CGImage, rect1);
    
    UIImage *img1 = [UIImage imageWithCGImage:sec];
    
    CGImageRelease(sec);
    
    
    CGRect rect2 = CGRectMake(0, 30, _img.size.width*2, 30);
    
    CGImageRef thir = CGImageCreateWithImageInRect(_img.CGImage, rect2);
    
    UIImage *img2 = [UIImage imageWithCGImage:thir];
    
    CGImageRelease(thir);
    
    UIGraphicsBeginImageContext(CGSizeMake(209*2, height+10));
    [img drawInRect:CGRectMake(0, 0, 209*2, 30)];
    [img1 drawInRect:CGRectMake(0, 30, 209*2, height-50)];
    [img2 drawInRect:CGRectMake(0, height-21, 209*2, 30)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}


-(void)requestData:(NSInteger)row
{
    [MBProgressHUD showHUDAddedTo:self.view  animated:YES];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlStr = @"http://bea.wufazhuce.com/OneForWeb/one/getHp_N";
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [formatter stringFromDate:date];
    
    NSDictionary *bodyDict = @{@"strDate":dateStr,@"strRow":[NSString stringWithFormat:@"%ld",row]};
    
    [manager GET:urlStr parameters:bodyDict progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSLog(@"%@",responseObject);
        
        _dataDict = [[NSDictionary alloc]initWithDictionary:responseObject];
        
        MainModel *model = [[MainModel alloc]initWithDict:responseObject];
        [_DataArr addObject:model];
         
        
        [self.collectionView reloadData];
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [MBProgressHUD showError:@"服务器正忙，请稍后再试"];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
