//
//  MTBaseViewController.h
//  MakeThings
//
//  Created by Jing Ye on 13/12/2017.
//  Copyright © 2017 aiwen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTBaseViewController : UIViewController

- (UIViewController *)getTargetViewControllerWithStoryboardName:(NSString *)storyboardName viewControllerIdentifier:(NSString *)identifier;


- (void)setBackBarButtonItemWithImage:(UIImage *)image;
@end
