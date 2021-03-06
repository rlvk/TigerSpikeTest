//
//  AlertDialog.h
//  TigerSpikeTest
//
//  Created by Rafal Wesolowski on 19/03/2015.
//  Copyright (c) 2015 Raf. All rights reserved.
//

/*
 * Helper class for displaying some kind of dialogs
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AlertDialog : NSObject
+ (void)showAlertDialogWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelTitle;
+ (void)showAlertViewWithInfo:(NSString *)text;
@end
