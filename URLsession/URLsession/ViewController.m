//
//  ViewController.m
//  URLsession
//
//  Created by Вероника on 03.12.17.
//  Copyright © 2017 Вероника. All rights reserved.
//

#import "ViewController.h"
#import "MVMProgressView.h"
#import "NetworkService.h"

@interface ViewController ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) MVMProgressView *MVMprogressView;

@property (nonatomic, strong) UIButton *cancelDownloadButton;
@property (nonatomic, strong) UIButton *resumeDownloadButton;

@property (nonatomic, strong) NetworkService *networkService;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //first part
//    NSURLSession *session = [NSURLSession sharedSession];
//    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:@"https://itunes.apple.com/search?term=apple&media=software"] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        if (!error)
//        {
//            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//            NSLog(@"%@", json);
//        }
//        else
//        {
//            NSLog(@"Error occured!");
//        }
//    }];
//
//    [dataTask resume];
    
    //second part
//    [self prepareUI];
//    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:self delegateQueue:nil];
//    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:[NSURL URLWithString:@"https://upload.wikimedia.org/wikipedia/commons/4/4e/Pleiades_large.jpg"]];
//    // http://is1.mzstatic.com/image/thumb/Purple2/v4/91/59/e1/9159e1b3-f67c-6c05-0324-d56f4aee156a/source/100x100bb.jpg
//    [downloadTask resume];
    
    //third part
    
    [self prepareUI];
    [self.MVMprogressView startAnimation];
    self.networkService = [NetworkService new];
    self.networkService.output = self;
    [self.networkService configureUrlSessionWithParams:nil];
    [self.networkService startImageLoading];
}


- (void)prepareUI
{
    self.imageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    self.imageView.contentMode = UIViewContentModeCenter;
    [self.view addSubview:self.imageView];
    
    self.progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    self.progressView.frame = CGRectMake(10, self.view.center.y, CGRectGetWidth(self.view.frame) - 20, 10);
    [self.view addSubview:self.progressView];
    
    self.MVMprogressView = [[MVMProgressView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.MVMprogressView];
    
    self.resumeDownloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.resumeDownloadButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.resumeDownloadButton setTitle:@"Запустить" forState:UIControlStateNormal];
    [self.resumeDownloadButton addTarget:self action:@selector(resumeDownloadAction) forControlEvents:UIControlEventTouchUpInside];
    self.resumeDownloadButton.frame = CGRectMake(10, CGRectGetHeight(self.view.frame) - 50, 100, 30);
    self.resumeDownloadButton.hidden = YES;
    [self.view addSubview:self.resumeDownloadButton];
    
    self.cancelDownloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancelDownloadButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.cancelDownloadButton setTitle:@"Остановить" forState:UIControlStateNormal];
    [self.cancelDownloadButton addTarget:self action:@selector(suspendDownLoadAction) forControlEvents:UIControlEventTouchUpInside];
    self.cancelDownloadButton.frame = CGRectMake(120, CGRectGetHeight(self.view.frame) - 50, 100, 30);
    [self.view addSubview:self.cancelDownloadButton];
    
}


- (void)resumeDownloadAction
{
    if ([self.networkService resumeNetworkLoading])
    {
        [self.MVMprogressView startAnimation];
        self.resumeDownloadButton.hidden = YES;
        self.cancelDownloadButton.hidden = NO;
    }
}

- (void)suspendDownLoadAction
{
    [self.networkService suspendNetworkLoading];
    [self.MVMprogressView stopAnimation];
    self.resumeDownloadButton.hidden = NO;
    self.cancelDownloadButton.hidden = YES;
}

//third part
- (void)loadingIsDoneWithDataRecieved:(NSData *)dataRecieved
{
    [self.MVMprogressView stopAnimation];
    [self.progressView setHidden:YES];
    [self.MVMprogressView setHidden:YES];
    [self.cancelDownloadButton setHidden:YES];
    [self.resumeDownloadButton setHidden:YES];
    [self.imageView setImage:[UIImage imageWithData:dataRecieved]];
}

- (void)loadingContinuesWithProgress:(double)progress
{
    self.progressView.progress = progress;
    [self.MVMprogressView setProgress:progress];
}



//second part
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    NSData *data = [NSData dataWithContentsOfURL:location];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.MVMprogressView stopAnimation];
        self.progressView.hidden = YES;
        [self.cancelDownloadButton setHidden:YES];
        [self.resumeDownloadButton setHidden:YES];
        
        [self.MVMprogressView setHidden:YES];
        self.imageView.image = [UIImage imageWithData:data];
    });
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    double progress = (double)totalBytesWritten / (double)totalBytesExpectedToWrite;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.progressView setProgress:progress];
        [self.MVMprogressView setProgress:progress];
    });
}
@end
