

#import "DetailViewController.h"
#import "FaceBoxer-Swift.h"
typedef void(^completionBlock)(void);

@interface DetailViewController () <PagingTableViewDelegate>
{
    NSMutableOrderedSet<NSString *> *memberList;
}
@property (weak, nonatomic) IBOutlet PagingTableView *tableView;

@end

@implementation DetailViewController

#pragma mark - Managing the detail item
static int i = 0;
- (void)viewDidLoad {
    [super viewDidLoad];
    memberList = [[NSMutableOrderedSet alloc] init];
    self.tableView.pagingDelegate = self;
    [self loadInitialData];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loadInitialData{
    i = 0;
    for (NSString *object in _detailItem.friends) {
        [memberList addObject:object];
    }
}
-(void)fetchMoreFriends:(completionBlock) handler {
    
    NSInteger count = memberList.count;
    if (i == count) {
        return;
    }
    while (i< count) {
        NSString *fetchedID = memberList[i];
        Member *obj = [Member memberWithId:fetchedID];
        for (NSString *object in obj.friends) {
            [memberList addObject:object];
        }
        i++;
    }
    handler();
}
#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return memberList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell2" forIndexPath:indexPath];
    NSString *idMem = memberList[indexPath.row];
    Member *obj = [Member memberWithId:idMem];
    cell.textLabel.text = obj.name;
    NSLog(@"%@",obj.name);
    return cell;
}

- (void)didPaginate:(PagingTableView * _Nonnull)tableView to:(NSInteger)page {
    
}

- (void)paginate:(PagingTableView * _Nonnull)tableView to:(NSInteger)page {
    self.tableView.isLoading = true;
    [self fetchMoreFriends:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            self.tableView.isLoading = false;
        });
    }];
}
@end
