//
//  ULDropDownTextField.h
//  uluGameSDK
//
//  Created by Wangshu Zhu on 2019/2/12.
//  Copyright © 2019 ulugame. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN



/**
 drop down view inspired by iosdropdown & netease game sdk
 */
@interface WZDropDownView : UIView


/**
 chosen index
 */
@property (nonatomic) NSInteger selectedIndex;


/**
 self-defined row height
 */
@property (nonatomic) IBInspectable CGFloat rowHeight;


/**
 self-defined list height
 */
@property (nonatomic) IBInspectable CGFloat listHeight;


/**
 self-defined arrow size
 */
@property (nonatomic) IBInspectable CGFloat arrowSize;


/**
 pass in an array of nsinteger to represent the id of eache item in list
 */
@property (strong, nonatomic) NSArray *optionIDs;


/**
 set row background color
 */
@property (strong, nonatomic) IBInspectable UIColor *rowBackgroundColor;


/**
 pass in the items to be selected from.
 It must be a list of Dictionarys with params of:
 @"name" : a NSString represents the user name
 @"lastLogin" : a NSString represents the user's last login time
 @"logo" : a UIImage object represents the login type logo.
 */
@property (strong, nonatomic) NSArray *optionArray;


/**
 call this method to pass in the callback block

 @param callbackBlock a call back block to be called when user selects item in drop down menu
        with parameters of selected index which is the "name" attribute in the dictionary,
        the index that is the indexpath.row attribute and the identifier that is the optionIDs
        you passed in.
 */
- (void)didSelect:(void (^)(NSString *selectedText, NSInteger index, NSInteger identifier))callbackBlock;

@end

NS_ASSUME_NONNULL_END
