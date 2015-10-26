//
//  MainTableViewController.m
//  Smile
//
//  Created by Apple on 10/15/15.
//  Copyright © 2015 cnbin. All rights reserved.
//
//易源笑话大全 http://apistore.baidu.com/apiworks/servicedetail/864.html

#import "MainTableViewController.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"
#import "MainTableViewCell.h"

static NSString *CellIdentifier = @"TableCellIdentifier";

@interface MainTableViewController () {
    
    int  pagenumber;
}

@end

@implementation MainTableViewController


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title =@"每天笑一笑";
    self.tableView.allowsSelection = YES;
    [self.tableView registerClass:[MainTableViewCell class]forCellReuseIdentifier:CellIdentifier];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44.0;
    
    self.titleArray = [NSMutableArray array];
    self.contentTextArray = [NSMutableArray array];
    self.timeArray = [NSMutableArray array];
    
    pagenumber= 1;
    [GlobalResource sharedInstance].page =@"1";
    NSString *httpUrl = @"http://apis.baidu.com/showapi_open_bus/showapi_joke/joke_text";
    NSString * httpArg = [[NSString alloc]initWithFormat: @"page=%@", [GlobalResource sharedInstance].page];
    [self request: httpUrl withHttpArg: httpArg];

    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshTableView)];

    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshTableView)];
 
}

-(void)refreshTableView {

    [GlobalResource sharedInstance].page = [NSString stringWithFormat:@"%d",++pagenumber];
    NSString *httpUrl = @"http://apis.baidu.com/showapi_open_bus/showapi_joke/joke_text";
    NSString * httpArg = [[NSString alloc]initWithFormat: @"page=%@", [GlobalResource sharedInstance].page];
    [self request: httpUrl withHttpArg: httpArg];

}

- (void)request:(NSString*)httpUrl withHttpArg:(NSString*)HttpArg  {
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, HttpArg];
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 1];
    [request setHTTPMethod: @"GET"];
    [request addValue: @"c33bdd6ad06c082a12a171edc323cc9a" forHTTPHeaderField: @"apikey"];
    NSURLConnection *connection = [[NSURLConnection alloc]
                                   initWithRequest:request delegate:self];
    
    if (connection) {
        self.receiveData = [NSMutableData data];
    }
}

- (void)connection: (NSURLConnection *)connection didReceiveData: (NSData *)data {
    
    [self.receiveData appendData:data];
}

- (void)connectionDidFinishLoading: (NSURLConnection*) connection {
    
   [MBProgressHUD hideHUDForView:self.view animated:YES];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:self.receiveData options:NSJSONReadingMutableLeaves error:nil];
    NSDictionary * dicBody = [dic objectForKey:@"showapi_res_body"];
    [self reloadView:dicBody];
}

//重新加载表视图
-(void)reloadView:(NSDictionary*)res
{
    self.contentArray = [res objectForKey:@"contentlist"];
    for (int i = 0; i< self.contentArray.count; i++) {
        
        //在头部插入数据
       // [self.contentAddArray insertObject:[[self.contentArray objectAtIndex:i]objectForKey:@"title"] atIndex:0];
        //在尾部添加数据
        [self.titleArray addObject:[[self.contentArray objectAtIndex:i]objectForKey:@"title"]];
        [self.contentTextArray addObject:[[self.contentArray objectAtIndex:i]objectForKey:@"text"]];
        [self.timeArray addObject:[[self.contentArray objectAtIndex:i]objectForKey:@"ct"]];
   }
    [self.tableView reloadData];
    // 拿到当前的下拉刷新控件，结束刷新状态
    [self.tableView.header endRefreshing];
    [self.tableView.footer endRefreshing];

}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(contentSizeCategoryChanged:)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIContentSizeCategoryDidChangeNotification
                                                  object:nil];
}

- (void)contentSizeCategoryChanged:(NSNotification *)notification {
   
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger row  = indexPath.row;
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.jokeTitle.text = [self.titleArray objectAtIndex:row];
    cell.jokeContent.text = [self.contentTextArray objectAtIndex:row];
    cell.jokeTime.text = [[self.timeArray objectAtIndex:row]substringToIndex:10];
    
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    return cell;
}

@end
