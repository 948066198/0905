//
//  wenzhangVC.m
//  0905
//
//  Created by spp on 16/9/6.
//  Copyright © 2016年 spp. All rights reserved.
//

#import "wenzhangVC.h"

#import "AFNetworking.h"

#import "wenzhangModel.h"

#import "wenzhangCell.h"

@interface wenzhangVC ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView *collectionView;


@end

@implementation wenzhangVC
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
    [self.collectionView registerClass:[wenzhangCell class] forCellWithReuseIdentifier:@"wenzhangCell"];
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
    
    NSString *urlStr = @"http://bea.wufazhuce.com/OneForWeb/one/getC_N";
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [formatter stringFromDate:date];
    
    NSDictionary *bodyDict = @{@"strDate":dateStr,@"strRow":[NSString stringWithFormat:@"%ld",row]};
    
    [manager GET:urlStr parameters:bodyDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSLog(@"%@",responseObject);
        NSDictionary*dic = [[NSDictionary alloc]initWithDictionary:responseObject[@"contentEntity"]];
        
        wenzhangModel *model = [[wenzhangModel alloc]initWithDict:dic];
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
    
    wenzhangCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"wenzhangCell" forIndexPath:indexPath];
    
    if (_DataArr.count == 0) {
        
    }else
        
        if (indexPath.row<=_CellCount-2) {
            
            wenzhangModel *model = _DataArr[indexPath.row];
            
            NSArray *dateArr = [model.strContMarketTime componentsSeparatedByString:@"-"];
            NSString *MonStr = [[NSBundle mainBundle] pathForResource:@"Month" ofType:@"plist"];
            NSDictionary *MonDict = [[NSDictionary alloc]initWithContentsOfFile:MonStr];
            
            NSString *monyearstr = [NSString stringWithFormat:@"%@ %@,%@",MonDict[dateArr[1]],dateArr[2],dateArr[0]];
            
            cell.dateLab.text = monyearstr;
            
            cell.titleLab.text = model.strContTitle;
            
            cell.AuthorLab.text = model.strContAuthor;
            
            NSString *contentStr1 = [model.strContent stringByReplacingOccurrencesOfString:@"<br>" withString:@""];
            
            NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
            style.lineSpacing = 8;
            
            NSDictionary *attrDict = @{NSFontAttributeName:[UIFont systemFontOfSize:16],NSParagraphStyleAttributeName:style};
            
            CGSize size = [contentStr1 boundingRectWithSize:CGSizeMake(kWidth-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attrDict context:nil].size;
            
            
            cell.contentLab.frame = CGRectMake(10, 120, kWidth-20, size.height+10);
            
            NSMutableAttributedString *contentStr= [[NSMutableAttributedString alloc]initWithString:contentStr1];
            [contentStr addAttributes:attrDict range:NSMakeRange(0, contentStr.length)];

            cell.contentLab.numberOfLines = 0;
            cell.contentLab.attributedText = contentStr;
            
            cell.line1Lab.frame = CGRectMake(10, size.height+130, kWidth-20, 1);
            
            cell.sWbNLab.frame = CGRectMake(10, size.height+140, kWidth-20, 30);
            NSMutableAttributedString *swbnStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@",model.strContAuthor,model.sWbN]];
            [swbnStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:25],NSForegroundColorAttributeName:RGBColor(112, 113, 114)} range:NSMakeRange(0, model.strContAuthor.length)];
            [swbnStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:RGBColor(193, 193, 193)} range:NSMakeRange(model.strContAuthor.length, model.sWbN.length)];
            cell.sWbNLab.attributedText = swbnStr;
            
            CGSize size1 = [model.sAuth boundingRectWithSize:CGSizeMake(kWidth-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attrDict context:nil].size;
            
            cell.sAuthLab.frame = CGRectMake(10, 190+size.height, kWidth-20, size1.height);
            cell.sAuthLab.attributedText = [[NSMutableAttributedString alloc]initWithString:model.sAuth attributes:attrDict];
            
            cell.line1Lab.backgroundColor = RGBColor(200, 200, 200);
            cell.lineLab.backgroundColor = RGBColor(200, 200, 200);
            
            cell.myscrollvew.contentSize = CGSizeMake(kWidth, 190+size.height+size1.height);
            
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
