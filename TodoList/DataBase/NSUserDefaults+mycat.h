
#import <Foundation/Foundation.h>
#import "Notes.h"
NS_ASSUME_NONNULL_BEGIN

@interface NSUserDefaults (mycat)
-(void)setTodos:(NSMutableArray< Notes*> *)todos ForKey:(NSString*)key;
-(NSMutableArray< Notes*> *)TodosForKey:(NSString*)key;
@end

NS_ASSUME_NONNULL_END
