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
@end
