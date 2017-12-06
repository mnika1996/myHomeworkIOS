//
//  MVMProgressView.h
//  URLsession
//
//  Created by Вероника on 30.11.17.
//  Copyright © 2017 Вероника. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MVMProgressView : UIView

@property (nonatomic, assign) CGFloat progress;

-(void)setProgress:(CGFloat)progress;
-(instancetype)initWithFrame:(CGRect)frame;

-(void)startAnimation;
-(void)stopAnimation;

@end
