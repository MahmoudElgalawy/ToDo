

#import "NSUserDefaults+mycat.h"

@implementation NSUserDefaults (CustomTodo)
- (nonnull NSMutableArray<Notes *> *) TodosForKey:(NSString *)key{
    NSError *error = nil;
    NSData *archivedData = [self objectForKey:key];
    NSSet *set = [NSSet setWithArray:@[[NSMutableArray class],[Notes class]]];
    
    NSMutableArray<Notes*>* todos = [NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:archivedData error:&error];
    return todos;
    
}

- (void)setTodos:(nonnull NSMutableArray<Notes *> *)todos ForKey:(nonnull NSString *)key {
    NSError *error = nil;
    NSData *archivedData = [NSKeyedArchiver archivedDataWithRootObject:todos requiringSecureCoding:YES error:&error];
        [self setObject:archivedData forKey:key];
         [self synchronize];
}
@end
