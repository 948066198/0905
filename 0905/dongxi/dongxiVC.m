//
//  dongxiVC.m
//  0905
//
//  Created by spp on 16/9/6.
//  Copyright © 2016年 spp. All rights reserved.
//

#import "dongxiVC.h"

#import "AFNetworking.h"

#import "UIImageView+WebCache.h"

#import "thingCell.h"

#import "thingModel.h"

@interface dongxiVC ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView *collectionView;

@end

@implementation dongxiVC
{
    NSInteger _CellCount;
    
    NSMutableArray *_DataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _CellCount = 2;
    
    _DataArr = [[NSMutableArray alloc]init];
    
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
    [self.collectionView registerClass:[thingCell class] forCellWithReuseIdentifier:@"thingCell"];
    [self.view addSubview:self.collectionView];
    
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"%f %f",self.collectionView.contentOffset.x,self.collectionView.contentOffset.y);
    if (self.collectionView.contentOffset.x == ((_CellCount-1)*kWidth) &&_CellCount<11) {
        [self requestData:_CellCount];
        _CellCount++;
    }
}


-(void)requestData:(NSInteger)row
{
    [MBProgressHUD showHUDAddedTo:self.view  animated:YES];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlStr = @"http://bea.wufazhuce.com/OneForWeb/one/o_f";
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [formatter stringFromDate:date];
    
    NSDictionary *bodyDict = @{@"strDate":dateStr,@"strRow":[NSString stringWithFormat:@"%ld",row]};
    
    [manager GET:urlStr parameters:bodyDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSDictionary*dic = [[NSDictionary alloc]initWithDictionary:responseObject[@"entTg"]];
        
        thingModel *model = [[thingModel alloc]initWithDict:dic];
        [_DataArr addObject:model];
        
        
        [self.collectionView reloadData];
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [MBProgressHUD showError:@"服务器正忙，请稍后再试"];
    }];
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
    
    thingCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"thingCell" forIndexPath:indexPath];
    
    if (_DataArr.count == 0) {
        
    }else
        
        if (indexPath.row<=_CellCount-2) {
            
            thingModel *model = _DataArr[indexPath.row];
            
            NSArray *dateArr = [model.strTm componentsSeparatedByString:@"-"];
            NSString *MonStr = [[NSBundle mainBundle] pathForResource:@"Month" ofType:@"plist"];
            NSDictionary *MonDict = [[NSDictionary alloc]initWithContentsOfFile:MonStr];
            
            NSString *monyearstr = [NSString stringWithFormat:@"%@ %@,%@",MonDict[dateArr[1]],dateArr[2],dateArr[0]];
            
            cell.dateLab.text = monyearstr;
            cell.lineLab.backgroundColor = RGBColor(200, 200, 200);

            [cell.imgview sd_setImageWithURL:[NSURL URLWithString:model.strBu] placeholderImage:[UIImage imageNamed:@"collectionHeadBg"]];
            
            cell.titleLab.text = model.strTt;
            
            NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
            style.lineSpacing = 8;
            NSDictionary *attr = @{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:RGBColor(160, 160, 160),NSParagraphStyleAttributeName:style};
            CGSize size = [model.strTc boundingRectWithSize:CGSizeMake(kWidth-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attr context:nil].size;
            cell.contentLab.numberOfLines = 0;
            cell.contentLab.frame = CGRectMake(10, (kWidth-20)/19*20+130, kWidth-20, size.height);
            cell.contentLab.attributedText = [[NSAttributedString alloc]initWithString:model.strTc attributes:attr];
            
            cell.myscrollview.contentSize = CGSizeMake(kWidth, (kWidth-20)/19*20+130+size.height);
            
        }
    
    
    return cell;
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
