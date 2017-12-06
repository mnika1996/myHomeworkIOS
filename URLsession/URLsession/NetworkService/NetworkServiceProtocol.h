//
//  NetworkServiceProtocol.h
//  URLsession
//
//  Created by Вероника on 03.12.17.
//  Copyright © 2017 Вероника. All rights reserved.
//

@protocol NetworkServiceOutputProtocol <NSObject>
@optional

- (void)loadingContinuesWithProgress:(double)progress;
- (void)loadingIsDoneWithDataRecieved:(NSData *)dataRecieved;

@end

@protocol NetworkServiceIntputProtocol <NSObject>
@optional

- (void)configureUrlSessionWithParams:(NSDictionary *)params;
- (void)startImageLoading;

- (BOOL)resumeNetworkLoading;
- (void)suspendNetworkLoading;

- (void)findFlickrPhotoWithSearchString:(NSString *)searcSrting;

@end
