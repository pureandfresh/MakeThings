//
//  NavigationBarTitlesView.m
//  MakeThings
//
//  Created by Jing Ye on 13/12/2017.
//  Copyright © 2017 aiwen. All rights reserved.
//

#import "NavigationBarTitlesView.h"

#define ColorFromRGBHex(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define TitleNormalFont       [UIFont systemFontOfSize:16]
#define TitleSelectedFont     [UIFont boldSystemFontOfSize:16]
#define NavigationTagBase     1000
#define TitleNormalColor      ColorFromRGBHex(0x555555)
#define TitleSelectedColor    ColorFromRGBHex(0x333333)
#define ButtonMargin          26
#define SlideViewColor        ColorFromRGBHex(0x333333)
#define SlideViewTag          20200

@interface NavigationBarTitlesView()
@property (nonatomic) NSArray *titlesArray;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) UIView *buttonsContainer;

@end
@implementation NavigationBarTitlesView

- (instancetype)initWithFrame:(CGRect)frame titlesArray:(NSArray *)titlesArray {
    self = [super init];
    if (self) {
        self.titlesArray = titlesArray;
        self.selectedIndex = 0;
        self.clipsToBounds = YES;
        [self configureUI];
    }
    return self;
}

- (void)configureUI{
    __block CGFloat currentXpos = 0;
    __block CGFloat slideViewCenterX = 0;
    __block CGFloat slideViewWidth= 0;
    
    _buttonsContainer = [[UIView alloc] init];
    [[self.titlesArray copy] enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *attributes = @{NSFontAttributeName : TitleNormalFont};
        if (idx == _selectedIndex) {
            attributes = @{NSFontAttributeName : TitleSelectedFont};
        }
        CGFloat titleItemWidth = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:attributes context:nil].size.width;
        UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [titleBtn addTarget:self action:@selector(onIndexClickWithSender:) forControlEvents:UIControlEventTouchUpInside];
        titleBtn.frame = CGRectMake(currentXpos, 0,titleItemWidth, 44);
        [titleBtn setTitle:title forState:UIControlStateNormal];
        titleBtn.tag = NavigationTagBase + idx;
        titleBtn.titleLabel.font = TitleNormalFont;
        [titleBtn setTitleColor:TitleNormalColor forState:UIControlStateNormal];
        [_buttonsContainer addSubview:titleBtn];
        if (idx == _selectedIndex) {//设置选中的Item
            titleBtn.titleLabel.font = TitleSelectedFont;
            [titleBtn setTitleColor:TitleSelectedColor forState:UIControlStateNormal];
            slideViewCenterX = titleBtn.center.x;
            slideViewWidth = titleItemWidth;
        }
        currentXpos += CGRectGetWidth(titleBtn.bounds) + ButtonMargin;
        if (self.titlesArray.count>1)
        {
            UIView *slideView = [[UIView alloc] initWithFrame:CGRectMake(0, 41.5, slideViewWidth, 5/2.0)];
            slideView.center = CGPointMake(slideViewCenterX, slideView.center.y);
            slideView.backgroundColor = SlideViewColor;
            slideView.tag = SlideViewTag;
            [_buttonsContainer addSubview:slideView];
        }
        self.frame =  CGRectMake(0, 0, currentXpos - ButtonMargin, 44);
        self.center = CGPointMake(CGRectGetMidX([UIScreen mainScreen].bounds), 22);
        _buttonsContainer.frame = self.bounds;
        [self addSubview:_buttonsContainer];

        
    }];
}

- (void)updateUIWithIndex:(NSInteger)index callback:(void(^)(BOOL success))callback {
    UIView *slideView = [self viewWithTag:SlideViewTag];
    if (slideView) {
        if (_selectedIndex == index) {
            if (callback) {
                callback(NO);
            }
            return;
        }
        //还原之前的选中状态
        UIButton *oldSelectedBtn = [self viewWithTag:NavigationTagBase + _selectedIndex];
        oldSelectedBtn.titleLabel.font = TitleNormalFont;
        [oldSelectedBtn setTitleColor:TitleNormalColor forState:UIControlStateNormal];
        
        //设置当前选中
        UIButton *newSelectedBtn = [self viewWithTag:NavigationTagBase + index];
        newSelectedBtn.titleLabel.font = TitleSelectedFont;
        [newSelectedBtn setTitleColor:TitleSelectedColor forState:UIControlStateNormal];
        
        _selectedIndex = index;
        if (callback) {
            callback(YES);
        }
        
        [UIView animateWithDuration:.3f delay:0 usingSpringWithDamping:2 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseIn animations:^{
            slideView.center = CGPointMake(newSelectedBtn.center.x, slideView.center.y);
        } completion:^(BOOL finished) {
        }];
    }
}


- (void)onIndexClickWithSender:(UIButton *)button{
    NSInteger senderIndex = button.tag - NavigationTagBase;
    [self updateUIWithIndex:senderIndex callback:^(BOOL success) {
        if (success) {
            if (self.delegate &&[self.delegate respondsToSelector:@selector(selectedItemAtIndex:)]) {
                [self.delegate selectedItemAtIndex:senderIndex];
            }
        }
    }];

}

@end
