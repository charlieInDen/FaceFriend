

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "Member.h"

@interface MasterViewController ()
{
    NSInteger totalMembers;
    NSArray<Member *> *memberArr;
}
@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   // NSAssert(false, @"See README.txt for instructions on how to complete this test.");
    totalMembers = [Member memberCount];
    NSRange range = NSMakeRange(0, totalMembers);
    memberArr = [Member membersInRange:range];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        Member *selectedMember = [self->memberArr objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
        DetailViewController *destViewController = segue.destinationViewController;
        destViewController.detailItem = selectedMember;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return totalMembers;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    Member *obj = memberArr[indexPath.row];
    cell.textLabel.text = obj.name;

    return cell;
}

@end
