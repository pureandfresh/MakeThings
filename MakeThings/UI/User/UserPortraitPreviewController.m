//
//  UserPortraitPreviewController.m
//  MakeThings
//
//  Created by Jing Ye on 22/05/2018.
//  Copyright © 2018 aiwen. All rights reserved.
//

#import "UserPortraitPreviewController.h"
#import "UIImage+Extension.h"


@interface UserPortraitPreviewController ()<
UIActionSheetDelegate,
UINavigationControllerDelegate,
UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *portraitImageView;
@property (nonatomic) UIImage *portraitImage;
@end



@implementation UserPortraitPreviewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"pubic_arrow_left"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonClicked:)];
    if (self.portraitImage) {
        self.portraitImageView.image = self.portraitImage;
    }

    
}

- (void)rightBarButtonClicked:(UIBarButtonItem *)sender{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册选图片", nil];
    sheet.tintColor = [UIColor blackColor];
    [sheet showInView:self.view];

}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self addCarema];
    }else if (buttonIndex == 1){
        [self openPicLibrary];
    }
}

- (void)addCarema {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:picker animated:YES completion:NULL];
        });
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"没有找到相机" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [alert show];
    }
}

- (void)openPicLibrary {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:picker animated:YES completion:NULL];
        });
    }
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *editImage = [info objectForKey:UIImagePickerControllerEditedImage];
    [self dismissViewControllerAnimated:YES completion:^{
        if (editImage) {
            self.portraitImageView.image = [editImage imageByScalingToSize:CGSizeMake(160, 160)];
        }
        
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

+ (void)pushToUserPortraitPreviewControllerWithImage:(UIImage *)portraitImage fromViewController:(UIViewController *)controller{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:UserStoryboard bundle:nil];
    UserPortraitPreviewController *vc = [storyboard instantiateViewControllerWithIdentifier:UserPortraitPreviewControllerID];
    vc.portraitImage = portraitImage;
    [controller.navigationController pushViewController:vc animated:YES];
}




@end
