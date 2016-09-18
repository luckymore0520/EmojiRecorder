#import <Foundation/Foundation.h>

@interface DollarPointCloud : NSObject<NSCoding>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSArray *points;
@property (nonatomic, strong) NSArray *originPoints;
- (id)initWithName:(NSString *)aName points:(NSArray *)somePoints;

@end