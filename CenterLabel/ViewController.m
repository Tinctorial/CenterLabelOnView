//
//  ViewController.m
//  CenterLabel
//
//  Created by 张超飞 on 2018/4/14.
//  Copyright © 2018年 ZCF. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    CGFloat _labelWidth;
    CGFloat _centerLabelBottom;
}

//
@property (nonatomic, strong) NSArray *textData;

//
@property (nonatomic, strong) UIView *backgroundView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.textData = @[@"OC", @"Swift", @"我喜欢敲代码", @"敲代码使我快乐", @"致喜欢敲代码的你", @"啦啦啦啦啦啦啦啦啦", @"啦", @"啦啦啦啦啦啦啦啦啦啦啦", @"啦啦啦啦啦啦啦啦啦啦啦骄傲骄傲骄傲骄傲家具啊", @"哈哈哈", @"wawahaha", @"ok"];
    
    self.backgroundView = [[UIView alloc] init];
    self.backgroundView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.backgroundView];
    
    [self createLabel];
}

- (void)createLabel {
    NSDictionary *dic = [self getFirstLabelLeft:0];
    NSInteger changeLineIndex = [dic.allKeys.firstObject integerValue];
    CGFloat rectX = [dic.allValues.firstObject floatValue];
    CGFloat rectY = 10.0;
    // 标签按钮
    for (int i = 0; i < self.textData.count; i ++) {
        NSString *labelText = self.textData[i];
        
        UILabel *centerLabel = [[UILabel alloc] init];
        centerLabel.font = [UIFont systemFontOfSize:10];
        centerLabel.textAlignment = NSTextAlignmentCenter;
        centerLabel.text = labelText;
        centerLabel.textColor = [UIColor brownColor];
        centerLabel.layer.borderColor = [UIColor whiteColor].CGColor;
        centerLabel.layer.borderWidth = 0.5;
        centerLabel.layer.cornerRadius = 2;
        centerLabel.layer.masksToBounds = YES;
        [centerLabel sizeToFit];
        
        CGFloat rectW = centerLabel.bounds.size.width + 6.0;
        
        if (i > 0) {
            // 前一个label
            NSString *foreLabelText = self.textData[i - 1];
            UILabel *foreLabel = [[UILabel alloc] init];
            foreLabel.font = [UIFont systemFontOfSize:10];
            foreLabel.textAlignment = NSTextAlignmentCenter;
            foreLabel.text = foreLabelText;
            [foreLabel sizeToFit];
            _labelWidth = foreLabel.frame.size.width + 6.0;
            
            // 判断是否是换行的icon
            if (i == changeLineIndex) {
                rectY = rectY + 10.0 * 2;
                NSDictionary *secondDic = [self getFirstLabelLeft:changeLineIndex];
                rectX = [secondDic.allValues.firstObject floatValue];
                changeLineIndex = [secondDic.allKeys.firstObject integerValue];
            } else {
                rectX = rectX + _labelWidth + 4.0;
            }
        }
        centerLabel.frame = CGRectMake(rectX, rectY, rectW, centerLabel.bounds.size.height + 10.0 / 2);
        centerLabel.tag = i + 100;
        [self.backgroundView addSubview:centerLabel];
        
        _centerLabelBottom = CGRectGetMaxY(centerLabel.frame);
    }
    
    self.backgroundView.frame = CGRectMake(0.0, 50.0, [UIScreen mainScreen].bounds.size.width, _centerLabelBottom + 10.0);
}

/**
 获取每行首个label的x坐标

 @param index <#index description#>
 @return <#return value description#>
 */
- (NSDictionary *)getFirstLabelLeft:(NSInteger)index {
    CGFloat labelWidth = 0.0;
    NSInteger endIndex = 0;
    for (NSInteger i = index; i < self.textData.count; i ++) {
        NSString *labelText = self.textData[i];
        
        UILabel *centerLabel = [[UILabel alloc] init];
        centerLabel.font = [UIFont systemFontOfSize:10];
        centerLabel.textAlignment = NSTextAlignmentCenter;
        centerLabel.text = labelText;
        centerLabel.textColor = [UIColor brownColor];
        centerLabel.layer.borderColor = [UIColor whiteColor].CGColor;
        centerLabel.layer.borderWidth = 0.5;
        centerLabel.layer.cornerRadius = 2;
        centerLabel.layer.masksToBounds = YES;
        [centerLabel sizeToFit];
        
        labelWidth += centerLabel.bounds.size.width + 6.0 + 4.0;
        
        if (labelWidth >= [UIScreen mainScreen].bounds.size.width - 10.0 * 6) {
            labelWidth = labelWidth - centerLabel.bounds.size.width - 6.0 - 4.0;
            endIndex = i;
            break ;
        }
    }
    
    return @{[NSString stringWithFormat:@"%ld", endIndex] : [NSNumber numberWithFloat:([UIScreen mainScreen].bounds.size.width - labelWidth) / 2.0]};
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
