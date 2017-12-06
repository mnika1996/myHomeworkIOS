//
//  NetworkServiceProtocol.h
//  Flickr
//
//  Created by Вероника on 03.12.17.
//  Copyright © 2017 Вероника. All rights reserved.
//

@protocol NetworkServiceOutputProtocol <NSObject>
@optional

- (void)loadingIsDoneWithDataRecieved:(NSData *)dataRecieved;
- (void)flickrLoadingIsDone:(NSArray *)photosURL;

@end

@protocol NetworkServiceIntputProtocol <NSObject>
@optional

- (void)configureUrlSessionWithParams:(NSDictionary *)params;
- (void)startImageLoading;
- (void)startImageLoadingWith:(NSString *)string;

- (void)findFlickrPhotoWithSearchString:(NSString *)searcSrting;

@end
