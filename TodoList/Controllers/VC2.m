

#import "VC2.h"
#import "NSUserDefaults+mycat.h"
#import "addandedit.h"
@interface VC2 () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableViewVc2;
@property (strong, nonatomic) NSUserDefaults *defaults;
@property (strong, nonatomic) NSMutableArray<Notes*> *lowPriorityTodos;
@property (strong, nonatomic) NSMutableArray<Notes*> *mediumPriorityTodos;
@property (strong, nonatomic) NSMutableArray<Notes*> *highPriorityTodos;
@property (assign, nonatomic) BOOL filterClicked;
@end

@implementation VC2
- (void)viewDidLoad {
    [super viewDidLoad];
    _tableViewVc2.delegate = self;
    _tableViewVc2.dataSource = self;
    _defaults = [NSUserDefaults standardUserDefaults];}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _mytodoes2 = [_defaults TodosForKey:@"todos"];
    if (!_mytodoes2) {
        _mytodoes2 = [NSMutableArray new];    }
    [self initnavigationController];
    [self applyFilter];
    [_tableViewVc2 reloadData];}
- (void)initnavigationController {
    self.tabBarController.navigationItem.title = @"InProgress";
    self.tabBarController.navigationItem.rightBarButtonItem = [UIBarButtonItem.alloc initWithImage:[UIImage systemImageNamed:@"line.3.horizontal.decrease.circle.fill"] style:UIBarButtonItemStylePlain target:self action:@selector(filterTapped)];
    self.tabBarController.navigationItem.rightBarButtonItem.tintColor = UIColor.blackColor;}
- (void)applyFilter {
    if (_filterClicked) {
        _lowPriorityTodos = [NSMutableArray new];
        _mediumPriorityTodos = [NSMutableArray new];
        _highPriorityTodos = [NSMutableArray new];
        
        for (Notes *item in _mytodoes2) {
            if ([item.type isEqual:@1]) {  // Only consider in-progress todos
                switch ([item.priorty intValue]) {
                    case 0:
                        [_lowPriorityTodos addObject:item];
                        break;
                    case 1:
                        [_mediumPriorityTodos addObject:item];
                        break;
                    case 2:
                        [_highPriorityTodos addObject:item];
                        break;}}}} else {
        _lowPriorityTodos = [NSMutableArray new];
        for (Notes *item in _mytodoes2) {
            if ([item.type isEqual:@1]) {
                [_lowPriorityTodos addObject:item];}
        }
    }
}

- (void)filterTapped {
    _filterClicked = !_filterClicked;
    [self applyFilter];
    [_tableViewVc2 reloadData];}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _filterClicked ? 3 : 1;  }

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {if (_filterClicked) {
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
    if (_filterClicked) {
        switch (section) {
            case 0:
                return @"Low";
            case 1:
                return @"Medium";
            case 2:
                return @"High";
            default:
                return @"";
        }
    } else {
        return @"All Todoes";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell2"];}
    Notes *note;
    if (_filterClicked) {
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
                break;
        }
    } else {
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
            break;}
    return cell;}
- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    Notes *note;
    if (_filterClicked) {
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
        note = _lowPriorityTodos[indexPath.row];}
    UIContextualAction *delete = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"Delete" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        [self->_mytodoes2 removeObject:note];
        [self applyFilter];
        [self.tableViewVc2 reloadData];
        [self.defaults setTodos:self->_mytodoes2 ForKey:@"todos"];
        completionHandler(YES);
    }];
    UIContextualAction *edit = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:@"Edit" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        addandedit *v = [self.storyboard instantiateViewControllerWithIdentifier:@"addandedit"];
        NSNumber *i = @([self->_mytodoes2 indexOfObject:note]);
        v.index = i.intValue;
        [v setSegmented2];
        [self.navigationController pushViewController:v animated:YES];
    }];
    return [UISwipeActionsConfiguration configurationWithActions:@[delete, edit]];
}

@end
