//
//  MVMTableViewCell.m
//  Flickr
//
//  Created by Вероника on 03.12.17.
//  Copyright © 2017 Вероника. All rights reserved.
//

#import "MVMTableViewCell.h"
static const CGFloat MVMElementsOffset = 10.f;

@implementation MVMTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.flickrImageView= [UIImageView new];
        self.flickrImageView.translatesAutoresizingMaskIntoConstraints = NO;
        
        NSDictionary *views = @{@"flickrImageView": self.flickrImageView};
        
        [self.contentView addSubview:self.flickrImageView];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[flickrImageView]-|" options:0 metrics:nil views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[flickrImageView]-|" options:0 metrics:nil views:views]];
    }
    return self;
}

-(void)prepareForReuse
{
    [super prepareForReuse];
    
    self.flickrImageView.image = nil;
}

+(CGFloat)cellHeightWith:(NSData *)data WithWidth:(CGFloat) width
{
    
    UIImage *helpImage = [UIImage imageWithData:data];
    if (width < helpImage.size.width)
    {
        return (helpImage.size.height) * width / helpImage.size.width;
    }
    else
    {
        return helpImage.size.height;
    }
    //return (helpImage.size.height);
    
}
@end
