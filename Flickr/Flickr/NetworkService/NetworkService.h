//
//  NetworkService.h
//  Flickr
//
//  Created by Вероника on 03.12.17.
//  Copyright © 2017 Вероника. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkServiceProtocol.h"

@interface NetworkService : NSObject<NetworkServiceIntputProtocol, NSURLSessionDelegate, NSURLSessionDownloadDelegate>

@property (nonatomic, weak) id<NetworkServiceOutputProtocol> output; 

@end

