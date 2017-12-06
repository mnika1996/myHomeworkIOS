//
//  MVMTableViewCell.h
//  Flickr
//
//  Created by Вероника on 03.12.17.
//  Copyright © 2017 Вероника. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MVMTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *flickrImageView;

+(CGFloat)cellHeightWith:(NSData *)data WithWidth:(CGFloat) width;
@end
