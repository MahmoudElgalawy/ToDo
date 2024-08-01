

#import "addandedit.h"
#import "NSUserDefaults+mycat.h"

@interface addandedit ()
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmintType;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIButton *save;
@property (weak, nonatomic) IBOutlet UILabel *detailsheader;

@end

@implementation addandedit

- (void)viewDidLoad {
    [super viewDidLoad];
    _defaults = [NSUserDefaults standardUserDefaults];
    _todoes = [_defaults TodosForKey:@"todos"];
    _datePicker.minimumDate = NSDate.now;
    _imgpriorty.image = [UIImage imageNamed:@"0"];
    if(_isCreating){
        [self setSegmented];
        _segmintType.selectedSegmentIndex = 0;
        if(_todoes == NULL){
            _todoes=[NSMutableArray new];}}
    if(_isCreating == FALSE){
        _segmintType.selectedSegmentIndex = 2;
        [self setSegmented2];
        _titleTextField.text =_todoes[_index].name;
        _descriptionTextView.text =_todoes[_index].desc;
        _segmentPriority.selectedSegmentIndex = [_todoes[_index].priorty intValue];
        _segmintType.selectedSegmentIndex=[_todoes[_index].type intValue];
        _datePicker.date = _todoes[_index].date;}
    self.save.layer.cornerRadius = 10;}
- (void)viewWillAppear:(BOOL)animated{
    if(_segmentPriority.selectedSegmentIndex == 1){
        _imgpriorty.image = [UIImage imageNamed:@"1"];
    }else if(_segmentPriority.selectedSegmentIndex == 2){
        _imgpriorty.image = [UIImage imageNamed:@"2"];}}
- (IBAction)addBtn:(id)sender {
    if(_isCreating==YES){
        _datePicker.maximumDate = nil;
        _mytodo2 = [[Notes alloc] initWithName:_titleTextField.text WithDescription:_descriptionTextView.text WithPiriorty:@(_segmentPriority.selectedSegmentIndex) WithType:@(_segmintType.selectedSegmentIndex) WithDate:_datePicker.date];
        if([self.titleTextField.text  isEqual: @""]){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"invalid data!" message:@"You can't add todo without name!" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"Cancle" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:ok];
            [alert addAction:cancle];
            [self presentViewController:alert animated:YES completion:nil];
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"note" message:@"you will add new todo" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self.todoes addObject:self->_mytodo2];
                [self->_defaults setTodos:self->_todoes ForKey:@"todos"];
                [self.navigationController popViewControllerAnimated:YES];
            }];
            UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"Cancle" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:ok];
            [alert addAction:cancle];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }else if (_isCreating==NO){
        _mytodo1 = [[Notes alloc] initWithName:_titleTextField.text WithDescription:_descriptionTextView.text WithPiriorty:@(_segmentPriority.selectedSegmentIndex) WithType:@(_segmintType.selectedSegmentIndex) WithDate:_datePicker.date];
        [self.todoes removeObjectAtIndex:_index];
        [self.todoes insertObject:_mytodo1 atIndex:_index];
        [_defaults setTodos:_todoes ForKey:@"todos"];
        [self.navigationController popViewControllerAnimated:YES];}}
-(void) setSegmented{
        [_segmintType setEnabled:YES forSegmentAtIndex:0];
        [_segmintType setEnabled:NO forSegmentAtIndex:1];
        [_segmintType setEnabled:NO forSegmentAtIndex:2];}
-(void) setSegmented2{
    [_segmintType setEnabled:YES forSegmentAtIndex:1];
    [_segmintType setEnabled:YES forSegmentAtIndex:2];
    [_segmintType setEnabled:NO forSegmentAtIndex:0];}
-(void) setSegmented3{
    [_segmintType setEnabled:NO forSegmentAtIndex:0];
    [_segmintType setEnabled:NO forSegmentAtIndex:1];
    [_segmintType setEnabled:YES forSegmentAtIndex:2];}

@end
