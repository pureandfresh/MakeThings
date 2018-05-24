//
//  YYHud.m
//  Progress
//
//  Created by sihuan on 15/6/17.
//  Copyright (c) 2015年 sihuan. All rights reserved.
//

#import "YYHud.h"

static const CGFloat YYHudRadius = 5;
static const CGFloat YYHudDuration = 1.8;

static const CGFloat YYHudImageContainerCenterTopDefault = 15;
static const CGFloat YYHudImageContainerCenterTopWithStr = 10;

static const CGFloat YYHudImageContainerWidthDefault = 92;
static const CGFloat YYHudImageContainerWidthWithStr = 182;

@interface YYHud ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageContainerTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageContainerHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageContainerMinWidth;




@property (nonatomic, strong) NSTimer *fadeOutTimer;

//记录当前在多少界面展示
@property (nonatomic, assign) NSUInteger activityCount;

@property (nonatomic, copy) YYHudDismissCallback completionCallback;
@end

@implementation YYHud

+ (YYHud *)sharedInstance {
    static YYHud *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[YYHud alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:nil options:nil].firstObject;
    //self.translatesAutoresizingMaskIntoConstraints = NO;
    self.hudContainer.layer.cornerRadius = YYHudRadius;
    self.allowUserInteraction = YES;
    self.defaultMaskType = YYHudMaskTypeNone;
    return self;
}

- (void)layoutSubviews {
    self.frame = self.superview.bounds;
    [super layoutSubviews];
}

#pragma mark - Public

#pragma mark Config
+ (void)config:(void (^)(YYHud *))cofig {
    cofig([self sharedInstance]);
}

- (void)setHudBackgroundColor:(UIColor *)hudBackgroundColor {
    _hudContainer.backgroundColor = hudBackgroundColor;
}

- (void)setForegroundColor:(UIColor *)foregroundColor {
    _stringLabel.textColor = foregroundColor;
}

- (void)setFont:(UIFont *)font {
    _stringLabel.font = font;
}

- (void)setDefaultMaskType:(YYHudMaskType)defaultMaskType {
    _defaultMaskType = defaultMaskType;
    [self setTempMaskType:defaultMaskType];
}

- (void)setTempMaskType:(YYHudMaskType)tempMaskType {
    _allowUserInteraction = tempMaskType == YYHudMaskTypeNone ? YES : NO;
    self.backgroundColor = tempMaskType == YYHudDim ? [UIColor lightGrayColor] : [UIColor clearColor];
}

#pragma mark Show
- (YYHud *)showInView:(UIView *)superView image:(UIImage *)image str:(NSString *)str duration:(NSTimeInterval)duration maskType:(YYHudMaskType)maskType isText:(BOOL)isText {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setTempMaskType:maskType];
        self.userInteractionEnabled = !_allowUserInteraction;
        
        _stringLabel.text = str;
        _imageView.image = image;
        _activityCount++;
        
        //只显示文字
        if (isText) {
            [_imageContainer setHidden:YES];
            _imageContainerHeight.constant = 0;
            _imageContainerMinWidth.constant = YYHudImageContainerWidthWithStr;
            
        } else {
            //显示自定义图片，或者默认的转圈
            if (image) {
                [_progressView stopAnimating];
                [_progressView setHidden:YES];
            } else {
                [_progressView startAnimating];
                [_progressView setHidden:NO];
            }
            
            [_imageContainer setHidden:NO];
            
            //正中间
            _imageContainerTop.constant = str.length > 0 ? YYHudImageContainerCenterTopWithStr : YYHudImageContainerCenterTopDefault;
            _imageContainerHeight.constant = 50;
            _imageContainerMinWidth.constant = YYHudImageContainerWidthDefault;
        }
        
        
        if (!self.superview) {
            
            if (superView) {
                [superView addSubview:self];
            } else {
#pragma mark - 找到当前显示的window
//                UIWindow *keyWindow = [[UIApplication sharedApplication].delegate window];
//                [keyWindow addSubview:self];
                NSEnumerator *frontToBackWindows = [[UIApplication sharedApplication].windows reverseObjectEnumerator];
                for (UIWindow *window in frontToBackWindows) {
                    BOOL windowOnMainScreen = window.screen == [UIScreen mainScreen];
                    BOOL windowIsVisible = !window.hidden && window.alpha > 0;
                    BOOL windowLevelNormal = window.windowLevel == UIWindowLevelNormal;
                    
                    if (windowOnMainScreen && windowIsVisible && windowLevelNormal) {
                        [window addSubview:self];
                        break;
                    }
                }
            }
            
        } else {
            //Ensure that overlay will be exactly on top of rootViewController (which may be changed during runtime).
            [self.superview bringSubviewToFront:self];
        }
        
        if (duration != DISPATCH_TIME_FOREVER) {
            _fadeOutTimer = [NSTimer timerWithTimeInterval:duration target:self selector:@selector(dismiss) userInfo:nil repeats:NO];
            [[NSRunLoop mainRunLoop] addTimer:_fadeOutTimer forMode:NSRunLoopCommonModes];
        }
        
        [self showAnimation];
    });
    
    return self;
}

