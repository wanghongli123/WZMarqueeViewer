//
//  AlertProgress.m
//  ZengQiangHaoMa
//
//  Created by apple on 11-12-13.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "AlertProgress.h"

@implementation AlertProgress

static id shared = nil;

+(id)sharedAlertProgress{
    if (shared == nil) {
        shared = [[AlertProgress alloc] init];
    }
    return shared;
}

-(void)showAlertWithMessage:(NSString*)msg{
    if ([NSThread isMainThread]) {
        if (alertView == nil) {
            alertView = [[UIAlertView alloc] initWithTitle:msg message:@"" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
            [alertView show];
            
            UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            [activityView setCenter:CGPointMake(alertView.bounds.size.width/2, alertView.bounds.size.height/2+15)];
            [alertView addSubview:activityView];
            [activityView startAnimating];
        }
    }
    else {
        [self performSelectorOnMainThread:@selector(showAlertWithMessage:) withObject:msg waitUntilDone:YES];
    }
}

-(void)closeAlert{
    if ([NSThread isMainThread]) {
        if (alertView) {
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
            alertView = nil;
        }
    }
    else {
        [self performSelectorOnMainThread:@selector(closeAlert) withObject:nil waitUntilDone:YES];
    }
}


static UIAlertView *alertMsgbox = nil;

-(void)messageBoxWithConfirm:(NSString*)msg{
    if (alertMsgbox) return;
    if ([NSThread isMainThread]) {
        if ([msg length] > 50) {
            alertMsgbox = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil];
            [alertMsgbox setDelegate:self];
            [alertMsgbox show];
        }
        else {
            alertMsgbox = [[UIAlertView alloc] initWithTitle:msg message:nil delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil];
            [alertMsgbox setDelegate:self];
            [alertMsgbox show];
        }
    }
    else {
        [self performSelectorOnMainThread:@selector(messageBoxWithConfirm:) withObject:msg waitUntilDone:YES];
    }
}

-(void)alertView:(UIAlertView *)alert didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (alert == alertMsgbox) {
        alertMsgbox = nil;
    }
}

- (void)showAutoDismissMessage:(NSString*)msg time:(float)time{
    UIAlertView *autoAlertView = [[UIAlertView alloc] initWithTitle:msg message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [autoAlertView show];
    [autoAlertView performSelector:@selector(dismissWithClickedButtonIndex:animated:) withObject:nil afterDelay:time<=0?0.3:time];
}

@end
