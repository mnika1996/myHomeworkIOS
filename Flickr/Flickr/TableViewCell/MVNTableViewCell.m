//
//  MVNTableViewCell.m
//  Flickr
//
//  Created by Вероника on 03.12.17.
//  Copyright © 2017 Вероника. All rights reserved.
//

#import "MVNTableViewCell.h"
#import </Users/veronika/Desktop/studygit/SudyingGit/Externals/Masonry.framework/Headers/Masonry.h>

static const CGFloat MVMElementsOffset = 10.f;
@implementation MVNTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.imageView = [UIImageView new];
        self.imageView.backgroundColor = [UIColor orangeColor];
        [self.contentView addSubview:self.imageView];
        
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).with.offset(MVMElementsOffset);
            make.top.equalTo(self.contentView.mas_top).with.offset(MVMElementsOffset);
        }];

    }
    return self;
}

-(void)prepareForReuse
{
    [super prepareForReuse];
    self.imageView.image = nil;
}



@end
