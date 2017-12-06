//
//  ViewController.m
//  Flickr
//
//  Created by Вероника on 03.12.17.
//  Copyright © 2017 Вероника. All rights reserved.
//

#import "ViewController.h"
#import "NetworkService.h"
#import "MVMTableViewCell.h"

static NSString *const MVMTableViewCellIdentifier = @"MVMTableViewCell";

@interface ViewController () <NetworkServiceOutputProtocol, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NetworkService *networkService;

//@property (nonatomic, strong) UIImageView *imageView;

@property(nonatomic, strong) UISearchBar *searchBar;

@property(nonatomic, strong) NSMutableArray *photos;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.photos = [NSMutableArray array];
    
    [self prepareUI];
    self.networkService = [NetworkService new];
    self.networkService.output = self;
}


- (void)prepareUI
{
    self.tableView = [[UITableView alloc] initWithFrame: CGRectMake(0, 80, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 80)];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.tableView.backgroundColor = [UIColor colorWithRed:170.0f/255.0f green:185.0f/255.0f blue:207.0f/255.0f alpha:0.7f];
    [self.tableView registerClass:[MVMTableViewCell class] forCellReuseIdentifier:MVMTableViewCellIdentifier];
    
    [self.view addSubview:self.tableView];
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(5, 25, CGRectGetWidth(self.view.frame) - 10, 50)];
    self.searchBar.backgroundColor = [UIColor colorWithRed:134.0f/255.0f green:147.0f/255.0f blue:171.0f/255.0f alpha:1.0f];
    
    self.searchBar.delegate = self;
    [self.view addSubview:self.searchBar];
    
//    self.imageView = [[UIImageView alloc] initWithFrame:self.view.frame];
//    self.imageView.contentMode = UIViewContentModeCenter;
//    [self.view addSubview:self.imageView];
}


-(void)flickrLoadingIsDone:(NSArray *)photosURL
{
    for (int i=0; i<[photosURL count]; i++) {
        [self.networkService startImageLoadingWith:[photosURL objectAtIndex:i]];
    }
}

- (void)loadingIsDoneWithDataRecieved:(NSData *)dataRecieved
{
    [self.photos insertObject:dataRecieved atIndex:0];
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
    
    //[self.imageView setImage:[UIImage imageWithData:dataRecieved]];

}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.photos removeAllObjects];
    [self.tableView reloadData];
    [self.networkService configureUrlSessionWithParams:nil];
    [self.networkService findFlickrPhotoWithSearchString:searchBar.text];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.photos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MVMTableViewCellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:170.0f/255.0f green:185.0f/255.0f blue:207.0f/255.0f alpha:0.7f];
    MVMTableViewCell *imageCell = (id)cell;
    UIImage *helpImage = [UIImage imageWithData:[self.photos objectAtIndex:indexPath.row]];
    [imageCell.imageView setImage:helpImage];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [MVMTableViewCell cellHeightWith:[self.photos objectAtIndex:indexPath.row] WithWidth: CGRectGetWidth(self.view.frame) - 40];

    //return UITableViewAutomaticDimension;
    
}


@end
