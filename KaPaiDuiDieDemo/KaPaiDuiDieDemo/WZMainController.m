//
//  WZMainController.m
//  KaPaiDuiDieDemo
//
//  Created by songbiwen on 2016/12/21.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZMainController.h"


#define ImageCount 20

#define ButtonWidth 250
#define ButtonHeight 150

#define TopMargin 40


@interface WZMainController ()

@property (nonatomic, strong) NSArray *imageArray;

@property (nonatomic, weak) UIScrollView *scrollView;
@end

@implementation WZMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    //构建视图
    [self setupUI];
}

//构建视图
- (void)setupUI {
    //添加滚动视图
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    CGFloat leftMargin = (self.view.frame.size.width - ButtonWidth) * 0.5;
    CGFloat topMargin = 0;
    
    for (int i = 0; i < self.imageArray.count; i ++) {
        
        topMargin = TopMargin + i * ButtonHeight * 0.5;
        UIButton *cardButton = [[UIButton alloc] initWithFrame:CGRectMake(leftMargin, topMargin, ButtonWidth, ButtonHeight)];
        [cardButton setImage:self.imageArray[i] forState:UIControlStateNormal];
        [cardButton addTarget:self action:@selector(cardButonAction:) forControlEvents:UIControlEventTouchUpInside];
        cardButton.tag = i + 1;
        [scrollView addSubview:cardButton];
    }
    
    CGSize size = scrollView.contentSize;
    size.height = MAX(size.height, topMargin + ButtonHeight);
    scrollView.contentSize = size;
    
}


//按钮点击事件
- (void)cardButonAction:(UIButton *)clickedButton {
    
    NSInteger clickedButtonTag = clickedButton.tag;
    
    if (clickedButton.selected) {
        
        for (int i = 0; i < self.imageArray.count; i ++) {
            UIButton *cardButton = self.scrollView.subviews[i];
            
            CGRect frame = cardButton.frame;
            
            frame.origin.y = TopMargin + i * ButtonHeight * 0.5;
            
            [UIView animateWithDuration:0.25 animations:^{
                cardButton.frame = frame;
            }];
        }
        
    }else {
        
        for (int i = 0; i < self.imageArray.count; i ++) {
            UIButton *cardButton = self.scrollView.subviews[i];
            
            CGRect frame = cardButton.frame;
            
            if (cardButton.tag <= clickedButtonTag) {
                
                frame.origin.y = TopMargin;
            }else {
                frame.origin.y = self.scrollView.contentSize.height + ButtonHeight;
            }
            
            [UIView animateWithDuration:0.25 animations:^{
                cardButton.frame = frame;
            }];
        }
    }
    
    clickedButton.selected = !clickedButton.selected;
}

- (NSArray *)imageArray {
    if (!_imageArray) {
        _imageArray = [NSArray array];
        
        NSMutableArray *mutableArr = [NSMutableArray array];
        
        for (int i = 1; i <= ImageCount; i ++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"image%zd",i]];
            [mutableArr addObject:image];
        }
        
        _imageArray = [mutableArr copy];
    }
    return _imageArray;
}
@end