- (YYHud *)showImage:(UIImage *)image str:(NSString *)str duration:(NSTimeInterval)duration maskType:(YYHudMaskType)maskType {
    return [self showInView:nil image:image str:str duration:duration maskType:maskType isText:NO];
}

- (YYHud *)show:(NSString *)msg {
    return [self showImage:nil str:msg duration:DISPATCH_TIME_FOREVER maskType:YYHudMaskNoneInteractive];
}

- (YYHud *)showTip:(NSString *)msg duration:(NSTimeInterval)duration completion:(YYHudDismissCallback) callbcak {
    self.completionCallback = callbcak;
    return [self showImage:nil str:msg duration:duration maskType:YYHudMaskNoneInteractive];
}

- (YYHud *)showTip:(NSString *)msg duration:(NSTimeInterval)duration {
    return [self showInView:nil image:nil str:msg duration:duration maskType:YYHudMaskTypeNone isText:YES];
}

- (YYHud *)showSucess:(NSString *)msg {
    return [self showImage:[UIImage imageNamed:@"icon-success"] str:msg duration:YYHudDuration maskType:_defaultMaskType];
}

- (YYHud *)showError:(NSString *)msg {
    return [self showImage:[UIImage imageNamed:@"icon-error"] str:msg duration:YYHudDuration maskType:_defaultMaskType];
}

#pragma mark - Internal show & hide operations
- (void)showAnimation {
    
    //    self.hudContainer.transform = CGAffineTransformConcat(CGAffineTransformIdentity, CGAffineTransformMakeScale(1.5f, 1.5f));
    
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationCurveEaseOut | UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.hudContainer.transform = CGAffineTransformIdentity;
                         self.hudContainer.alpha = 1;
                         self.alpha = 1;
                     }
                     completion:^(BOOL finished){
                     }];
}

- (void)dismiss {
    self.activityCount = 0;
    
    [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionAllowUserInteraction animations:^{
        //self.hudContainer.transform = CGAffineTransformScale(_hudContainer.transform, 0.5, 0.5);
        self.hudContainer.alpha = 0;
        self.alpha = 0;
    } completion:^(BOOL finished) {
        self.hudContainer.alpha = 0;
        self.alpha = 0;
        [self.progressView stopAnimating];
        [self removeFromSuperview];
        if (self.completionCallback){
            self.completionCallback();
        }
    }];
}


#pragma mark - Pulic
/*
 显示到window上，并且只有一个YYProgressHUD实例
 */
+ (YYHud *)show:(NSString *)msg {
    return [[YYHud sharedInstance] show:msg];
}

+ (YYHud *)show:(NSString *)msg maskType:(YYHudMaskType)maskType {
    return [[YYHud sharedInstance] showInView:nil image:nil str:msg duration:DISPATCH_TIME_FOREVER maskType:maskType isText:NO];
}

+ (YYHud *)showTip:(NSString *)msg {
    return [[YYHud sharedInstance] showTip:msg duration:YYHudDuration];
}

+ (YYHud *)showTip:(NSString *)msg inView:(UIView *)view {

    return [[YYHud sharedInstance] showInView:view image:nil str:msg duration:YYHudDuration maskType:YYHudMaskTypeNone isText:YES];
}

+ (YYHud *)showTip:(NSString *)msg duration:(NSTimeInterval)duration {
    return [[YYHud sharedInstance] showTip:msg duration:duration];
}

+ (YYHud *)showSucess:(NSString *)msg {
    return [[YYHud sharedInstance] showSucess:msg];
}

+ (YYHud *)showError:(NSString *)msg {
    return [[YYHud sharedInstance] showError:msg];
}

+ (YYHud *)showInView:(UIView *)superView image:(UIImage *)image str:(NSString *)str duration:(NSTimeInterval)duration maskType:(YYHudMaskType)maskType {
    YYHud *hud = [[YYHud alloc] init];
    return [hud showInView:superView image:image str:str duration:duration maskType:maskType isText:NO];
}

+ (void)dismiss {
    [[YYHud sharedInstance] dismiss];
}

@end
