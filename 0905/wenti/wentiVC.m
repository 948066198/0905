//
//  wentiVC.m
//  0905
//
//  Created by spp on 16/9/6.
//  Copyright © 2016年 spp. All rights reserved.
//

#import "wentiVC.h"

#import "AFNetworking.h"

#import "questionModel.h"

#import "questionCell.h"

@interface wentiVC ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView *collectionView;

@end

@implementation wentiVC
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
    [self.collectionView registerClass:[questionCell class] forCellWithReuseIdentifier:@"questioncell"];
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
    
    NSString *urlStr = @"http://bea.wufazhuce.com/OneForWeb/one/getQ_N";
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [formatter stringFromDate:date];
    
    NSDictionary *bodyDict = @{@"strDate":dateStr,@"strUi":@"",@"strRow":[NSString stringWithFormat:@"%ld",row]};
    
    [manager GET:urlStr parameters:bodyDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSDictionary*dic = [[NSDictionary alloc]initWithDictionary:responseObject[@"questionAdEntity"]];
        
        questionModel *model = [[questionModel alloc]initWithDict:dic];
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
    
    questionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"questioncell" forIndexPath:indexPath];
    
    if (_DataArr.count == 0) {
        
    }else
        
        if (indexPath.row<=_CellCount-2) {
            
            questionModel *model = _DataArr[indexPath.row];
            
            NSArray *dateArr = [model.strQuestionMarketTime componentsSeparatedByString:@"-"];
            NSString *MonStr = [[NSBundle mainBundle] pathForResource:@"Month" ofType:@"plist"];
            NSDictionary *MonDict = [[NSDictionary alloc]initWithContentsOfFile:MonStr];
            
            NSString *monyearstr = [NSString stringWithFormat:@"%@ %@,%@",MonDict[dateArr[1]],dateArr[2],dateArr[0]];
            
            cell.dateLab.text = monyearstr;
            cell.lineLab.backgroundColor = RGBColor(200, 200, 200);
            cell.line1Lab.backgroundColor = RGBColor(200, 200, 200);
            cell.questionIv.image = [UIImage imageNamed:@"que_img"];
            
            
            NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
            style.lineSpacing = 8;
            NSDictionary *attr = @{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:RGBColor(62, 62, 62),NSParagraphStyleAttributeName:style};
            CGSize size = [model.strQuestionTitle boundingRectWithSize:CGSizeMake(kWidth-75, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attr context:nil].size;
            cell.questiontitleLab.numberOfLines = 0;
            cell.questiontitleLab.frame = CGRectMake(65, 50, kWidth-75, size.height);
            cell.questiontitleLab.attributedText = [[NSAttributedString alloc]initWithString:model.strQuestionTitle attributes:attr];
            
            
            NSDictionary *attr1 = @{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:RGBColor(100, 100, 100),NSParagraphStyleAttributeName:style};
            CGSize size1 = [model.strQuestionContent boundingRectWithSize:CGSizeMake(kWidth-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attr1 context:nil].size;
            
            NSLog(@"%f",size.height);
            CGFloat firHeight = MAX(88, size.height+50)+20;
            cell.questioncontentLab.frame = CGRectMake(10, firHeight, kWidth-20, size1.height);
            cell.questioncontentLab.numberOfLines = 0;
            cell.questioncontentLab.attributedText = [[NSAttributedString alloc]initWithString:model.strQuestionContent attributes:attr1];
            
            cell.line1Lab.frame = CGRectMake(10, firHeight+size1.height+20, kWidth-20, 1);
            
            cell.answerIv.frame = CGRectMake(15, firHeight+size1.height+40, 38, 38) ;
            cell.answerIv.image = [UIImage imageNamed:@"ans_img"];
            
            CGSize size2 = [model.strAnswerTitle boundingRectWithSize:CGSizeMake(kWidth-75, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attr context:nil].size;
            cell.answertitleLab.numberOfLines = 0;
            cell.answertitleLab.frame = CGRectMake(65, firHeight+size1.height+40, kWidth-75, size2.height);
            cell.answertitleLab.attributedText = [[NSAttributedString alloc]initWithString:model.strAnswerTitle attributes:attr];
            
            CGFloat secHeight = MAX(firHeight+size1.height+40+size2.height, firHeight+size1.height+78)+20;
            
            NSString *answerContentStr = [model.strAnswerContent stringByReplacingOccurrencesOfString:@"<br>" withString:@""];
            CGSize size3 = [answerContentStr boundingRectWithSize:CGSizeMake(kWidth-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attr1 context:nil].size;
            cell.answercontentLab.numberOfLines = 0;
            cell.answercontentLab.frame = CGRectMake(10, secHeight, kWidth-20, size3.height);
            cell.answercontentLab.attributedText = [[NSAttributedString alloc]initWithString:answerContentStr attributes:attr1];
            
            cell.myscrollvew.contentSize = CGSizeMake(kWidth, secHeight+size3.height+10);
            
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
