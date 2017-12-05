//
//  TouchView.h
//  TestVC
//
//  Created by Вероника on 11.11.17.
//  Copyright © 2017 Вероника. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TouchView : UIView
    -(void)increaseStep;
    -(void)decreaseStep;
    -(void)increaseAlpha;
    -(void)decreaseAlpha;
-(instancetype)initWithFrame:(CGRect)frame AndWithLabel:(UILabel *) labelAlpha AndLabelStep: (UILabel *) labelStep;
@end
