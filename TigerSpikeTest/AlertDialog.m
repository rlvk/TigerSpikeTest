//
//  AlertDialog.m
//  TigerSpikeTest
//
//  Created by Rafal Wesolowski on 19/03/2015.
//  Copyright (c) 2015 Raf. All rights reserved.
//

#import "AlertDialog.h"

@implementation AlertDialog
+ (void)showAlertDialogWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelTitle {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:cancelTitle
                                          otherButtonTitles:nil];
    [alert show];
}

+ (void)showAlertViewWithInfo:(NSString *)text {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:text message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    alertView.userInteractionEnabled = YES;
    [alertView show];
}
@end
