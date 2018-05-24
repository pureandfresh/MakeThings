//
//  MTBannerView.m
//  MakeThings
//
//  Created by Jing Ye on 08/01/2018.
//  Copyright © 2018 aiwen. All rights reserved.
//

#import "MTBannerView.h"
static NSString *kBannerViewPlaceHolderImage = @"banner_image";

@implementation MTBannerView

- (instancetype)initWithFrame:(CGRect)frame images:(NSArray *)images {
    NSArray *dataArray = [self buildImageData:images];
    self = [super initWithFrame:frame scrollDirection:ScrollDirectionLandscape images:dataArray];
    if (self) {
        [self configureView];
    }
    return self;
}
- (void)configureView {
    self.placeHoldImage = [UIImage imageNamed:kBannerViewPlaceHolderImage];
    [self setRollingDelayTime:4.0];
    [self setSquare:0];
    [self setPageControlStyle:PageStyle_Middle];
    [self showClose:NO];
    [self startRolling];
}
- (NSArray *)buildImageData:(NSArray *)models {
    NSMutableArray *dataArray = [NSMutableArray arrayWithCapacity:0];
    //  TODO
//    if (models && models.count>0) {
//        for (MLLADModel *model in models) {
//            NSDictionary *bannerDic = nil;
//            if (model.src) {
//                bannerDic =[NSDictionary dictionaryWithObjectsAndKeys:model.src, @"img_url", nil];
//                [dataArray addObject:bannerDic];
//            }
//        }
//    }
    if (dataArray.count == 1) {
        [dataArray addObject:dataArray.firstObject];
    }
    return dataArray.copy;
}
- (void)reloadBannerWithData:(NSArray *)images {
    NSArray *array = [self buildImageData:images];
    [super reloadBannerWithData:images];
    [self startRolling];
    if(images && images.count>1) {
        [self setPageControlStyle:PageStyle_Middle];
        [self refreshScrollView];
        [self scrollViewCanScroll:YES];
        [self startRolling];
    } else {
        [self setPageControlStyle:PageStyle_None];
        [self refreshScrollView];
        [self scrollViewCanScroll:NO];
        [self stopRolling];
    }
    
}

@end
