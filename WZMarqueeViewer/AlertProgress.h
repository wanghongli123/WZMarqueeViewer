//
//  AlertProgress.h
//  ZengQiangHaoMa
//
//  Created by apple on 11-12-13.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlertProgress : NSObject <UIAlertViewDelegate> {
    UIAlertView *alertView;
}

+(id)sharedAlertProgress;

-(void)showAlertWithMessage:(NSString*)msg;
-(void)closeAlert;

-(void)messageBoxWithConfirm:(NSString*)msg;

- (void)showAutoDismissMessage:(NSString*)msg time:(float)time;

@end
