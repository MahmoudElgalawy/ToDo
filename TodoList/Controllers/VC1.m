
#import "VC1.h"
#import "addandedit.h"
#import "NSUserDefaults+mycat.h"
@interface VC1 ()
@property addandedit *vc;
@property NSUserDefaults* defaults;
@property NSMutableArray<Notes*>*filterd;
@property NSMutableArray<Notes*>* todoes;
@property bool isfilterd;
@property (weak, nonatomic) IBOutlet UISearchBar *searcher;
@end
@implementation VC1
- (void)viewDidLoad {
    [super viewDidLoad];
    _tableViewVc1.delegate = self;
    _tableViewVc1.dataSource = self;
    _defaults=[NSUserDefaults standardUserDefaults];
    _isfilterd = NO;
    _searcher.placeholder = @"search";
    _searcher.delegate = self;
}
- (void)viewWillAppear:(BOOL)animated{
    _mytodoes1=[_defaults TodosForKey:@"todos"];
    if(_mytodoes1 == NULL){
        _mytodoes1 = [NSMutableArray new];}
    [self initnavigationController];
    [self createTodoArr];
    [_tableViewVc1 reloadData];}
-(void)createTodoArr{
    _todoes = [NSMutableArray new];
    for(Notes* item in _mytodoes1){
        if([item.type isEqual:@0]){
            [_todoes addObject:item];}
    }
}
-(void)initnavigationController{
    self.tabBarController.navigationItem.title = @"All Todoes";
    self.tabBarController.navigationItem.rightBarButtonItem = [UIBarButtonItem.alloc initWithImage:[UIImage systemImageNamed:@"plus"] style: UIBarButtonItemStylePlain target:self action:@selector(newtodo)] ;
    self.tabBarController.navigationItem.rightBarButtonItem.tintColor = UIColor.blackColor;
}
-(void)newtodo{
    addandedit *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"addandedit"];
    vc.isCreating = YES;
    [vc setSegmented];
    if(vc.segmentPriority.selectedSegmentIndex ==1){
        vc.imgpriorty.image = [UIImage imageNamed:@"1"];}
    [self.tabBarController.navigationController pushViewController:vc animated:YES];}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(_isfilterd){
        return _filterd.count;}
    return _todoes.count;}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    if(_isfilterd){
        cell.textLabel.text = _filterd[indexPath.row].name;
        switch ([_filterd[indexPath.row].priorty intValue]) {
            case 0:
                cell.imageView.image = [UIImage imageNamed:@"0"];
                break;
            case 1:
                cell.imageView.image = [UIImage imageNamed:@"1"];
                break;

            case 2:
                cell.imageView.image = [UIImage imageNamed:@"2"];
                break;}

        return cell;
        }else{
        cell.textLabel.text = _todoes[indexPath.row].name;
        switch ([_todoes[indexPath.row].priorty intValue]) {
            case 0:
                cell.imageView.image = [UIImage imageNamed:@"0"];
                break;
            case 1:
                cell.imageView.image = [UIImage imageNamed:@"1"];
                break;

            case 2:
                cell.imageView.image = [UIImage imageNamed:@"2"];
                break;}
        }
    return cell;
}
- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath{
    UIContextualAction *delete = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"delete" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        
        NSNumber* i = @([self.mytodoes1 indexOfObject:self->_todoes[indexPath.row]]);
        [self.mytodoes1 removeObjectAtIndex:i.intValue];
        [self.todoes removeObjectAtIndex:indexPath.row];
        [self.tableViewVc1 beginUpdates];
        [self.tableViewVc1 deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableViewVc1 endUpdates];
        [self.defaults setTodos:self.mytodoes1 ForKey:@"todos"];
        //[self->_tableViewVc1 reloadData];
        completionHandler(YES);
    }];
    UIContextualAction *edit = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:@"Edit" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        
        addandedit *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"addandedit"];
        NSNumber* i = @([self.mytodoes1 indexOfObject:self->_todoes[indexPath.row]]);
        vc.index = i.intValue;
        [vc setSegmented2];
        [self.navigationController pushViewController:vc animated:YES];
        
    }];
    return [UISwipeActionsConfiguration configurationWithActions:@[delete,edit]];
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if(searchText.length == 0){
        _isfilterd = NO;
    }else{
        _isfilterd = YES;
        _filterd = [[NSMutableArray alloc] init];
        for(Notes *todo in _mytodoes1){
            NSRange r = [todo.name rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if(r.location != NSNotFound){
                [_filterd addObject:todo];
            }
        }
    }[self.tableViewVc1 reloadData];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
@end

