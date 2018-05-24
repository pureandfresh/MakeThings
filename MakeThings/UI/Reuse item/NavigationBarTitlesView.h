//
//  NavigationBarTitlesView.h
//  MakeThings
//
//  Created by Jing Ye on 13/12/2017.
//  Copyright © 2017 aiwen. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, NavigationViewType) {
    NavigationViewTypeCustom = 0,
    NavigationViewTypeText,
};
@protocol NavigationBarTitlesViewDelegate <NSObject>

- (void)selectedItemAtIndex:(NSInteger)index;

@end

@interface NavigationBarTitlesView : UIView
@property (nonatomic,weak)id<NavigationBarTitlesViewDelegate> delegate;
- (instancetype)initWithFrame:(CGRect)frame titlesArray:(NSArray *)titlesArray;
@end
