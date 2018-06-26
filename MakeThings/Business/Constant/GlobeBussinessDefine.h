//
//  GlobeBussinessDefine.h
//  MakeThings
//
//  Created by Jing Ye on 07/05/2018.
//  Copyright © 2018 aiwen. All rights reserved.
//

#ifndef GlobeBussinessDefine_h
#define GlobeBussinessDefine_h

/************************/
#define RegisterViewControllerID @"RegisterViewController"
#define SetPasswordViewControllerID  @"SetPasswordViewController"
#define SupplementInfoViewControllerID  @"SupplementInfoViewController"
#define LoginViewControllerID   @"LoginViewController"
#define RegisterStoryboardName  @"RegisterLogin"
#define UserViewControllerName   @"UserViewController"
#define MainTabBarViewControllerID @"MainTabBarViewController"
#define UserViewControllerID @"UserViewController"
#define UserChangeInfoViewControllerID  @"UserChangeInfoViewController"
#define UserChangeInfoViewControllerNavi  @"UserChangeInfoViewControllerNavi"
#define UserPortraitPreviewControllerID @"UserPortraitPreviewController"
#define UserQRCodePreviewViewControllerID @"UserQRCodePreviewViewController"
#define UserGenderViewControllerID @"UserGenderViewController"
#define UserGenderViewControllerNavi @"UserGenderViewControllerNavi"
#define UserInfoAddAddressViewControllerID @"UserInfoAddAddressViewController"
#define MainStoryboard @"Main"
#define UserStoryboard @"User"

/***********************/

#define UserPortraitCellID @"UserPortraitCell"
#define UserCommonCellID  @"UserCommonCell"
#define UserInfoCheckGenderCellID @"UserInfoCheckGenderCell"
#define UserInfoAddressCellID @"UserInfoAddressCell"
#define UserInfoAddAddressCellID @"UserInfoAddAddressCell"
#define UserInfoEditAddressViewControllerID  @"UserInfoEditAddressViewController"
#define UserInfoEditAddressViewControllerNavi  @"UserInfoEditAddressViewControllerNavi"

/**********************/
/*   */
typedef NS_ENUM(NSInteger,UserInfoRowType){
    UserInfoRowTypePortrait = 0,
    UserInfoRowTypeName,
    UserInfoRowTypePhoneNumber,
    UserInfoRowTypeQRCode,
    UserInfoRowTypeGender,
    UserInfoRowTypeRegion,
    UserInfoRowTypeSign,
    UserInfoRowTypeAddress
};


#endif /* GlobeBussinessDefine_h */
