//
//  ViewController.m
//  Marquee
//
//  Created by zhifu360 on 2018/11/13.
//  Copyright © 2018 ZZJ. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

///marqueeLabel
@property (nonatomic, strong) UILabel *marqueeLabel;
///marqueeLabelWidth
@property (nonatomic, assign) CGFloat marqueeLabelWidth;
///start_X
@property (nonatomic, assign) CGFloat start_X;
///maskView
@property (nonatomic, strong) UIView *maskView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createMarqueeBar];
    
    [self startMarqueeAnimation];
}

///createMarqueeBar
- (void)createMarqueeBar {
    
    _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 50)];
    [self.view addSubview:_maskView];
    _maskView.backgroundColor = [UIColor lightGrayColor];
    _maskView.clipsToBounds = YES;
    
    //设置起点
    _start_X = _maskView.bounds.size.width;
    
    _marqueeLabel = [UILabel new];
    _marqueeLabel.text = @"Marquee Marquee Marquee Marquee Marquee Marquee";
    _marqueeLabel.textColor = [UIColor whiteColor];
    _marqueeLabel.font = [UIFont systemFontOfSize:14.0f];
    _marqueeLabelWidth = [self getTextWidth:_marqueeLabel withHeight:50];
    _marqueeLabel.frame = CGRectMake(_start_X, 0, _marqueeLabelWidth, 50);
    [_maskView addSubview:_marqueeLabel];
}

///startMarqueeAnimation
- (void)startMarqueeAnimation {
    
    CGFloat W = _marqueeLabelWidth;
    CGFloat H = CGRectGetHeight(_marqueeLabel.frame);
    
    [UIView animateWithDuration:10 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.marqueeLabel.frame = CGRectMake(-W, 0, W, H);
    } completion:^(BOOL finished) {
        self.marqueeLabel.frame = CGRectMake(self.start_X, 0, W, H);
        
        [self startMarqueeAnimation];
    }];
}

///getLabelWidth
- (CGFloat)getTextWidth:(UILabel *)label withHeight:(CGFloat)height {
    if (!label.text) {
        return 0.0f;
    }
    
    return [label.text boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:label.font} context:nil].size.width+2;
}

@end
