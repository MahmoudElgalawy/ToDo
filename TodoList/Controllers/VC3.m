

#import "VC3.h"
#import "addandedit.h"
#import "NSUserDefaults+mycat.h"
@interface VC3 () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableViewVc3;
@property (strong, nonatomic) NSUserDefaults *defaults;
@property (strong, nonatomic) NSMutableArray<Notes*> *myTodos3;
@property (strong, nonatomic) NSMutableArray<Notes*> *lowPriorityTodos;
@property (strong, nonatomic) NSMutableArray<Notes*> *mediumPriorityTodos;
@property (strong, nonatomic) NSMutableArray<Notes*> *highPriorityTodos;
@property (assign, nonatomic) BOOL isFiltered;
@end

@implementation VC3

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableViewVc3.delegate = self;
    _tableViewVc3.dataSource = self;
    _defaults = [NSUserDefaults standardUserDefaults];
    _isFiltered = NO;}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _myTodos3 = [_defaults TodosForKey:@"todos"];
    if (!_myTodos3) {
        _myTodos3 = [NSMutableArray new];
    }
    [self initnavigation];
    [self applyFilter];
    [_tableViewVc3 reloadData];
}
- (void)initnavigation {
    self.tabBarController.navigationItem.title = @"Done";
    self.tabBarController.navigationItem.rightBarButtonItem = [UIBarButtonItem.alloc initWithImage:[UIImage systemImageNamed:@"line.3.horizontal.decrease.circle.fill"] style:UIBarButtonItemStylePlain target:self action:@selector(filterTapped)];
    self.tabBarController.navigationItem.rightBarButtonItem.tintColor = UIColor.blackColor;}

- (void)applyFilter {
    if (_isFiltered) {
        _lowPriorityTodos = [NSMutableArray new];
        _mediumPriorityTodos = [NSMutableArray new];
        _highPriorityTodos = [NSMutableArray new];
        for (Notes *item in _myTodos3) {
            if ([item.type isEqual:@2]) {
                switch ([item.priorty intValue]) {
                    case 0:
                        [_lowPriorityTodos addObject:item];
                        break;
                    case 1:
                        [_mediumPriorityTodos addObject:item];
                        break;
                    case 2:
                        [_highPriorityTodos addObject:item];
                        break;
                }
            }
        }
    } else {
        _lowPriorityTodos = [NSMutableArray new];
        for (Notes *item in _myTodos3) {
            if ([item.type isEqual:@2]) {
                [_lowPriorityTodos addObject:item];
            }
        }
    }
}

- (void)filterTapped {
    _isFiltered = !_isFiltered;
    [self applyFilter];
    [_tableViewVc3 reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _isFiltered ? 3 : 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_isFiltered) {
        switch (section) {
            case 0:
                return _lowPriorityTodos.count;
            case 1:
                return _mediumPriorityTodos.count;
            case 2:
                return _highPriorityTodos.count;
            default:
                return 0;
        }
    } else {
        return _lowPriorityTodos.count;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (_isFiltered) {
        switch (section) {
            case 0:
                return @"Low";
                break;
            case 1:
                return @"Medium";
                break;
            case 2:
                return @"High";
                break;
            default:
                return @"";
        }
    } else {
        return @"Done";
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell3"];
    if (!cell) {cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell3"];}
    Notes *note;
    if (_isFiltered) {
        switch (indexPath.section) {
            case 0:
                note = _lowPriorityTodos[indexPath.row];
                break;
            case 1:
                note = _mediumPriorityTodos[indexPath.row];
                break;
            case 2:
                note = _highPriorityTodos[indexPath.row];
                break;
            default:
                note = nil;
                break;}}
    else {
        note = _lowPriorityTodos[indexPath.row];
    }
    cell.textLabel.text = note.name;
    switch ([note.priorty intValue]) {
        case 0:
            cell.imageView.image = [UIImage imageNamed:@"0"];
            break;
        case 1:
            cell.imageView.image = [UIImage imageNamed:@"1"];
            break;
        case 2:
            cell.imageView.image = [UIImage imageNamed:@"2"];
            break;
    }
    return cell;
}
- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    Notes *note;
    if (_isFiltered) {
        switch (indexPath.section) {
            case 0:
                note = _lowPriorityTodos[indexPath.row];
                break;
            case 1:
                note = _mediumPriorityTodos[indexPath.row];
                break;
            case 2:
                note = _highPriorityTodos[indexPath.row];
                break;
            default:
                note = nil;
                break;}
    } else {
        note = _lowPriorityTodos[indexPath.row];
    }
    UIContextualAction *delete = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"Delete" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        [self->_myTodos3 removeObject:note];
        [self applyFilter];
        [self.tableViewVc3 reloadData];
        [self.defaults setTodos:self->_myTodos3 ForKey:@"todos"];
        completionHandler(YES);
    }];

    return [UISwipeActionsConfiguration configurationWithActions:@[delete]];
}

@end
